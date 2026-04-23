import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { KycApplication } from '../../schemas/kyc-application.schema';
import { User } from '../../schemas/user.schema';
import { MailService } from '../../mail/mail.service';
import { AuditLogService } from '../audit-log/audit-log.service';

const ALLOWED_DOC_TYPES = ['pan_card', 'aadhaar_front', 'aadhaar_back', 'address_proof', 'license_document'];
const MAX_FILE_SIZE = 5 * 1024 * 1024;

@Injectable()
export class KycService {
  constructor(
    @InjectModel(KycApplication.name) private model: Model<KycApplication>,
    @InjectModel(User.name) private userModel: Model<User>,
    private mailService: MailService,
    private auditLogService: AuditLogService,
  ) {}

  async findByUser(userId: string) { return this.model.findOne({ userId }).sort({ createdAt: -1 }); }

  async create(data: Partial<KycApplication>) {
    const app = await this.model.create(data);
    await this.userModel.findByIdAndUpdate(data.userId, { kycStatus: 'in_progress' });
    return app;
  }

  async submit(id: string) {
    const app = await this.model.findByIdAndUpdate(id, { status: 'submitted', submittedAt: new Date() }, { new: true });
    if (!app) throw new NotFoundException('KYC application not found');
    await this.userModel.findByIdAndUpdate(app.userId, { kycStatus: 'submitted' });
    return app;
  }

  async review(
    id: string,
    reviewData: {
      status: 'approved' | 'rejected';
      reviewedBy: string;
      reviewNotes?: string;
      rejectionReason?: string;
    },
    admin: { _id: string; fullName: string; email: string },
  ) {
    const update: any = {
      status: reviewData.status,
      reviewedBy: reviewData.reviewedBy,
      reviewedAt: new Date(),
      reviewNotes: reviewData.reviewNotes,
    };
    if (reviewData.status === 'approved') update.approvedAt = new Date();
    if (reviewData.status === 'rejected') update.rejectionReason = reviewData.rejectionReason;

    const app = await this.model.findByIdAndUpdate(id, update, { new: true });
    if (!app) throw new NotFoundException('KYC application not found');

    await this.userModel.findByIdAndUpdate(app.userId, {
      kycStatus: reviewData.status,
      ...(reviewData.status === 'approved' ? { status: 'active' } : {}),
    });

    // Send email notification to applicant
    if (reviewData.status === 'approved') {
      this.mailService.sendWelcomeEmail(app.email, app.fullName).catch(() => {});
    } else {
      const reason = reviewData.rejectionReason || reviewData.reviewNotes || 'No reason provided';
      this.mailService.sendRejectionEmail(app.email, app.fullName, reason).catch(() => {});
    }

    // Write audit log
    this.auditLogService.log({
      adminId: admin._id,
      adminName: admin.fullName,
      adminEmail: admin.email,
      action: reviewData.status,
      kycApplicationId: id,
      applicantName: app.fullName,
      applicantEmail: app.email,
      notes: reviewData.reviewNotes,
      rejectionReason: reviewData.rejectionReason,
    }).catch(() => {});

    return app;
  }

  async findAll(query: { status?: string; page?: number; limit?: number }) {
    const filter: any = {};
    if (query.status) filter.status = query.status;
    const page = Number(query.page) || 1;
    const limit = Number(query.limit) || 20;
    const [data, total] = await Promise.all([
      this.model.find(filter)
        .select('-documents.pan_card.data -documents.aadhaar_front.data -documents.aadhaar_back.data -documents.address_proof.data -documents.license_document.data')
        .skip((page - 1) * limit).limit(limit).sort({ createdAt: -1 }).populate('userId', 'fullName email role status'),
      this.model.countDocuments(filter),
    ]);
    return { data, total, page, limit, totalPages: Math.ceil(total / limit) };
  }

  async countPending() {
    return this.model.countDocuments({ status: 'submitted' });
  }

  async uploadDocument(id: string, documentType: string, file: Express.Multer.File) {
    if (!file) throw new BadRequestException('No file provided');
    if (!ALLOWED_DOC_TYPES.includes(documentType)) {
      throw new BadRequestException(`Invalid document type. Allowed: ${ALLOWED_DOC_TYPES.join(', ')}`);
    }
    if (file.size > MAX_FILE_SIZE) throw new BadRequestException('File size exceeds 5MB limit');

    const base64Data = file.buffer.toString('base64');
    const update = {
      [`documents.${documentType}`]: {
        fileName: file.originalname,
        mimeType: file.mimetype,
        data: base64Data,
        uploadedAt: new Date(),
      },
    };

    const app = await this.model.findByIdAndUpdate(id, { $set: update }, { new: true });
    if (!app) throw new NotFoundException('KYC application not found');

    const result = app.toObject() as any;
    if (result.documents) {
      for (const key of Object.keys(result.documents)) {
        if (result.documents[key]?.data) result.documents[key] = { ...result.documents[key], data: undefined };
      }
    }
    return result;
  }

  async getDocument(id: string, documentType: string) {
    const app = await this.model.findById(id);
    if (!app) throw new NotFoundException('KYC application not found');
    const docs = (app as any).documents;
    const doc = docs?.get?.(documentType) || docs?.[documentType];
    if (!doc || !doc.data) throw new NotFoundException('Document not found');
    return { fileName: doc.fileName, mimeType: doc.mimeType, data: Buffer.from(doc.data, 'base64') };
  }

  async findById(id: string) {
    return this.model.findById(id)
      .select('-documents.pan_card.data -documents.aadhaar_front.data -documents.aadhaar_back.data -documents.address_proof.data -documents.license_document.data')
      .populate('userId', 'fullName email role status');
  }

  async update(id: string, data: Partial<KycApplication>) { return this.model.findByIdAndUpdate(id, data, { new: true }); }
}
