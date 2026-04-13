import { useEffect, useState } from 'react';
import api from '../lib/api';
import PageHeader from '../components/PageHeader';
import DataTable from '../components/DataTable';

export default function ShareholdingsPage() {
  const [data, setData] = useState<any[]>([]);
  const [total, setTotal] = useState(0);
  const [page, setPage] = useState(1);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    setLoading(true);
    api.get('/shareholdings', { params: { page, limit: 20 } }).then((res) => {
      setData(res.data.data || res.data);
      setTotal(res.data.total || 0);
      setLoading(false);
    });
  }, [page]);

  const columns = [
    { key: 'certificateNumber', label: 'Certificate' },
    { key: 'numberOfShares', label: 'Shares', render: (s: any) => (s.numberOfShares || 0).toLocaleString() },
    { key: 'purchasePrice', label: 'Purchase Price', render: (s: any) => `AED ${(s.purchasePrice || 0).toFixed(2)}` },
    { key: 'currentValue', label: 'Current Value', render: (s: any) => `AED ${(s.currentValue || 0).toLocaleString()}` },
    { key: 'purchaseDate', label: 'Purchase Date', render: (s: any) => new Date(s.purchaseDate).toLocaleDateString() },
  ];

  return (
    <PageHeader title="Shareholdings">
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
