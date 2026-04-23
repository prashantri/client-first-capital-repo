import { Controller, Get, Post, Patch, Param, Body, Query, Res, Req, UseGuards, UseInterceptors, UploadedFile } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { FileInterceptor } from '@nestjs/platform-express';
import { ApiBearerAuth, ApiTags, ApiOperation, ApiConsumes } from '@nestjs/swagger';
import { Response } from 'express';
import { KycService } from './kyc.service';
import { Roles, CurrentUser } from '../../common/decorators';
import { RolesGuard } from '../../common/guards';
import { UserRole } from '../../common/enums';

@ApiTags('KYC')
@ApiBearerAuth()
@UseGuards(AuthGuard('jwt'), RolesGuard)
@Controller('kyc')
export class KycController {
  constructor(private service: KycService) {}

  @Get('my')
  @ApiOperation({ summary: 'Get my KYC application' })
  getMy(@CurrentUser('_id') userId: string) { return this.service.findByUser(userId); }

  @Post()
  @ApiOperation({ summary: 'Start KYC application' })
  create(@CurrentUser('_id') userId: string, @Body() data: any) { return this.service.create({ ...data, userId }); }

  @Patch(':id')
  @ApiOperation({ summary: 'Update KYC application' })
  update(@Param('id') id: string, @Body() data: any) { return this.service.update(id, data); }

  @Post(':id/submit')
  @ApiOperation({ summary: 'Submit KYC application for review' })
  submit(@Param('id') id: string) { return this.service.submit(id); }

  @Post(':id/upload-document')
  @UseInterceptors(FileInterceptor('file'))
  @ApiConsumes('multipart/form-data')
  @ApiOperation({ summary: 'Upload a KYC document' })
  uploadDocument(
    @Param('id') id: string,
    @UploadedFile() file: Express.Multer.File,
    @Body('documentType') documentType: string,
  ) {
    return this.service.uploadDocument(id, documentType, file);
  }

  @Get(':id/document/:docType')
  @Roles(UserRole.ADMIN)
  @ApiOperation({ summary: 'Download KYC document (admin)' })
  async getDocument(@Param('id') id: string, @Param('docType') docType: string, @Res() res: Response) {
    const doc = await this.service.getDocument(id, docType);
    res.set({ 'Content-Type': doc.mimeType, 'Content-Disposition': `inline; filename="${doc.fileName}"` });
    res.send(doc.data);
  }

  @Post(':id/review')
  @Roles(UserRole.ADMIN)
  @ApiOperation({ summary: 'Review KYC application (admin)' })
  review(@Param('id') id: string, @Req() req: any, @Body() data: any) {
    const admin = req.user;
    return this.service.review(id, { ...data, reviewedBy: admin._id.toString() }, admin);
  }

  @Get('pending-count')
  @Roles(UserRole.ADMIN)
  @ApiOperation({ summary: 'Count pending KYC applications (admin)' })
  countPending() { return this.service.countPending(); }

  @Get()
  @Roles(UserRole.ADMIN)
  @ApiOperation({ summary: 'List all KYC applications (admin)' })
  findAll(@Query() query: any) { return this.service.findAll(query); }

  @Get(':id')
  @Roles(UserRole.ADMIN)
  @ApiOperation({ summary: 'Get KYC application by ID (admin)' })
  findOne(@Param('id') id: string) { return this.service.findById(id); }
}
