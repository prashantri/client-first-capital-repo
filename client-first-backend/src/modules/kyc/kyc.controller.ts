import { Controller, Get, Post, Patch, Param, Body, Query, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ApiBearerAuth, ApiTags, ApiOperation } from '@nestjs/swagger';
import { KycService } from './kyc.service';
import { Roles, CurrentUser } from '../../common/decorators';
import { RolesGuard } from '../../common/guards';
import { UserRole } from '../../common/enums';

@ApiTags('KYC')
@ApiBearerAuth()
@UseGuards(AuthGuard('jwt'), RolesGuard)
@Controller('kyc')
export class KycController {
  constructor(private service: KycService) {}

  @Get('my')
  @ApiOperation({ summary: 'Get my KYC application' })
  getMy(@CurrentUser('_id') userId: string) { return this.service.findByUser(userId); }

  @Post()
  @ApiOperation({ summary: 'Start KYC application' })
  create(@CurrentUser('_id') userId: string, @Body() data: any) { return this.service.create({ ...data, userId }); }

  @Patch(':id')
  @ApiOperation({ summary: 'Update KYC application' })
  update(@Param('id') id: string, @Body() data: any) { return this.service.update(id, data); }

  @Post(':id/submit')
  @ApiOperation({ summary: 'Submit KYC application for review' })
  submit(@Param('id') id: string) { return this.service.submit(id); }

  @Post(':id/review')
  @Roles(UserRole.ADMIN)
  @ApiOperation({ summary: 'Review KYC application (admin)' })
  review(@Param('id') id: string, @CurrentUser('_id') reviewerId: string, @Body() data: any) {
    return this.service.review(id, { ...data, reviewedBy: reviewerId });
  }

  @Get()
  @Roles(UserRole.ADMIN)
  @ApiOperation({ summary: 'List all KYC applications (admin)' })
  findAll(@Query() query: any) { return this.service.findAll(query); }

  @Get(':id')
  @Roles(UserRole.ADMIN)
  @ApiOperation({ summary: 'Get KYC application by ID (admin)' })
  findOne(@Param('id') id: string) { return this.service.findById(id); }
}
