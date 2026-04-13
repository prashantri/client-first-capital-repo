import { Controller, Get, Post, Patch, Param, Body, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ApiBearerAuth, ApiTags, ApiOperation } from '@nestjs/swagger';
import { ShareholdingService } from './shareholding.service';
import { Roles, CurrentUser } from '../../common/decorators';
import { RolesGuard } from '../../common/guards';
import { UserRole } from '../../common/enums';

@ApiTags('Shareholdings')
@ApiBearerAuth()
@UseGuards(AuthGuard('jwt'), RolesGuard)
@Controller('shareholdings')
export class ShareholdingController {
  constructor(private service: ShareholdingService) {}

  @Get('my')
  @Roles(UserRole.INVESTOR)
  @ApiOperation({ summary: 'Get my shareholdings (investor)' })
  getMy(@CurrentUser('_id') userId: string) { return this.service.findByInvestor(userId); }

  @Get()
  @Roles(UserRole.ADMIN)
  @ApiOperation({ summary: 'List all shareholdings (admin)' })
  findAll() { return this.service.findAll(); }

  @Post()
  @Roles(UserRole.ADMIN)
  @ApiOperation({ summary: 'Create shareholding (admin)' })
  create(@Body() data: any) { return this.service.create(data); }

  @Patch(':id')
  @Roles(UserRole.ADMIN)
  @ApiOperation({ summary: 'Update shareholding (admin)' })
  update(@Param('id') id: string, @Body() data: any) { return this.service.update(id, data); }
}
