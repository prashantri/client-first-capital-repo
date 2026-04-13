import { Controller, Get, Post, Patch, Param, Body, Query, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ApiBearerAuth, ApiTags, ApiOperation } from '@nestjs/swagger';
import { MarketingService } from './marketing.service';
import { Roles } from '../../common/decorators';
import { RolesGuard } from '../../common/guards';
import { UserRole } from '../../common/enums';

@ApiTags('Marketing Assets')
@ApiBearerAuth()
@UseGuards(AuthGuard('jwt'), RolesGuard)
@Controller('marketing')
export class MarketingController {
  constructor(private service: MarketingService) {}

  @Get()
  @Roles(UserRole.INTRODUCER, UserRole.ADVISOR, UserRole.ADMIN)
  @ApiOperation({ summary: 'List marketing assets' })
  findAll(@Query() query: any) { return this.service.findAll(query); }

  @Get(':id')
  @ApiOperation({ summary: 'Get asset by ID' })
  findOne(@Param('id') id: string) { return this.service.findById(id); }

  @Post(':id/download')
  @ApiOperation({ summary: 'Track download' })
  download(@Param('id') id: string) { return this.service.incrementDownload(id); }

  @Post()
  @Roles(UserRole.ADMIN)
  @ApiOperation({ summary: 'Create asset (admin)' })
  create(@Body() data: any) { return this.service.create(data); }

  @Patch(':id')
  @Roles(UserRole.ADMIN)
  @ApiOperation({ summary: 'Update asset (admin)' })
  update(@Param('id') id: string, @Body() data: any) { return this.service.update(id, data); }
}
