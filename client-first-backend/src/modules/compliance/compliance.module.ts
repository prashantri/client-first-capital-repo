import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { ComplianceChecklist, ComplianceChecklistSchema } from '../../schemas/compliance-checklist.schema';
import { ComplianceService } from './compliance.service';
import { ComplianceController } from './compliance.controller';

@Module({
  imports: [MongooseModule.forFeature([{ name: ComplianceChecklist.name, schema: ComplianceChecklistSchema }])],
  controllers: [ComplianceController],
  providers: [ComplianceService],
  exports: [ComplianceService],
})
export class ComplianceModule {}
