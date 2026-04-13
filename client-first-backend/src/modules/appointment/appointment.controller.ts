import { Controller, Get, Post, Patch, Param, Body, Query, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ApiBearerAuth, ApiTags, ApiOperation } from '@nestjs/swagger';
import { AppointmentService } from './appointment.service';
import { Roles, CurrentUser } from '../../common/decorators';
import { RolesGuard } from '../../common/guards';
import { UserRole } from '../../common/enums';

@ApiTags('Appointments')
@ApiBearerAuth()
@UseGuards(AuthGuard('jwt'), RolesGuard)
@Controller('appointments')
export class AppointmentController {
  constructor(private service: AppointmentService) {}

  @Get('customer')
  @Roles(UserRole.CUSTOMER)
  @ApiOperation({ summary: 'Get my appointments (customer)' })
  getCustomerAppointments(@CurrentUser('_id') userId: string) { return this.service.findByCustomer(userId); }

  @Get('advisor')
  @Roles(UserRole.ADVISOR)
  @ApiOperation({ summary: 'Get my schedule (advisor)' })
  getAdvisorAppointments(@CurrentUser('_id') userId: string) { return this.service.findByAdvisor(userId); }

  @Get()
  @Roles(UserRole.ADMIN)
  @ApiOperation({ summary: 'List all appointments (admin)' })
  findAll(@Query() query: any) { return this.service.findAll(query); }

  @Get(':id')
  @ApiOperation({ summary: 'Get appointment by ID' })
  findOne(@Param('id') id: string) { return this.service.findById(id); }

  @Post()
  @Roles(UserRole.CUSTOMER, UserRole.ADVISOR)
  @ApiOperation({ summary: 'Book appointment' })
  create(@Body() data: any) { return this.service.create(data); }

  @Patch(':id')
  @Roles(UserRole.CUSTOMER, UserRole.ADVISOR, UserRole.ADMIN)
  @ApiOperation({ summary: 'Update appointment' })
  update(@Param('id') id: string, @Body() data: any) { return this.service.update(id, data); }
}
