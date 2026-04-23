import { useEffect, useState } from 'react';
import api from '../lib/api';
import PageHeader from '../components/PageHeader';
import DataTable from '../components/DataTable';
import Badge from '../components/Badge';

const ACTION_OPTIONS = ['all', 'approved', 'rejected'];

export default function AuditLogPage() {
  const [data, setData] = useState<any[]>([]);
  const [total, setTotal] = useState(0);
  const [page, setPage] = useState(1);
  const [loading, setLoading] = useState(true);
  const [actionFilter, setActionFilter] = useState('all');

  const fetchData = () => {
    setLoading(true);
    const params: any = { page, limit: 20 };
    if (actionFilter !== 'all') params.action = actionFilter;
    api.get('/audit-logs', { params }).then(res => {
      setData(res.data.data || []);
      setTotal(res.data.total || 0);
      setLoading(false);
    }).catch(() => setLoading(false));
  };

  useEffect(() => { fetchData(); }, [page, actionFilter]);

  const columns = [
    {
      key: 'action', label: 'Action', render: (row: any) => (
        <Badge
          label={row.action === 'approved' ? '✓ Approved' : '✕ Rejected'}
          color={row.action === 'approved' ? 'green' : 'red'}
        />
      ),
    },
    {
      key: 'applicant', label: 'Applicant', render: (row: any) => (
        <div>
          <div className="font-medium text-gray-900">{row.applicantName}</div>
          <div className="text-xs text-gray-500">{row.applicantEmail}</div>
        </div>
      ),
    },
    {
      key: 'admin', label: 'Reviewed By', render: (row: any) => (
        <div>
          <div className="font-medium text-gray-900">{row.adminName}</div>
          <div className="text-xs text-gray-500">{row.adminEmail}</div>
        </div>
      ),
    },
    {
      key: 'notes', label: 'Notes / Reason', render: (row: any) => {
        const text = row.action === 'rejected' ? row.rejectionReason : row.notes;
        return text ? (
          <span className="text-sm text-gray-700 line-clamp-2">{text}</span>
        ) : (
          <span className="text-xs text-gray-400">—</span>
        );
      },
    },
    {
      key: 'createdAt', label: 'Date & Time', render: (row: any) =>
        row.createdAt ? (
          <div>
            <div className="text-sm text-gray-900">{new Date(row.createdAt).toLocaleDateString()}</div>
            <div className="text-xs text-gray-500">{new Date(row.createdAt).toLocaleTimeString()}</div>
          </div>
        ) : '—',
    },
  ];

  return (
    <PageHeader
      title="Audit Log"
      action={
        <select
          value={actionFilter}
          onChange={e => { setActionFilter(e.target.value); setPage(1); }}
          className="text-sm border border-gray-300 rounded-lg px-3 py-2 bg-white"
        >
          {ACTION_OPTIONS.map(a => (
            <option key={a} value={a}>{a === 'all' ? 'All Actions' : a.charAt(0).toUpperCase() + a.slice(1)}</option>
          ))}
        </select>
      }
    >
      <div className="mb-4 grid grid-cols-3 gap-4">
        <div className="bg-white rounded-lg border border-gray-200 p-4">
          <p className="text-xs font-semibold text-gray-500 uppercase tracking-wide">Total Actions</p>
          <p className="text-2xl font-bold text-gray-900 mt-1">{total}</p>
        </div>
        <div className="bg-green-50 rounded-lg border border-green-200 p-4">
          <p className="text-xs font-semibold text-green-700 uppercase tracking-wide">Approvals</p>
          <p className="text-2xl font-bold text-green-800 mt-1">
            {data.filter(d => d.action === 'approved').length}
          </p>
        </div>
        <div className="bg-red-50 rounded-lg border border-red-200 p-4">
          <p className="text-xs font-semibold text-red-700 uppercase tracking-wide">Rejections</p>
          <p className="text-2xl font-bold text-red-800 mt-1">
            {data.filter(d => d.action === 'rejected').length}
          </p>
        </div>
      </div>

      <DataTable columns={columns} data={data} loading={loading} />

      <div className="flex items-center justify-between mt-4 text-sm text-gray-500">
        <span>Total: {total}</span>
        <div className="flex gap-2">
          <button onClick={() => setPage(p => Math.max(1, p - 1))} disabled={page <= 1} className="px-3 py-1 border rounded disabled:opacity-40">Prev</button>
          <span className="px-3 py-1">Page {page}</span>
          <button onClick={() => setPage(p => p + 1)} disabled={data.length < 20} className="px-3 py-1 border rounded disabled:opacity-40">Next</button>
        </div>
      </div>
    </PageHeader>
  );
}
