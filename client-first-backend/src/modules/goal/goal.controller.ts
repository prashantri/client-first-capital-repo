import { Controller, Get, Post, Patch, Delete, Param, Body, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ApiBearerAuth, ApiTags, ApiOperation } from '@nestjs/swagger';
import { GoalService } from './goal.service';
import { Roles, CurrentUser } from '../../common/decorators';
import { RolesGuard } from '../../common/guards';
import { UserRole } from '../../common/enums';

@ApiTags('Goals')
@ApiBearerAuth()
@UseGuards(AuthGuard('jwt'), RolesGuard)
@Controller('goals')
export class GoalController {
  constructor(private service: GoalService) {}

  @Get('my')
  @Roles(UserRole.CUSTOMER)
  @ApiOperation({ summary: 'Get my goals (customer)' })
  getMy(@CurrentUser('_id') userId: string) { return this.service.findByCustomer(userId); }

  @Get(':id')
  @ApiOperation({ summary: 'Get goal by ID' })
  findOne(@Param('id') id: string) { return this.service.findById(id); }

  @Post()
  @Roles(UserRole.CUSTOMER)
  @ApiOperation({ summary: 'Create goal (customer)' })
  create(@CurrentUser('_id') userId: string, @Body() data: any) { return this.service.create({ ...data, customerId: userId }); }

  @Patch(':id')
  @Roles(UserRole.CUSTOMER)
  @ApiOperation({ summary: 'Update goal' })
  update(@Param('id') id: string, @Body() data: any) { return this.service.update(id, data); }

  @Delete(':id')
  @Roles(UserRole.CUSTOMER)
  @ApiOperation({ summary: 'Delete goal' })
  delete(@Param('id') id: string) { return this.service.delete(id); }
}
