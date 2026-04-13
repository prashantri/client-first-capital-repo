import { Controller, Get, Post, Patch, Param, Body, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ApiBearerAuth, ApiTags, ApiOperation } from '@nestjs/swagger';
import { ValuationService } from './valuation.service';
import { Roles } from '../../common/decorators';
import { RolesGuard } from '../../common/guards';
import { UserRole } from '../../common/enums';

@ApiTags('Company Valuations')
@ApiBearerAuth()
@UseGuards(AuthGuard('jwt'), RolesGuard)
@Controller('valuations')
export class ValuationController {
  constructor(private service: ValuationService) {}

  @Get()
  @Roles(UserRole.INVESTOR, UserRole.ADMIN)
  @ApiOperation({ summary: 'Get all valuations' })
  findAll() { return this.service.findAll(); }

  @Get('latest')
  @Roles(UserRole.INVESTOR, UserRole.ADMIN)
  @ApiOperation({ summary: 'Get latest valuation' })
  findLatest() { return this.service.findLatest(); }

  @Post()
  @Roles(UserRole.ADMIN)
  @ApiOperation({ summary: 'Create valuation (admin)' })
  create(@Body() data: any) { return this.service.create(data); }

  @Patch(':id')
  @Roles(UserRole.ADMIN)
  @ApiOperation({ summary: 'Update valuation (admin)' })
  update(@Param('id') id: string, @Body() data: any) { return this.service.update(id, data); }
}
