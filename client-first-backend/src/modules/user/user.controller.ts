import { Controller, Get, Param, Patch, Body, Query, UseGuards, Req } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ApiBearerAuth, ApiTags, ApiOperation, ApiQuery, ApiBody } from '@nestjs/swagger';
import { UserService } from './user.service';
import { Roles } from '../../common/decorators';
import { RolesGuard } from '../../common/guards';
import { UserRole } from '../../common/enums';

@ApiTags('Users')
@ApiBearerAuth()
@UseGuards(AuthGuard('jwt'), RolesGuard)
@Controller('users')
export class UserController {
  constructor(private userService: UserService) {}

  @Patch('me/bank-details')
  @ApiOperation({ summary: 'Update own bank details' })
  @ApiBody({
    schema: {
      type: 'object',
      required: ['bankName', 'accountName', 'accountNumber'],
      properties: {
        bankName: { type: 'string', example: 'Emirates NBD' },
        accountName: { type: 'string', example: 'John Doe' },
        accountNumber: { type: 'string', example: '1234567890' },
        iban: { type: 'string', example: 'AE070331234567890123456', nullable: true },
      },
    },
  })
  updateBankDetails(@Req() req: any, @Body() body: { bankName: string; accountName: string; accountNumber: string; iban?: string }) {
    return this.userService.updateBankDetails(req.user._id.toString(), body);
  }

  @Get()
  @Roles(UserRole.ADMIN)
  @ApiOperation({ summary: 'List all users (admin only)' })
  @ApiQuery({ name: 'role', required: false })
  @ApiQuery({ name: 'status', required: false })
  @ApiQuery({ name: 'page', required: false })
  @ApiQuery({ name: 'limit', required: false })
  findAll(@Query() query: { role?: string; status?: string; page?: number; limit?: number }) {
    return this.userService.findAll(query);
  }

  @Get('stats')
  @Roles(UserRole.ADMIN)
  @ApiOperation({ summary: 'Get user dashboard stats (admin only)' })
  getStats() {
    return this.userService.getDashboardStats();
  }

  @Get(':id')
  @Roles(UserRole.ADMIN)
  @ApiOperation({ summary: 'Get user by ID' })
  findOne(@Param('id') id: string) {
    return this.userService.findById(id);
  }

  @Patch(':id')
  @Roles(UserRole.ADMIN)
  @ApiOperation({ summary: 'Update user (admin only)' })
  update(@Param('id') id: string, @Body() updateData: any) {
    return this.userService.update(id, updateData);
  }
}
