import { Injectable, UnauthorizedException, ConflictException, BadRequestException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import * as bcrypt from 'bcrypt';
import { User } from '../schemas/user.schema';
import { KycApplication } from '../schemas/kyc-application.schema';
import { RegisterDto, LoginDto, IntroducerRegisterDto } from './dto/auth.dto';
import { MailService } from '../mail/mail.service';

interface OtpEntry {
  otp: string;
  expiresAt: Date;
}

@Injectable()
export class AuthService {
  private otpStore = new Map<string, OtpEntry>();

  constructor(
    @InjectModel(User.name) private userModel: Model<User>,
    @InjectModel(KycApplication.name) private kycModel: Model<KycApplication>,
    private jwtService: JwtService,
    private mailService: MailService,
  ) {}

  async register(dto: RegisterDto) {
    const existing = await this.userModel.findOne({ email: dto.email.toLowerCase() });
    if (existing) {
      throw new ConflictException('Email already registered');
    }

    const passwordHash = await bcrypt.hash(dto.password, 10);
    const fullName = `${dto.firstName} ${dto.lastName}`;

    const user = await this.userModel.create({
      email: dto.email.toLowerCase(),
      passwordHash,
      phone: dto.phone,
      fullName,
      firstName: dto.firstName,
      lastName: dto.lastName,
      role: dto.role,
      status: 'pending',
      kycStatus: 'not_started',
    });

    const token = this.generateToken(user);
    return { user: this.sanitizeUser(user), accessToken: token };
  }

  async login(dto: LoginDto) {
    const user = await this.userModel.findOne({ email: dto.email.toLowerCase() });
    if (!user) {
      throw new UnauthorizedException('Invalid credentials');
    }

    const isPasswordValid = await bcrypt.compare(dto.password, user.passwordHash);
    if (!isPasswordValid) {
      throw new UnauthorizedException('Invalid credentials');
    }

    if (user.status === 'suspended' || user.status === 'inactive') {
      throw new UnauthorizedException('Your account has been suspended. Please contact support.');
    }

    user.lastLoginAt = new Date();
    await user.save();

    const token = this.generateToken(user);
    return { user: this.sanitizeUser(user), accessToken: token };
  }

  async sendOtp(email: string): Promise<{ message: string }> {
    const otp = Math.floor(100000 + Math.random() * 900000).toString();
    const expiresAt = new Date(Date.now() + 10 * 60 * 1000);

    this.otpStore.set(email.toLowerCase(), { otp, expiresAt });
    await this.mailService.sendOtpEmail(email, otp);

    return { message: 'OTP sent to your email address' };
  }

  async verifyOtp(email: string, otp: string): Promise<{ verified: boolean }> {
    const entry = this.otpStore.get(email.toLowerCase());

    if (!entry) {
      throw new BadRequestException('No OTP found for this email. Please request a new one.');
    }
    if (entry.expiresAt < new Date()) {
      this.otpStore.delete(email.toLowerCase());
      throw new BadRequestException('OTP has expired. Please request a new one.');
    }
    if (entry.otp !== otp) {
      throw new BadRequestException('Invalid OTP. Please try again.');
    }

    return { verified: true };
  }

  async registerIntroducer(dto: IntroducerRegisterDto, licenseFile?: Express.Multer.File) {
    const existing = await this.userModel.findOne({ email: dto.email.toLowerCase() });
    if (existing) {
      throw new ConflictException('An account with this email already exists');
    }

    const nameParts = dto.fullName.trim().split(' ');
    const firstName = nameParts[0];
    const lastName = nameParts.length > 1 ? nameParts.slice(1).join(' ') : firstName;

    const passwordHash = await bcrypt.hash(dto.password, 10);

    const user = await this.userModel.create({
      email: dto.email.toLowerCase(),
      passwordHash,
      phone: dto.phone,
      fullName: dto.fullName,
      firstName,
      lastName,
      role: 'introducer',
      status: 'pending',
      kycStatus: licenseFile ? 'submitted' : 'not_started',
      company: dto.company,
      licenseNo: dto.licenseNo,
    });

    // Create KYC application and store the license document if uploaded
    if (licenseFile) {
      const MAX_FILE_SIZE = 5 * 1024 * 1024;
      if (licenseFile.size > MAX_FILE_SIZE) {
        await this.userModel.findByIdAndDelete(user._id);
        throw new BadRequestException('License document exceeds 5MB limit');
      }

      const base64Data = licenseFile.buffer.toString('base64');
      await this.kycModel.create({
        userId: user._id,
        fullName: dto.fullName,
        email: dto.email.toLowerCase(),
        phone: dto.phone,
        status: 'submitted',
        submittedAt: new Date(),
        documents: {
          license_document: {
            fileName: licenseFile.originalname,
            mimeType: licenseFile.mimetype,
            data: base64Data,
            uploadedAt: new Date(),
          },
        },
      });
    }

    this.otpStore.delete(dto.email.toLowerCase());

    return {
      message: 'Your introducer request is registered and will be acted upon in 24 hours.',
    };
  }

  async forgotPassword(email: string): Promise<{ message: string }> {
    const user = await this.userModel.findOne({ email: email.toLowerCase() });
    if (user) {
      const otp = Math.floor(100000 + Math.random() * 900000).toString();
      const expiresAt = new Date(Date.now() + 10 * 60 * 1000);
      this.otpStore.set(`reset_${email.toLowerCase()}`, { otp, expiresAt });
      this.mailService.sendPasswordResetEmail(email, otp, user.fullName).catch(() => {});
    }
    // Always return the same message to avoid email enumeration
    return { message: 'If an account with this email exists, a reset code has been sent.' };
  }

  async resetPassword(email: string, otp: string, newPassword: string): Promise<{ message: string }> {
    const key = `reset_${email.toLowerCase()}`;
    const entry = this.otpStore.get(key);

    if (!entry) throw new BadRequestException('No reset code found. Please request a new one.');
    if (entry.expiresAt < new Date()) {
      this.otpStore.delete(key);
      throw new BadRequestException('Reset code has expired. Please request a new one.');
    }
    if (entry.otp !== otp) throw new BadRequestException('Invalid reset code. Please try again.');

    const passwordHash = await bcrypt.hash(newPassword, 10);
    await this.userModel.findOneAndUpdate({ email: email.toLowerCase() }, { passwordHash });
    this.otpStore.delete(key);

    return { message: 'Password reset successfully. You can now log in with your new password.' };
  }

  async getProfile(userId: string) {
    const user = await this.userModel.findById(userId).select('-passwordHash');
    if (!user) {
      throw new UnauthorizedException('User not found');
    }
    return user;
  }

  private generateToken(user: User): string {
    const payload = { sub: user._id, email: user.email, role: user.role };
    return this.jwtService.sign(payload);
  }

  private sanitizeUser(user: User) {
    const obj = user.toObject();
    delete obj.passwordHash;
    return obj;
  }
}
