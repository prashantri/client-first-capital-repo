import { Injectable, Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import * as nodemailer from 'nodemailer';
import { Transporter } from 'nodemailer';

@Injectable()
export class MailService {
  private readonly logger = new Logger(MailService.name);
  private transporter: Transporter;

  constructor(private config: ConfigService) {
    this.transporter = nodemailer.createTransport({
      host: 'smtp.gmail.com',
      port: 587,
      secure: false, // STARTTLS
      auth: {
        user: this.config.get<string>('SMTP_USER'),
        pass: this.config.get<string>('SMTP_PASS'),
      },
    });
  }

  async sendWelcomeEmail(to: string, fullName: string): Promise<void> {
    const from = this.config.get<string>('SMTP_FROM');
    const firstName = fullName.split(' ')[0];
    const html = `
      <!DOCTYPE html>
      <html>
        <head><meta charset="UTF-8" /><meta name="viewport" content="width=device-width, initial-scale=1.0" /></head>
        <body style="margin:0;padding:0;background-color:#f4f4f4;font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;">
          <table width="100%" cellpadding="0" cellspacing="0" style="background-color:#f4f4f4;padding:40px 0;">
            <tr><td align="center">
              <table width="560" cellpadding="0" cellspacing="0" style="background:#ffffff;border-radius:8px;overflow:hidden;box-shadow:0 2px 8px rgba(0,0,0,0.08);">
                <tr>
                  <td style="background-color:#1F5D01;padding:32px 40px;text-align:center;">
                    <p style="margin:0;font-size:22px;font-weight:800;color:#ffffff;letter-spacing:-0.5px;">Client First Capital</p>
                    <p style="margin:8px 0 0;font-size:13px;color:#B4FB91;letter-spacing:1px;">INTRODUCER PORTAL</p>
                  </td>
                </tr>
                <tr>
                  <td style="padding:40px 40px 32px;">
                    <p style="margin:0 0 8px;font-size:24px;font-weight:700;color:#1A1C1C;">Welcome, ${firstName}! 🎉</p>
                    <p style="margin:0 0 24px;font-size:15px;color:#5C5F61;line-height:1.6;">
                      Your introducer application has been <strong style="color:#1F5D01;">approved</strong>. Your account is now active and you can log in to the Client First Capital Introducer Portal.
                    </p>
                    <table width="100%" cellpadding="0" cellspacing="0">
                      <tr>
                        <td style="padding:20px 24px;background-color:#f0f9eb;border-radius:8px;border:1px solid #c6e6a8;">
                          <p style="margin:0;font-size:14px;color:#1F5D01;font-weight:600;">✅ Account Status: Active</p>
                          <p style="margin:8px 0 0;font-size:13px;color:#3a7c1f;">You can now log in and start referring clients to earn commissions.</p>
                        </td>
                      </tr>
                    </table>
                    <p style="margin:24px 0 0;font-size:13px;color:#5C5F61;line-height:1.6;">
                      If you have any questions, please contact our support team. We look forward to a successful partnership.
                    </p>
                  </td>
                </tr>
                <tr>
                  <td style="padding:24px 40px;background-color:#f9f9f9;border-top:1px solid #e2e2e2;text-align:center;">
                    <p style="margin:0;font-size:11px;color:#717A6A;letter-spacing:1.5px;">CLIENT FIRST CAPITAL &nbsp;•&nbsp; SECURE BANKING STANDARD</p>
                  </td>
                </tr>
              </table>
            </td></tr>
          </table>
        </body>
      </html>
    `;
    try {
      await this.transporter.sendMail({ from, to, subject: 'Your Introducer Application is Approved – Client First Capital', html });
      this.logger.log(`Welcome email sent to ${to}`);
    } catch (error) {
      this.logger.error(`Failed to send welcome email to ${to}`, error);
    }
  }

  async sendRejectionEmail(to: string, fullName: string, reason: string): Promise<void> {
    const from = this.config.get<string>('SMTP_FROM');
    const firstName = fullName.split(' ')[0];
    const html = `
      <!DOCTYPE html>
      <html>
        <head><meta charset="UTF-8" /><meta name="viewport" content="width=device-width, initial-scale=1.0" /></head>
        <body style="margin:0;padding:0;background-color:#f4f4f4;font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;">
          <table width="100%" cellpadding="0" cellspacing="0" style="background-color:#f4f4f4;padding:40px 0;">
            <tr><td align="center">
              <table width="560" cellpadding="0" cellspacing="0" style="background:#ffffff;border-radius:8px;overflow:hidden;box-shadow:0 2px 8px rgba(0,0,0,0.08);">
                <tr>
                  <td style="background-color:#1F5D01;padding:32px 40px;text-align:center;">
                    <p style="margin:0;font-size:22px;font-weight:800;color:#ffffff;letter-spacing:-0.5px;">Client First Capital</p>
                    <p style="margin:8px 0 0;font-size:13px;color:#B4FB91;letter-spacing:1px;">INTRODUCER PORTAL</p>
                  </td>
                </tr>
                <tr>
                  <td style="padding:40px 40px 32px;">
                    <p style="margin:0 0 8px;font-size:24px;font-weight:700;color:#1A1C1C;">Application Update, ${firstName}</p>
                    <p style="margin:0 0 24px;font-size:15px;color:#5C5F61;line-height:1.6;">
                      After careful review, we are unable to approve your introducer application at this time.
                    </p>
                    <table width="100%" cellpadding="0" cellspacing="0">
                      <tr>
                        <td style="padding:20px 24px;background-color:#fff5f5;border-radius:8px;border:1px solid #fecaca;">
                          <p style="margin:0;font-size:12px;font-weight:700;letter-spacing:2px;color:#b91c1c;">REASON FOR REJECTION</p>
                          <p style="margin:8px 0 0;font-size:14px;color:#7f1d1d;line-height:1.6;">${reason}</p>
                        </td>
                      </tr>
                    </table>
                    <p style="margin:24px 0 0;font-size:13px;color:#5C5F61;line-height:1.6;">
                      If you believe this decision was made in error, or if you can provide additional information to support your application, please contact our support team.
                    </p>
                  </td>
                </tr>
                <tr>
                  <td style="padding:24px 40px;background-color:#f9f9f9;border-top:1px solid #e2e2e2;text-align:center;">
                    <p style="margin:0;font-size:11px;color:#717A6A;letter-spacing:1.5px;">CLIENT FIRST CAPITAL &nbsp;•&nbsp; SECURE BANKING STANDARD</p>
                  </td>
                </tr>
              </table>
            </td></tr>
          </table>
        </body>
      </html>
    `;
    try {
      await this.transporter.sendMail({ from, to, subject: 'Your Introducer Application Status – Client First Capital', html });
      this.logger.log(`Rejection email sent to ${to}`);
    } catch (error) {
      this.logger.error(`Failed to send rejection email to ${to}`, error);
    }
  }

  async sendPasswordResetEmail(to: string, otp: string, fullName: string): Promise<void> {
    const from = this.config.get<string>('SMTP_FROM');
    const firstName = fullName.split(' ')[0];
    const html = `
      <!DOCTYPE html>
      <html>
        <head><meta charset="UTF-8" /><meta name="viewport" content="width=device-width, initial-scale=1.0" /></head>
        <body style="margin:0;padding:0;background-color:#f4f4f4;font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;">
          <table width="100%" cellpadding="0" cellspacing="0" style="background-color:#f4f4f4;padding:40px 0;">
            <tr><td align="center">
              <table width="560" cellpadding="0" cellspacing="0" style="background:#ffffff;border-radius:8px;overflow:hidden;box-shadow:0 2px 8px rgba(0,0,0,0.08);">
                <tr>
                  <td style="background-color:#1F5D01;padding:32px 40px;text-align:center;">
                    <p style="margin:0;font-size:22px;font-weight:800;color:#ffffff;letter-spacing:-0.5px;">Client First Capital</p>
                    <p style="margin:8px 0 0;font-size:13px;color:#B4FB91;letter-spacing:1px;">PASSWORD RESET</p>
                  </td>
                </tr>
                <tr>
                  <td style="padding:40px 40px 32px;">
                    <p style="margin:0 0 8px;font-size:24px;font-weight:700;color:#1A1C1C;">Reset your password, ${firstName}</p>
                    <p style="margin:0 0 32px;font-size:15px;color:#5C5F61;line-height:1.6;">
                      Use the code below to reset your password. This code expires in <strong>10 minutes</strong>.
                    </p>
                    <table width="100%" cellpadding="0" cellspacing="0">
                      <tr>
                        <td align="center" style="padding:24px;background-color:#f3f3f3;border-radius:8px;border:1px solid #e2e2e2;">
                          <p style="margin:0 0 8px;font-size:11px;font-weight:700;letter-spacing:3px;color:#5C5F61;">RESET CODE</p>
                          <p style="margin:0;font-size:40px;font-weight:800;letter-spacing:12px;color:#1F5D01;">${otp}</p>
                        </td>
                      </tr>
                    </table>
                    <p style="margin:32px 0 0;font-size:13px;color:#5C5F61;line-height:1.6;">
                      If you did not request a password reset, please ignore this email. Your password will not change.
                    </p>
                  </td>
                </tr>
                <tr>
                  <td style="padding:24px 40px;background-color:#f9f9f9;border-top:1px solid #e2e2e2;text-align:center;">
                    <p style="margin:0;font-size:11px;color:#717A6A;letter-spacing:1.5px;">CLIENT FIRST CAPITAL &nbsp;•&nbsp; SECURE BANKING STANDARD</p>
                  </td>
                </tr>
              </table>
            </td></tr>
          </table>
        </body>
      </html>
    `;
    try {
      await this.transporter.sendMail({ from, to, subject: 'Password Reset Code – Client First Capital', html });
      this.logger.log(`Password reset email sent to ${to}`);
    } catch (error) {
      this.logger.error(`Failed to send password reset email to ${to}`, error);
      throw error;
    }
  }

  async sendOtpEmail(to: string, otp: string): Promise<void> {
    const from = this.config.get<string>('SMTP_FROM');

    const html = `
      <!DOCTYPE html>
      <html>
        <head>
          <meta charset="UTF-8" />
          <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        </head>
        <body style="margin:0;padding:0;background-color:#f4f4f4;font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;">
          <table width="100%" cellpadding="0" cellspacing="0" style="background-color:#f4f4f4;padding:40px 0;">
            <tr>
              <td align="center">
                <table width="560" cellpadding="0" cellspacing="0" style="background:#ffffff;border-radius:8px;overflow:hidden;box-shadow:0 2px 8px rgba(0,0,0,0.08);">

                  <!-- Header -->
                  <tr>
                    <td style="background-color:#1F5D01;padding:32px 40px;text-align:center;">
                      <p style="margin:0;font-size:22px;font-weight:800;color:#ffffff;letter-spacing:-0.5px;">
                        Client First Capital
                      </p>
                      <p style="margin:8px 0 0;font-size:13px;color:#B4FB91;letter-spacing:1px;">
                        INTRODUCER APPLICATION
                      </p>
                    </td>
                  </tr>

                  <!-- Body -->
                  <tr>
                    <td style="padding:40px 40px 32px;">
                      <p style="margin:0 0 8px;font-size:24px;font-weight:700;color:#1A1C1C;">
                        Verify your email address
                      </p>
                      <p style="margin:0 0 32px;font-size:15px;color:#5C5F61;line-height:1.6;">
                        Use the code below to verify your email and complete your introducer application.
                        This code expires in <strong>10 minutes</strong>.
                      </p>

                      <!-- OTP Box -->
                      <table width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                          <td align="center" style="padding:24px;background-color:#f3f3f3;border-radius:8px;border:1px solid #e2e2e2;">
                            <p style="margin:0 0 8px;font-size:11px;font-weight:700;letter-spacing:3px;color:#5C5F61;">
                              YOUR OTP CODE
                            </p>
                            <p style="margin:0;font-size:40px;font-weight:800;letter-spacing:12px;color:#1F5D01;">
                              ${otp}
                            </p>
                          </td>
                        </tr>
                      </table>

                      <p style="margin:32px 0 0;font-size:13px;color:#5C5F61;line-height:1.6;">
                        If you did not request this, please ignore this email.
                        Your account will not be created without completing verification.
                      </p>
                    </td>
                  </tr>

                  <!-- Footer -->
                  <tr>
                    <td style="padding:24px 40px;background-color:#f9f9f9;border-top:1px solid #e2e2e2;text-align:center;">
                      <p style="margin:0;font-size:11px;color:#717A6A;letter-spacing:1.5px;">
                        CLIENT FIRST CAPITAL &nbsp;•&nbsp; SECURE BANKING STANDARD
                      </p>
                    </td>
                  </tr>

                </table>
              </td>
            </tr>
          </table>
        </body>
      </html>
    `;

    try {
      await this.transporter.sendMail({
        from,
        to,
        subject: 'Your OTP Code – Client First Capital Introducer Application',
        html,
      });
      this.logger.log(`OTP email sent to ${to}`);
    } catch (error) {
      this.logger.error(`Failed to send OTP email to ${to}`, error);
      throw error;
    }
  }
}
