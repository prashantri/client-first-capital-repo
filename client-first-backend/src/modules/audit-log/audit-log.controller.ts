import { Controller, Get, Query, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ApiBearerAuth, ApiTags, ApiOperation, ApiQuery } from '@nestjs/swagger';
import { AuditLogService } from './audit-log.service';
import { Roles } from '../../common/decorators';
import { RolesGuard } from '../../common/guards';
import { UserRole } from '../../common/enums';

@ApiTags('Audit Logs')
@ApiBearerAuth()
@UseGuards(AuthGuard('jwt'), RolesGuard)
@Roles(UserRole.ADMIN)
@Controller('audit-logs')
export class AuditLogController {
  constructor(private service: AuditLogService) {}

  @Get()
  @ApiOperation({ summary: 'List all audit log entries (admin only)' })
  @ApiQuery({ name: 'action', required: false, enum: ['approved', 'rejected'] })
  @ApiQuery({ name: 'page', required: false })
  @ApiQuery({ name: 'limit', required: false })
  findAll(@Query() query: { page?: number; limit?: number; action?: string }) {
    return this.service.findAll(query);
  }
}
