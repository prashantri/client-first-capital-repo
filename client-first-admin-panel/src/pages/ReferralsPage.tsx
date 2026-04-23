import { useEffect, useState, useCallback } from 'react';
import api from '../lib/api';
import PageHeader from '../components/PageHeader';
import DataTable from '../components/DataTable';
import Badge from '../components/Badge';

const STATUS_OPTIONS = [
  { value: '', label: 'All Statuses' },
  { value: 'new', label: 'New' },
  { value: 'contacted', label: 'Contacted' },
  { value: 'meeting_scheduled', label: 'Meeting Scheduled' },
  { value: 'kyc_pending', label: 'KYC Pending' },
  { value: 'kyc_submitted', label: 'KYC Submitted' },
  { value: 'converted', label: 'Converted' },
  { value: 'lost', label: 'Lost' },
];

const statusColor = (s: string): 'green' | 'yellow' | 'blue' | 'red' | 'gray' | 'purple' => {
  const map: Record<string, any> = {
    new: 'blue',
    contacted: 'yellow',
    meeting_scheduled: 'purple',
    kyc_pending: 'yellow',
    kyc_submitted: 'yellow',
    converted: 'green',
    lost: 'red',
  };
  return map[s] ?? 'gray';
};

const statusLabel = (s: string) =>
  STATUS_OPTIONS.find((o) => o.value === s)?.label ?? s;

interface Referral {
  _id: string;
  referralName: string;
  referralEmail: string;
  referralPhone: string;
  status: string;
  serviceType?: string;
  notes?: string;
  estimatedInvestment?: number;
  currency?: string;
  hubspotContactId?: string;
  hubspotDealId?: string;
  createdAt: string;
  introducerId?: { _id: string; fullName: string; email: string };
  assignedAdvisorId?: { _id: string; fullName: string };
}

