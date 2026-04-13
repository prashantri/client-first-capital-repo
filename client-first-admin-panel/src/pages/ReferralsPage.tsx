import { useEffect, useState } from 'react';
import api from '../lib/api';
import PageHeader from '../components/PageHeader';
import DataTable from '../components/DataTable';
import Badge from '../components/Badge';

const statusColor = (s: string): 'green' | 'yellow' | 'blue' | 'red' | 'gray' => {
  const map: Record<string, any> = { new: 'blue', contacted: 'yellow', converted: 'green', lost: 'red' };
  return map[s] || 'gray';
};

export default function ReferralsPage() {
  const [data, setData] = useState<any[]>([]);
  const [total, setTotal] = useState(0);
  const [page, setPage] = useState(1);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    setLoading(true);
    api.get('/referrals', { params: { page, limit: 20 } }).then((res) => {
      setData(res.data.data || res.data);
      setTotal(res.data.total || 0);
      setLoading(false);
    });
  }, [page]);

  const columns = [
    { key: 'clientName', label: 'Client Name' },
    { key: 'clientEmail', label: 'Email' },
    { key: 'clientPhone', label: 'Phone' },
    { key: 'status', label: 'Status', render: (r: any) => <Badge label={r.status} color={statusColor(r.status)} /> },
    { key: 'investmentAmount', label: 'Amount', render: (r: any) => `AED ${(r.investmentAmount || 0).toLocaleString()}` },
    { key: 'createdAt', label: 'Date', render: (r: any) => new Date(r.createdAt).toLocaleDateString() },
  ];

  return (
    <PageHeader title="Referrals">
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
