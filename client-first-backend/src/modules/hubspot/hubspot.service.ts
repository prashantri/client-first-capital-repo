import { Injectable, Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class HubspotService {
  private readonly logger = new Logger(HubspotService.name);
  private readonly baseUrl: string;
  private readonly accessToken: string;

  constructor(private config: ConfigService) {
    this.baseUrl = config.get<string>('HUBSPOT_BASE_URL', 'https://api.hubapi.com');
    this.accessToken = config.get<string>('HUBSPOT_ACCESS_TOKEN', '');
  }

  private async request<T>(method: string, path: string, body?: unknown): Promise<T> {
    const res = await fetch(`${this.baseUrl}${path}`, {
      method,
      headers: {
        Authorization: `Bearer ${this.accessToken}`,
        'Content-Type': 'application/json',
      },
      body: body != null ? JSON.stringify(body) : undefined,
    });
    if (!res.ok) {
      const text = await res.text();
      throw new Error(`HubSpot ${method} ${path} → ${res.status}: ${text}`);
    }
    return res.json() as Promise<T>;
  }

  /** Upsert a contact by email. Returns the HubSpot contact ID. */
  private async upsertContact(data: {
    firstName: string;
    lastName: string;
    email: string;
    phone: string;
  }): Promise<string> {
    const result = await this.request<{ results: { id: string }[] }>(
      'POST',
      '/crm/v3/objects/contacts/batch/upsert',
      {
        inputs: [
          {
            idProperty: 'email',
            id: data.email.toLowerCase(),
            properties: {
              firstname: data.firstName,
              lastname: data.lastName,
              email: data.email.toLowerCase(),
              phone: data.phone,
            },
          },
        ],
      },
    );
    return result.results[0].id;
  }

  /** Create a deal linked to a contact. Returns the HubSpot deal ID. */
  private async createDeal(data: {
    prospectName: string;
    serviceType?: string;
    notes?: string;
    introducerName: string;
    introducerEmail: string;
    contactId: string;
  }): Promise<string> {
    const dealName = data.serviceType
      ? `${data.prospectName} – ${data.serviceType}`
      : data.prospectName;

    const descriptionLines = [
      `Introduced by: ${data.introducerName} (${data.introducerEmail})`,
      data.serviceType ? `Service: ${data.serviceType}` : null,
      data.notes ? `Notes: ${data.notes}` : null,
    ].filter(Boolean);

    const result = await this.request<{ id: string }>('POST', '/crm/v3/objects/deals', {
      properties: {
        dealname: dealName,
        description: descriptionLines.join('\n'),
        pipeline: 'default',
        dealstage: this.config.get<string>('HUBSPOT_DEAL_STAGE', 'appointmentscheduled'),
      },
      associations: [
        {
          to: { id: data.contactId },
          types: [{ associationCategory: 'HUBSPOT_DEFINED', associationTypeId: 3 }],
        },
      ],
    });
    return result.id;
  }

  /**
   * Push a new referral to HubSpot.
   * Creates/upserts the prospect as a Contact and creates a Deal with
   * the introducer's attribution. Fire-and-forget safe — caller should
   * catch errors and log rather than blocking the response.
   */
  async pushReferral(data: {
    referralName: string;
    referralEmail: string;
    referralPhone: string;
    serviceType?: string;
    notes?: string;
    introducerName: string;
    introducerEmail: string;
  }): Promise<{ hubspotContactId: string; hubspotDealId: string }> {
    const nameParts = data.referralName.trim().split(' ');
    const firstName = nameParts[0];
    const lastName = nameParts.length > 1 ? nameParts.slice(1).join(' ') : '';

    const hubspotContactId = await this.upsertContact({
      firstName,
      lastName,
      email: data.referralEmail,
      phone: data.referralPhone,
    });

    const hubspotDealId = await this.createDeal({
      prospectName: data.referralName,
      serviceType: data.serviceType,
      notes: data.notes,
      introducerName: data.introducerName,
      introducerEmail: data.introducerEmail,
      contactId: hubspotContactId,
    });

    return { hubspotContactId, hubspotDealId };
  }
}
