import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { LeaderboardEntry } from '../../schemas/leaderboard-entry.schema';

@Injectable()
export class LeaderboardService {
  constructor(@InjectModel(LeaderboardEntry.name) private model: Model<LeaderboardEntry>) {}

  async findByPeriod(periodType: string, period?: string) {
    const filter: any = { periodType };
    if (period) filter.period = period;
    return this.model.find(filter).sort({ rank: 1 }).populate('introducerId', 'fullName profileImageUrl');
  }

  async findByIntroducer(introducerId: string) {
    return this.model.find({ introducerId }).sort({ periodType: 1, period: -1 });
  }

  async findAll() { return this.model.find().sort({ periodType: 1, rank: 1 }).populate('introducerId', 'fullName'); }
  async create(data: Partial<LeaderboardEntry>) { return this.model.create(data); }
  async update(id: string, data: Partial<LeaderboardEntry>) { return this.model.findByIdAndUpdate(id, data, { new: true }); }
}
