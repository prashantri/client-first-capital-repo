import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { User } from '../../schemas/user.schema';

@Injectable()
export class UserService {
  constructor(@InjectModel(User.name) private userModel: Model<User>) {}

  async findAll(query: { role?: string; status?: string; page?: number; limit?: number }) {
    const filter: any = {};
    if (query.role) filter.role = query.role;
    if (query.status) filter.status = query.status;

    const page = query.page || 1;
    const limit = query.limit || 20;
    const skip = (page - 1) * limit;

    const [users, total] = await Promise.all([
      this.userModel.find(filter).select('-passwordHash').skip(skip).limit(limit).sort({ createdAt: -1 }),
      this.userModel.countDocuments(filter),
    ]);

    return { data: users, total, page, limit, totalPages: Math.ceil(total / limit) };
  }

  async findById(id: string) {
    return this.userModel.findById(id).select('-passwordHash');
  }

  async update(id: string, updateData: Partial<User>) {
    return this.userModel.findByIdAndUpdate(id, updateData, { new: true }).select('-passwordHash');
  }

  async findByRole(role: string) {
    return this.userModel.find({ role, status: 'active' }).select('-passwordHash');
  }

  async updateBankDetails(userId: string, bankDetails: { bankName: string; accountName: string; accountNumber: string; iban?: string }) {
    return this.userModel.findByIdAndUpdate(
      userId,
      { bankDetails },
      { new: true },
    ).select('-passwordHash');
  }

  async getDashboardStats() {
    const [totalUsers, byRole, byStatus] = await Promise.all([
      this.userModel.countDocuments(),
      this.userModel.aggregate([{ $group: { _id: '$role', count: { $sum: 1 } } }]),
      this.userModel.aggregate([{ $group: { _id: '$status', count: { $sum: 1 } } }]),
    ]);
    return { totalUsers, byRole, byStatus };
  }
}
