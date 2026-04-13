import { Controller, Get, Post, Patch, Param, Body, Query, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ApiBearerAuth, ApiTags, ApiOperation } from '@nestjs/swagger';
import { PortfolioService } from './portfolio.service';
import { Roles, CurrentUser } from '../../common/decorators';
import { RolesGuard } from '../../common/guards';
import { UserRole } from '../../common/enums';

@ApiTags('Portfolios')
@ApiBearerAuth()
@UseGuards(AuthGuard('jwt'), RolesGuard)
@Controller('portfolios')
export class PortfolioController {
  constructor(private service: PortfolioService) {}

  @Get('my')
  @Roles(UserRole.CUSTOMER)
  @ApiOperation({ summary: 'Get my portfolios (customer)' })
  getMy(@CurrentUser('_id') userId: string) { return this.service.findByCustomer(userId); }

  @Get('advisor')
  @Roles(UserRole.ADVISOR)
  @ApiOperation({ summary: 'Get client portfolios (advisor)' })
  getAdvisorPortfolios(@CurrentUser('_id') userId: string) { return this.service.findByAdvisor(userId); }

  @Get('advisor/stats')
  @Roles(UserRole.ADVISOR)
  @ApiOperation({ summary: 'Get AUM stats (advisor)' })
  getAdvisorStats(@CurrentUser('_id') userId: string) { return this.service.getAdvisorStats(userId); }

  @Get()
  @Roles(UserRole.ADMIN)
  @ApiOperation({ summary: 'List all portfolios (admin)' })
  findAll(@Query() query: any) { return this.service.findAll(query); }

  @Get(':id')
  @ApiOperation({ summary: 'Get portfolio by ID' })
  findOne(@Param('id') id: string) { return this.service.findById(id); }

  @Post()
  @Roles(UserRole.ADVISOR, UserRole.ADMIN)
  @ApiOperation({ summary: 'Create portfolio' })
  create(@Body() data: any) { return this.service.create(data); }

  @Patch(':id')
  @Roles(UserRole.ADVISOR, UserRole.ADMIN)
  @ApiOperation({ summary: 'Update portfolio' })
  update(@Param('id') id: string, @Body() data: any) { return this.service.update(id, data); }
}
