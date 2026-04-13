import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { EducationContent, EducationContentSchema } from '../../schemas/education-content.schema';
import { EducationService } from './education.service';
import { EducationController } from './education.controller';

@Module({
  imports: [MongooseModule.forFeature([{ name: EducationContent.name, schema: EducationContentSchema }])],
  controllers: [EducationController],
  providers: [EducationService],
  exports: [EducationService],
})
export class EducationModule {}
