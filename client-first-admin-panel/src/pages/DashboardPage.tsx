import { useEffect, useState } from 'react';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, PieChart, Pie, Cell } from 'recharts';
import api from '../lib/api';
import StatCard from '../components/StatCard';
import PageHeader from '../components/PageHeader';

const COLORS = ['#3b82f6', '#10b981', '#f59e0b', '#ef4444', '#8b5cf6'];

export default function DashboardPage() {
  const [stats, setStats] = useState({ totalUsers: 0, totalReferrals: 0, totalPortfolios: 0, totalAum: 0 });
  const [usersByRole, setUsersByRole] = useState<any[]>([]);
  const [referralsByStatus, setReferralsByStatus] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    Promise.all([
      api.get('/users/stats').catch(() => ({ data: {} })),
      api.get('/users?limit=1').catch(() => ({ data: { total: 0 } })),
      api.get('/referrals?limit=1').catch(() => ({ data: { total: 0 } })),
      api.get('/portfolios?limit=1').catch(() => ({ data: { total: 0 } })),
    ]).then(([statsRes, usersRes, referralsRes, portfoliosRes]) => {
      const s = statsRes.data;
      setStats({
        totalUsers: s.total || usersRes.data.total || 0,
        totalReferrals: referralsRes.data.total || 0,
        totalPortfolios: portfoliosRes.data.total || 0,
        totalAum: s.totalAum || 0,
      });

      if (s.byRole) {
        setUsersByRole(Object.entries(s.byRole).map(([name, value]) => ({ name, value })));
      }
      if (s.referralsByStatus) {
        setReferralsByStatus(Object.entries(s.referralsByStatus).map(([name, value]) => ({ name, value })));
      }
      setLoading(false);
    });
  }, []);

  return (
    <PageHeader title="Dashboard">
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-5 mb-8">
        <StatCard label="Total Users" value={loading ? '...' : stats.totalUsers} icon="👥" />
        <StatCard label="Total Referrals" value={loading ? '...' : stats.totalReferrals} icon="🤝" />
        <StatCard label="Portfolios" value={loading ? '...' : stats.totalPortfolios} icon="📈" />
        <StatCard label="Total AUM" value={loading ? '...' : `AED ${(stats.totalAum / 1e6).toFixed(1)}M`} icon="💰" />
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-5">
          <h3 className="text-sm font-semibold text-gray-700 mb-4">Users by Role</h3>
          <ResponsiveContainer width="100%" height={260}>
            <PieChart>
              <Pie data={usersByRole} dataKey="value" nameKey="name" cx="50%" cy="50%" outerRadius={90} label>
                {usersByRole.map((_, i) => <Cell key={i} fill={COLORS[i % COLORS.length]} />)}
              </Pie>
              <Tooltip />
            </PieChart>
          </ResponsiveContainer>
        </div>

        <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-5">
          <h3 className="text-sm font-semibold text-gray-700 mb-4">Referrals by Status</h3>
          <ResponsiveContainer width="100%" height={260}>
            <BarChart data={referralsByStatus}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="name" tick={{ fontSize: 12 }} />
              <YAxis />
              <Tooltip />
              <Bar dataKey="value" fill="#3b82f6" radius={[4, 4, 0, 0]} />
            </BarChart>
          </ResponsiveContainer>
        </div>
      </div>
    </PageHeader>
  );
}
