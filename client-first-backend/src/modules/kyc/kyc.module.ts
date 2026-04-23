import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { KycController } from './kyc.controller';
import { KycService } from './kyc.service';
import { KycApplication, KycApplicationSchema } from '../../schemas/kyc-application.schema';
import { User, UserSchema } from '../../schemas/user.schema';
import { MailModule } from '../../mail/mail.module';
import { AuditLogModule } from '../audit-log/audit-log.module';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: KycApplication.name, schema: KycApplicationSchema },
      { name: User.name, schema: UserSchema },
    ]),
    MailModule,
    AuditLogModule,
  ],
  controllers: [KycController],
  providers: [KycService],
  exports: [KycService],
})
export class KycModule {}