export default function ReferralsPage() {
  const [data, setData] = useState<Referral[]>([]);
  const [total, setTotal] = useState(0);
  const [page, setPage] = useState(1);
  const [loading, setLoading] = useState(true);

  // filters
  const [search, setSearch] = useState('');
  const [status, setStatus] = useState('');
  const [dateFrom, setDateFrom] = useState('');
  const [dateTo, setDateTo] = useState('');
  const [searchInput, setSearchInput] = useState('');

  // detail modal
  const [selected, setSelected] = useState<Referral | null>(null);

  const fetchData = useCallback(() => {
    setLoading(true);
    api
      .get('/referrals', {
        params: {
          page,
          limit: 20,
          ...(status && { status }),
          ...(search && { search }),
          ...(dateFrom && { dateFrom }),
          ...(dateTo && { dateTo }),
        },
      })
      .then((res) => {
        setData(res.data.data ?? res.data);
        setTotal(res.data.total ?? 0);
      })
      .catch(() => setData([]))
      .finally(() => setLoading(false));
  }, [page, status, search, dateFrom, dateTo]);

  useEffect(() => {
    fetchData();
  }, [fetchData]);

  // debounce search input
  useEffect(() => {
    const t = setTimeout(() => {
      setSearch(searchInput);
      setPage(1);
    }, 400);
    return () => clearTimeout(t);
  }, [searchInput]);

  const handleFilterChange = () => setPage(1);

  const columns = [
    {
      key: 'referralName',
      label: 'Prospect',
      render: (r: Referral) => (
        <div>
          <div className="font-semibold text-gray-900">{r.referralName}</div>
          <div className="text-xs text-gray-400">{r.referralEmail}</div>
        </div>
      ),
    },
    {
      key: 'referralPhone',
      label: 'Mobile',
      render: (r: Referral) => r.referralPhone || '—',
    },
    {
      key: 'introducerId',
      label: 'Introduced By',
      render: (r: Referral) =>
        r.introducerId ? (
          <div>
            <div className="font-medium text-gray-800">{r.introducerId.fullName}</div>
            <div className="text-xs text-gray-400">{r.introducerId.email}</div>
          </div>
        ) : (
          <span className="text-gray-400">—</span>
        ),
    },
    {
      key: 'serviceType',
      label: 'Service',
      render: (r: Referral) =>
        r.serviceType ? (
          <span className="text-xs text-gray-600">{r.serviceType}</span>
        ) : (
          <span className="text-gray-400">—</span>
        ),
    },
    {
      key: 'status',
      label: 'Status',
      render: (r: Referral) => (
        <Badge label={statusLabel(r.status)} color={statusColor(r.status)} />
      ),
    },
    {
      key: 'hubspot',
      label: 'HubSpot',
      render: (r: Referral) =>
        r.hubspotDealId ? (
          <span className="inline-flex items-center gap-1 text-xs text-orange-600 font-medium">
            <span className="w-1.5 h-1.5 rounded-full bg-orange-500 inline-block" />
            Synced
          </span>
        ) : (
          <span className="text-xs text-gray-400">Pending</span>
        ),
    },
    {
      key: 'createdAt',
      label: 'Date',
      render: (r: Referral) => new Date(r.createdAt).toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' }),
    },
  ];

  const totalPages = Math.ceil(total / 20);

  return (
    <div className="space-y-6">
      <PageHeader title="Referrals">
        <div className="flex items-center gap-2">
          <span className="text-sm text-gray-500">Total:</span>
          <span className="text-sm font-semibold text-gray-800">{total}</span>
        </div>
      </PageHeader>

      {/* Filters */}
      <div className="bg-white rounded-xl border border-gray-200 shadow-sm p-4">
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-3">
          {/* Search */}
          <div className="relative">
            <svg className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
            </svg>
            <input
              type="text"
              placeholder="Search name or email..."
              value={searchInput}
              onChange={(e) => setSearchInput(e.target.value)}
              className="w-full pl-9 pr-3 py-2 text-sm border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500"
            />
          </div>

          {/* Status */}
          <select
            value={status}
            onChange={(e) => { setStatus(e.target.value); handleFilterChange(); }}
            className="w-full px-3 py-2 text-sm border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 bg-white"
          >
            {STATUS_OPTIONS.map((o) => (
              <option key={o.value} value={o.value}>{o.label}</option>
            ))}
          </select>

          {/* Date From */}
          <div className="relative">
            <label className="absolute -top-2 left-2 bg-white px-1 text-xs text-gray-400">From</label>
            <input
              type="date"
              value={dateFrom}
              onChange={(e) => { setDateFrom(e.target.value); handleFilterChange(); }}
              className="w-full px-3 py-2 text-sm border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500"
            />
          </div>

          {/* Date To */}
          <div className="relative">
            <label className="absolute -top-2 left-2 bg-white px-1 text-xs text-gray-400">To</label>
            <input
              type="date"
              value={dateTo}
              onChange={(e) => { setDateTo(e.target.value); handleFilterChange(); }}
              className="w-full px-3 py-2 text-sm border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500"
            />
          </div>
        </div>

        {/* Active filters clear */}
        {(search || status || dateFrom || dateTo) && (
          <div className="mt-3 flex items-center gap-2">
            <span className="text-xs text-gray-500">Filters active</span>
            <button
              onClick={() => { setSearchInput(''); setSearch(''); setStatus(''); setDateFrom(''); setDateTo(''); setPage(1); }}
              className="text-xs text-red-500 hover:text-red-700 font-medium"
            >
              Clear all
            </button>
          </div>
        )}
      </div>

      {/* Table */}
      <DataTable columns={columns} data={data} loading={loading} onRowClick={setSelected} />

      {/* Pagination */}
      <div className="flex items-center justify-between text-sm text-gray-500">
        <span>{total} total referral{total !== 1 ? 's' : ''}</span>
        <div className="flex items-center gap-2">
          <button
            onClick={() => setPage((p) => Math.max(1, p - 1))}
            disabled={page <= 1}
            className="px-3 py-1 border border-gray-200 rounded-lg disabled:opacity-40 hover:bg-gray-50"
          >
            ← Prev
          </button>
          <span className="px-3 py-1 text-gray-700 font-medium">
            {page} / {Math.max(1, totalPages)}
          </span>
          <button
            onClick={() => setPage((p) => p + 1)}
            disabled={page >= totalPages}
            className="px-3 py-1 border border-gray-200 rounded-lg disabled:opacity-40 hover:bg-gray-50"
          >
            Next →
          </button>
        </div>
      </div>

      {/* Detail Modal */}
      {selected && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/40 p-4" onClick={() => setSelected(null)}>
          <div
            className="bg-white rounded-2xl shadow-2xl w-full max-w-lg max-h-[90vh] overflow-y-auto"
            onClick={(e) => e.stopPropagation()}
          >
            {/* Header */}
            <div className="flex items-start justify-between p-6 border-b border-gray-100">
              <div>
                <h2 className="text-lg font-bold text-gray-900">{selected.referralName}</h2>
                <p className="text-sm text-gray-500 mt-0.5">{selected.referralEmail}</p>
              </div>
              <div className="flex items-center gap-3">
                <Badge label={statusLabel(selected.status)} color={statusColor(selected.status)} />
                <button onClick={() => setSelected(null)} className="text-gray-400 hover:text-gray-600 text-xl leading-none">×</button>
              </div>
            </div>

            {/* Body */}
            <div className="p-6 space-y-5">
              {/* Prospect details */}
              <Section title="Prospect Details">
                <Row label="Mobile" value={selected.referralPhone || '—'} />
                <Row label="Email" value={selected.referralEmail} />
                <Row label="Service Type" value={selected.serviceType || '—'} />
                {selected.estimatedInvestment && (
                  <Row label="Est. Investment" value={`${selected.currency ?? 'AED'} ${selected.estimatedInvestment.toLocaleString()}`} />
                )}
              </Section>

              {/* Introducer */}
              <Section title="Introduced By">
                <Row label="Name" value={selected.introducerId?.fullName ?? '—'} />
                <Row label="Email" value={selected.introducerId?.email ?? '—'} />
              </Section>

              {/* Notes */}
              {selected.notes && (
                <Section title="Introducer Notes">
                  <p className="text-sm text-gray-700 bg-gray-50 rounded-lg p-3 leading-relaxed">{selected.notes}</p>
                </Section>
              )}

              {/* HubSpot */}
              <Section title="CRM (HubSpot)">
                <Row
                  label="Contact ID"
                  value={selected.hubspotContactId ?? <span className="text-yellow-600 text-xs">Sync pending</span>}
                />
                <Row
                  label="Deal ID"
                  value={selected.hubspotDealId ?? <span className="text-yellow-600 text-xs">Sync pending</span>}
                />
              </Section>

              {/* Meta */}
              <Section title="Timeline">
                <Row label="Submitted" value={new Date(selected.createdAt).toLocaleString('en-GB', { day: '2-digit', month: 'short', year: 'numeric', hour: '2-digit', minute: '2-digit' })} />
                {selected.assignedAdvisorId && (
                  <Row label="Assigned Advisor" value={selected.assignedAdvisorId.fullName} />
                )}
              </Section>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

function Section({ title, children }: { title: string; children: React.ReactNode }) {
  return (
    <div>
      <h3 className="text-xs font-bold text-gray-400 uppercase tracking-widest mb-3">{title}</h3>
      <div className="space-y-2">{children}</div>
    </div>
  );
}

function Row({ label, value }: { label: string; value: React.ReactNode }) {
  return (
    <div className="flex justify-between items-start gap-4">
      <span className="text-sm text-gray-500 shrink-0">{label}</span>
      <span className="text-sm text-gray-900 text-right font-medium">{value}</span>
    </div>
  );
}
