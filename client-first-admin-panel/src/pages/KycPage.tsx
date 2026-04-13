import { useEffect, useState } from 'react';
import api from '../lib/api';
import PageHeader from '../components/PageHeader';
import DataTable from '../components/DataTable';
import Badge from '../components/Badge';

export default function KycPage() {
  const [data, setData] = useState<any[]>([]);
  const [total, setTotal] = useState(0);
  const [page, setPage] = useState(1);
  const [loading, setLoading] = useState(true);

  const fetchData = () => {
    setLoading(true);
    api.get('/kyc', { params: { page, limit: 20 } }).then((res) => {
      setData(res.data.data || res.data);
      setTotal(res.data.total || 0);
      setLoading(false);
    });
  };

  useEffect(() => { fetchData(); }, [page]);

  const handleReview = async (id: string, decision: 'approved' | 'rejected') => {
    await api.post(`/kyc/${id}/review`, { decision, reviewNotes: `${decision} by admin` });
    fetchData();
  };

  const statusColor = (s: string): 'green' | 'yellow' | 'blue' | 'red' | 'gray' => {
    const map: Record<string, any> = { approved: 'green', pending: 'yellow', submitted: 'blue', rejected: 'red', draft: 'gray' };
    return map[s] || 'gray';
  };

  const columns = [
    { key: 'fullName', label: 'Full Name' },
    { key: 'nationality', label: 'Nationality' },
    { key: 'documentType', label: 'Document' },
    { key: 'status', label: 'Status', render: (k: any) => <Badge label={k.status} color={statusColor(k.status)} /> },
    { key: 'submittedAt', label: 'Submitted', render: (k: any) => k.submittedAt ? new Date(k.submittedAt).toLocaleDateString() : '—' },
    {
      key: 'actions', label: 'Actions', render: (k: any) =>
        k.status === 'submitted' ? (
          <div className="flex gap-2">
            <button onClick={() => handleReview(k._id, 'approved')} className="text-xs bg-green-100 text-green-700 px-2 py-1 rounded hover:bg-green-200">Approve</button>
            <button onClick={() => handleReview(k._id, 'rejected')} className="text-xs bg-red-100 text-red-700 px-2 py-1 rounded hover:bg-red-200">Reject</button>
          </div>
        ) : null,
    },
  ];

  return (
    <PageHeader title="KYC Applications">
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
