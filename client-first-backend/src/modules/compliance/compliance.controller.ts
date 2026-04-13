import { Controller, Get, Post, Patch, Param, Query, Body, UseGuards, Request } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ApiTags, ApiBearerAuth } from '@nestjs/swagger';
import { RolesGuard } from '../../common/guards/roles.guard';
import { Roles } from '../../common/decorators/roles.decorator';
import { UserRole } from '../../common/enums';
import { ComplianceService } from './compliance.service';

@ApiTags('Compliance')
@ApiBearerAuth()
@UseGuards(AuthGuard('jwt'), RolesGuard)
@Controller('compliance')
export class ComplianceController {
  constructor(private readonly service: ComplianceService) {}

  @Get('my')
  @Roles(UserRole.ADVISOR)
  findMy(@Request() req: any) { return this.service.findByAdvisor(req.user.userId); }

  @Get()
  @Roles(UserRole.ADMIN)
  findAll(@Query('status') status?: string, @Query('page') page?: number, @Query('limit') limit?: number) {
    return this.service.findAll({ status, page, limit });
  }

  @Post()
  @Roles(UserRole.ADMIN)
  create(@Body() data: any) { return this.service.create(data); }

  @Patch(':id')
  @Roles(UserRole.ADMIN, UserRole.ADVISOR)
  update(@Param('id') id: string, @Body() data: any) { return this.service.update(id, data); }

  @Patch(':id/toggle')
  @Roles(UserRole.ADVISOR)
  toggleComplete(@Param('id') id: string) { return this.service.toggleComplete(id); }
}
