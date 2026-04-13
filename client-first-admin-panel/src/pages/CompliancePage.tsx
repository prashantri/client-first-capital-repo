import { useEffect, useState } from 'react';
import api from '../lib/api';
import PageHeader from '../components/PageHeader';
import DataTable from '../components/DataTable';
import Badge from '../components/Badge';

export default function CompliancePage() {
  const [data, setData] = useState<any[]>([]);
  const [total, setTotal] = useState(0);
  const [page, setPage] = useState(1);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    setLoading(true);
    api.get('/compliance', { params: { page, limit: 20 } }).then((res) => {
      setData(res.data.data || res.data);
      setTotal(res.data.total || 0);
      setLoading(false);
    });
  }, [page]);

  const columns = [
    { key: 'title', label: 'Title' },
    { key: 'description', label: 'Description', render: (c: any) => (c.description || '').substring(0, 60) + '...' },
    { key: 'category', label: 'Category' },
    { key: 'isCompleted', label: 'Completed', render: (c: any) => <Badge label={c.isCompleted ? 'Yes' : 'No'} color={c.isCompleted ? 'green' : 'yellow'} /> },
    { key: 'dueDate', label: 'Due Date', render: (c: any) => c.dueDate ? new Date(c.dueDate).toLocaleDateString() : '—' },
  ];

  return (
    <PageHeader title="Compliance Checklists">
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
