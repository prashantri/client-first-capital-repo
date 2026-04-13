import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { ShareholdingController } from './shareholding.controller';
import { ShareholdingService } from './shareholding.service';
import { Shareholding, ShareholdingSchema } from '../../schemas/shareholding.schema';

@Module({
  imports: [MongooseModule.forFeature([{ name: Shareholding.name, schema: ShareholdingSchema }])],
  controllers: [ShareholdingController],
  providers: [ShareholdingService],
  exports: [ShareholdingService],
})
export class ShareholdingModule {}
