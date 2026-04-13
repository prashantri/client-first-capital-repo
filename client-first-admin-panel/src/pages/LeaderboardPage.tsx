import { useEffect, useState } from 'react';
import api from '../lib/api';
import PageHeader from '../components/PageHeader';
import DataTable from '../components/DataTable';

export default function LeaderboardPage() {
  const [data, setData] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [period, setPeriod] = useState('monthly');

  useEffect(() => {
    setLoading(true);
    api.get('/leaderboard', { params: { period } }).then((res) => {
      setData(res.data.data || res.data || []);
      setLoading(false);
    });
  }, [period]);

  const columns = [
    { key: 'rank', label: 'Rank', render: (_: any, i: number) => i + 1 },
    { key: 'introducerName', label: 'Introducer' },
    { key: 'totalReferrals', label: 'Referrals' },
    { key: 'convertedReferrals', label: 'Converted' },
    { key: 'totalCommission', label: 'Commission', render: (l: any) => `AED ${(l.totalCommission || 0).toLocaleString()}` },
    { key: 'totalAum', label: 'AUM', render: (l: any) => `AED ${(l.totalAum || 0).toLocaleString()}` },
    { key: 'score', label: 'Score' },
  ];

  return (
    <PageHeader
      title="Leaderboard"
      action={
        <select value={period} onChange={(e) => setPeriod(e.target.value)}
          className="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-primary-500 outline-none">
          <option value="monthly">Monthly</option>
          <option value="quarterly">Quarterly</option>
          <option value="yearly">Yearly</option>
          <option value="all-time">All Time</option>
        </select>
      }
    >
      <DataTable columns={columns} data={data} loading={loading} />
    </PageHeader>
  );
}
