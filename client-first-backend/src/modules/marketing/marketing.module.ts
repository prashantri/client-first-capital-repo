import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { MarketingController } from './marketing.controller';
import { MarketingService } from './marketing.service';
import { MarketingAsset, MarketingAssetSchema } from '../../schemas/marketing-asset.schema';

@Module({
  imports: [MongooseModule.forFeature([{ name: MarketingAsset.name, schema: MarketingAssetSchema }])],
  controllers: [MarketingController],
  providers: [MarketingService],
  exports: [MarketingService],
})
export class MarketingModule {}
