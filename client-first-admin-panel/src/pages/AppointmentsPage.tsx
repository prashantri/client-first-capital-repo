import { useEffect, useState } from 'react';
import api from '../lib/api';
import PageHeader from '../components/PageHeader';
import DataTable from '../components/DataTable';
import Badge from '../components/Badge';

export default function AppointmentsPage() {
  const [data, setData] = useState<any[]>([]);
  const [total, setTotal] = useState(0);
  const [page, setPage] = useState(1);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    setLoading(true);
    api.get('/appointments', { params: { page, limit: 20 } }).then((res) => {
      setData(res.data.data || res.data);
      setTotal(res.data.total || 0);
      setLoading(false);
    });
  }, [page]);

  const statusColor = (s: string): 'green' | 'yellow' | 'blue' | 'red' | 'gray' => {
    const map: Record<string, any> = { confirmed: 'green', pending: 'yellow', scheduled: 'blue', cancelled: 'red', completed: 'green' };
    return map[s] || 'gray';
  };

  const columns = [
    { key: 'title', label: 'Title' },
    { key: 'type', label: 'Type' },
    { key: 'scheduledDate', label: 'Date', render: (a: any) => new Date(a.scheduledDate).toLocaleDateString() },
    { key: 'status', label: 'Status', render: (a: any) => <Badge label={a.status} color={statusColor(a.status)} /> },
    { key: 'location', label: 'Location' },
  ];

  return (
    <PageHeader title="Appointments">
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
