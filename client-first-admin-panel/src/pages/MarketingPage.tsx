import { useEffect, useState } from 'react';
import api from '../lib/api';
import PageHeader from '../components/PageHeader';
import DataTable from '../components/DataTable';
import Badge from '../components/Badge';

export default function MarketingPage() {
  const [data, setData] = useState<any[]>([]);
  const [total, setTotal] = useState(0);
  const [page, setPage] = useState(1);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    setLoading(true);
    api.get('/marketing', { params: { page, limit: 20 } }).then((res) => {
      setData(res.data.data || res.data);
      setTotal(res.data.total || 0);
      setLoading(false);
    });
  }, [page]);

  const columns = [
    { key: 'title', label: 'Title' },
    { key: 'type', label: 'Type', render: (m: any) => <Badge label={m.type} color="blue" /> },
    { key: 'category', label: 'Category' },
    { key: 'downloadCount', label: 'Downloads', render: (m: any) => m.downloadCount || 0 },
    { key: 'isActive', label: 'Active', render: (m: any) => <Badge label={m.isActive ? 'Yes' : 'No'} color={m.isActive ? 'green' : 'gray'} /> },
    { key: 'createdAt', label: 'Created', render: (m: any) => new Date(m.createdAt).toLocaleDateString() },
  ];

  return (
    <PageHeader title="Marketing Assets">
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
