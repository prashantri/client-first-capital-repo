import { useEffect, useState } from 'react';
import api from '../lib/api';
import PageHeader from '../components/PageHeader';
import DataTable from '../components/DataTable';

export default function PortfoliosPage() {
  const [data, setData] = useState<any[]>([]);
  const [total, setTotal] = useState(0);
  const [page, setPage] = useState(1);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    setLoading(true);
    api.get('/portfolios', { params: { page, limit: 20 } }).then((res) => {
      setData(res.data.data || res.data);
      setTotal(res.data.total || 0);
      setLoading(false);
    });
  }, [page]);

  const columns = [
    { key: 'portfolioName', label: 'Name', render: (p: any) => p.portfolioName || p.type || 'Portfolio' },
    { key: 'totalValue', label: 'Value', render: (p: any) => `AED ${(p.totalValue || 0).toLocaleString()}` },
    { key: 'totalInvested', label: 'Invested', render: (p: any) => `AED ${(p.totalInvested || 0).toLocaleString()}` },
    { key: 'returnPercentage', label: 'Return', render: (p: any) => `${(p.returnPercentage || 0).toFixed(1)}%` },
    { key: 'riskLevel', label: 'Risk' },
    { key: 'createdAt', label: 'Created', render: (p: any) => new Date(p.createdAt).toLocaleDateString() },
  ];

  return (
    <PageHeader title="Portfolios">
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
