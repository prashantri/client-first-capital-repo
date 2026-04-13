import { Controller, Get, Query, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ApiBearerAuth, ApiTags, ApiOperation, ApiQuery } from '@nestjs/swagger';
import { LeaderboardService } from './leaderboard.service';
import { Roles, CurrentUser } from '../../common/decorators';
import { RolesGuard } from '../../common/guards';
import { UserRole } from '../../common/enums';

@ApiTags('Leaderboard')
@ApiBearerAuth()
@UseGuards(AuthGuard('jwt'), RolesGuard)
@Controller('leaderboard')
export class LeaderboardController {
  constructor(private service: LeaderboardService) {}

  @Get()
  @Roles(UserRole.INTRODUCER, UserRole.ADMIN)
  @ApiOperation({ summary: 'Get leaderboard by period' })
  @ApiQuery({ name: 'periodType', required: true })
  @ApiQuery({ name: 'period', required: false })
  findByPeriod(@Query('periodType') periodType: string, @Query('period') period?: string) {
    return this.service.findByPeriod(periodType, period);
  }

  @Get('my')
  @Roles(UserRole.INTRODUCER)
  @ApiOperation({ summary: 'Get my rankings (introducer)' })
  getMyRankings(@CurrentUser('_id') userId: string) {
    return this.service.findByIntroducer(userId);
  }
}
