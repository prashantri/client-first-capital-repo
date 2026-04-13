import { Controller, Get, Post, Patch, Param, Body, Query, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ApiBearerAuth, ApiTags, ApiOperation } from '@nestjs/swagger';
import { CommissionService } from './commission.service';
import { Roles, CurrentUser } from '../../common/decorators';
import { RolesGuard } from '../../common/guards';
import { UserRole } from '../../common/enums';

@ApiTags('Commissions')
@ApiBearerAuth()
@UseGuards(AuthGuard('jwt'), RolesGuard)
@Controller('commissions')
export class CommissionController {
  constructor(private service: CommissionService) {}

  @Get('my')
  @Roles(UserRole.INTRODUCER)
  @ApiOperation({ summary: 'Get my commissions (introducer)' })
  getMy(@CurrentUser('_id') userId: string, @Query() query: any) {
    return this.service.findByIntroducer(userId, query);
  }

  @Get('my/summary')
  @Roles(UserRole.INTRODUCER)
  @ApiOperation({ summary: 'Get my commission summary (introducer)' })
  getMySummary(@CurrentUser('_id') userId: string) {
    return this.service.getIntroducerSummary(userId);
  }

  @Get()
  @Roles(UserRole.ADMIN)
  @ApiOperation({ summary: 'List all commissions (admin)' })
  findAll(@Query() query: any) { return this.service.findAll(query); }

  @Post()
  @Roles(UserRole.ADMIN)
  @ApiOperation({ summary: 'Create commission (admin)' })
  create(@Body() data: any) { return this.service.create(data); }

  @Patch(':id')
  @Roles(UserRole.ADMIN)
  @ApiOperation({ summary: 'Update commission (admin)' })
  update(@Param('id') id: string, @Body() data: any) { return this.service.update(id, data); }
}
