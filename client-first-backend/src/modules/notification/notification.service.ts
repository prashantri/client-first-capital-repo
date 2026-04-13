import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Notification } from '../../schemas/notification.schema';

@Injectable()
export class NotificationService {
  constructor(@InjectModel(Notification.name) private model: Model<Notification>) {}

  async findByUser(userId: string, query: { page?: number; limit?: number }) {
    const page = query.page || 1;
    const limit = query.limit || 20;
    const filter = { userId };
    const [data, total, unreadCount] = await Promise.all([
      this.model.find(filter).skip((page - 1) * limit).limit(limit).sort({ createdAt: -1 }),
      this.model.countDocuments(filter),
      this.model.countDocuments({ ...filter, isRead: false }),
    ]);
    return { data, total, unreadCount, page, limit, totalPages: Math.ceil(total / limit) };
  }

  async markAsRead(id: string, userId: string) {
    return this.model.findOneAndUpdate({ _id: id, userId }, { isRead: true, readAt: new Date() }, { new: true });
  }

  async markAllRead(userId: string) {
    return this.model.updateMany({ userId, isRead: false }, { isRead: true, readAt: new Date() });
  }

  async create(data: Partial<Notification>) { return this.model.create(data); }
}
