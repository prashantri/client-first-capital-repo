import { Controller, Get, Post, Patch, Param, Body, Query, UseGuards, Req } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ApiBearerAuth, ApiTags, ApiOperation } from '@nestjs/swagger';
import { ReferralService } from './referral.service';
import { Roles, CurrentUser } from '../../common/decorators';
import { RolesGuard } from '../../common/guards';
import { UserRole } from '../../common/enums';

@ApiTags('Referrals')
@ApiBearerAuth()
@UseGuards(AuthGuard('jwt'), RolesGuard)
@Controller('referrals')
export class ReferralController {
  constructor(private referralService: ReferralService) {}

  @Post()
  @Roles(UserRole.INTRODUCER)
  @ApiOperation({ summary: 'Create a new referral (introducer only)' })
  create(@Req() req: any, @Body() data: any) {
    const introducer = req.user;
    return this.referralService.create(
      { ...data, introducerId: introducer._id },
      { fullName: introducer.fullName, email: introducer.email },
    );
  }

  @Get('my')
  @Roles(UserRole.INTRODUCER)
  @ApiOperation({ summary: 'Get my referrals (introducer)' })
  getMyReferrals(@CurrentUser('_id') userId: string, @Query() query: any) {
    return this.referralService.findByIntroducer(userId, query);
  }

  @Get('my/stats')
  @Roles(UserRole.INTRODUCER)
  @ApiOperation({ summary: 'Get my referral stats (introducer)' })
  getMyStats(@CurrentUser('_id') userId: string) {
    return this.referralService.getIntroducerStats(userId);
  }

  @Get('advisor')
  @Roles(UserRole.ADVISOR)
  @ApiOperation({ summary: 'Get referrals assigned to me (advisor)' })
  getAdvisorReferrals(@CurrentUser('_id') userId: string) {
    return this.referralService.findByAdvisor(userId);
  }

  @Get()
  @Roles(UserRole.ADMIN)
  @ApiOperation({ summary: 'List all referrals (admin)' })
  findAll(@Query() query: any) {
    return this.referralService.findAll(query);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get referral by ID' })
  findOne(@Param('id') id: string) {
    return this.referralService.findById(id);
  }

  @Patch(':id')
  @Roles(UserRole.INTRODUCER, UserRole.ADVISOR, UserRole.ADMIN)
  @ApiOperation({ summary: 'Update referral status' })
  update(@Param('id') id: string, @Body() data: any) {
    return this.referralService.update(id, data);
  }
}
