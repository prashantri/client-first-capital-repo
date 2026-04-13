import { useEffect, useState } from 'react';
import api from '../lib/api';
import PageHeader from '../components/PageHeader';
import DataTable from '../components/DataTable';

export default function ValuationsPage() {
  const [data, setData] = useState<any[]>([]);
  const [total, setTotal] = useState(0);
  const [page, setPage] = useState(1);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    setLoading(true);
    api.get('/valuations', { params: { page, limit: 20 } }).then((res) => {
      setData(res.data.data || res.data);
      setTotal(res.data.total || 0);
      setLoading(false);
    });
  }, [page]);

  const columns = [
    { key: 'valuationDate', label: 'Date', render: (v: any) => new Date(v.valuationDate).toLocaleDateString() },
    { key: 'sharePrice', label: 'Share Price', render: (v: any) => `AED ${(v.sharePrice || 0).toFixed(2)}` },
    { key: 'totalShares', label: 'Total Shares', render: (v: any) => (v.totalShares || 0).toLocaleString() },
    { key: 'companyValuation', label: 'Valuation', render: (v: any) => `AED ${(v.companyValuation / 1e6 || 0).toFixed(1)}M` },
    { key: 'navPerShare', label: 'NAV/Share', render: (v: any) => `AED ${(v.navPerShare || 0).toFixed(2)}` },
  ];

  return (
    <PageHeader title="Company Valuations">
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
