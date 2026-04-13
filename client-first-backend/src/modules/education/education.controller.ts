import { Controller, Get, Post, Patch, Param, Query, Body, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ApiTags, ApiBearerAuth } from '@nestjs/swagger';
import { RolesGuard } from '../../common/guards/roles.guard';
import { Roles } from '../../common/decorators/roles.decorator';
import { UserRole } from '../../common/enums';
import { EducationService } from './education.service';

@ApiTags('Education')
@Controller('education')
export class EducationController {
  constructor(private readonly service: EducationService) {}

  @Get('published')
  findPublished(@Query('category') category?: string, @Query('page') page?: number, @Query('limit') limit?: number) {
    return this.service.findPublished({ category, page, limit });
  }

  @Get(':id')
  findById(@Param('id') id: string) { return this.service.findById(id); }

  @Get()
  @UseGuards(AuthGuard('jwt'), RolesGuard)
  @Roles(UserRole.ADMIN)
  @ApiBearerAuth()
  findAll(@Query('page') page?: number, @Query('limit') limit?: number) {
    return this.service.findAll({ page, limit });
  }

  @Post()
  @UseGuards(AuthGuard('jwt'), RolesGuard)
  @Roles(UserRole.ADMIN)
  @ApiBearerAuth()
  create(@Body() data: any) { return this.service.create(data); }

  @Patch(':id')
  @UseGuards(AuthGuard('jwt'), RolesGuard)
  @Roles(UserRole.ADMIN)
  @ApiBearerAuth()
  update(@Param('id') id: string, @Body() data: any) { return this.service.update(id, data); }
}
