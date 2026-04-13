import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { ValuationController } from './valuation.controller';
import { ValuationService } from './valuation.service';
import { CompanyValuation, CompanyValuationSchema } from '../../schemas/company-valuation.schema';

@Module({
  imports: [MongooseModule.forFeature([{ name: CompanyValuation.name, schema: CompanyValuationSchema }])],
  controllers: [ValuationController],
  providers: [ValuationService],
  exports: [ValuationService],
})
export class ValuationModule {}
