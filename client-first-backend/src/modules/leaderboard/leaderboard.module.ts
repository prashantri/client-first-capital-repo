import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { LeaderboardController } from './leaderboard.controller';
import { LeaderboardService } from './leaderboard.service';
import { LeaderboardEntry, LeaderboardEntrySchema } from '../../schemas/leaderboard-entry.schema';

@Module({
  imports: [MongooseModule.forFeature([{ name: LeaderboardEntry.name, schema: LeaderboardEntrySchema }])],
  controllers: [LeaderboardController],
  providers: [LeaderboardService],
  exports: [LeaderboardService],
})
export class LeaderboardModule {}
