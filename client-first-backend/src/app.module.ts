import { Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { MongooseModule } from '@nestjs/mongoose';
import { join } from 'path';
import { AuthModule } from './auth/auth.module';
import { UserModule } from './modules/user/user.module';
import { ReferralModule } from './modules/referral/referral.module';
import { CommissionModule } from './modules/commission/commission.module';
import { PortfolioModule } from './modules/portfolio/portfolio.module';
import { GoalModule } from './modules/goal/goal.module';
import { AppointmentModule } from './modules/appointment/appointment.module';
import { KycModule } from './modules/kyc/kyc.module';
import { MarketingModule } from './modules/marketing/marketing.module';
import { LeaderboardModule } from './modules/leaderboard/leaderboard.module';
import { ValuationModule } from './modules/valuation/valuation.module';
import { ShareholdingModule } from './modules/shareholding/shareholding.module';
import { EducationModule } from './modules/education/education.module';
import { ComplianceModule } from './modules/compliance/compliance.module';
import { NotificationModule } from './modules/notification/notification.module';
import { AuditLogModule } from './modules/audit-log/audit-log.module';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true, envFilePath: join(__dirname, '..', '.env') }),
    MongooseModule.forRootAsync({
      imports: [ConfigModule],
      inject: [ConfigService],
      useFactory: (config: ConfigService) => ({
        uri: config.get<string>('MONGODB_URI', 'mongodb://localhost:27017/client-first-capital'),
      }),
    }),
    AuthModule,
    UserModule,
    ReferralModule,
    CommissionModule,
    PortfolioModule,
    GoalModule,
    AppointmentModule,
    KycModule,
    MarketingModule,
    LeaderboardModule,
    ValuationModule,
    ShareholdingModule,
    EducationModule,
    ComplianceModule,
    NotificationModule,
    AuditLogModule,
  ],
})
export class AppModule {}
