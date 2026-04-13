import { useEffect, useState } from 'react';
import api from '../lib/api';
import PageHeader from '../components/PageHeader';
import DataTable from '../components/DataTable';
import Badge from '../components/Badge';

const roleBadge = (role: string) => {
  const map: Record<string, 'blue' | 'green' | 'purple' | 'yellow' | 'gray'> = {
    admin: 'purple', advisor: 'blue', introducer: 'green', customer: 'yellow', investor: 'gray',
  };
  return <Badge label={role} color={map[role] || 'gray'} />;
};

const statusBadge = (status: string) => {
  const map: Record<string, 'green' | 'yellow' | 'red' | 'gray'> = {
    active: 'green', pending: 'yellow', suspended: 'red', inactive: 'gray',
  };
  return <Badge label={status} color={map[status] || 'gray'} />;
};

export default function UsersPage() {
  const [users, setUsers] = useState<any[]>([]);
  const [total, setTotal] = useState(0);
  const [page, setPage] = useState(1);
  const [loading, setLoading] = useState(true);
  const [role, setRole] = useState('');

  const fetchUsers = (p: number, r: string) => {
    setLoading(true);
    const params: any = { page: p, limit: 20 };
    if (r) params.role = r;
    api.get('/users', { params }).then((res) => {
      setUsers(res.data.data || res.data);
      setTotal(res.data.total || 0);
      setLoading(false);
    });
  };

  useEffect(() => { fetchUsers(page, role); }, [page, role]);

  const columns = [
    { key: 'firstName', label: 'Name', render: (u: any) => `${u.firstName} ${u.lastName}` },
    { key: 'email', label: 'Email' },
    { key: 'role', label: 'Role', render: (u: any) => roleBadge(u.role) },
    { key: 'status', label: 'Status', render: (u: any) => statusBadge(u.status) },
    { key: 'phone', label: 'Phone' },
    { key: 'createdAt', label: 'Joined', render: (u: any) => new Date(u.createdAt).toLocaleDateString() },
  ];

  return (
    <PageHeader
      title="Users"
      action={
        <select value={role} onChange={(e) => { setRole(e.target.value); setPage(1); }}
          className="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-primary-500 outline-none">
          <option value="">All Roles</option>
          <option value="admin">Admin</option>
          <option value="introducer">Introducer</option>
          <option value="advisor">Advisor</option>
          <option value="customer">Customer</option>
          <option value="investor">Investor</option>
        </select>
      }
    >
      <DataTable columns={columns} data={users} loading={loading} />
      <div className="flex items-center justify-between mt-4 text-sm text-gray-500">
        <span>Total: {total}</span>
        <div className="flex gap-2">
          <button onClick={() => setPage(p => Math.max(1, p - 1))} disabled={page <= 1}
            className="px-3 py-1 border rounded disabled:opacity-40">Prev</button>
          <span className="px-3 py-1">Page {page}</span>
          <button onClick={() => setPage(p => p + 1)} disabled={users.length < 20}
            className="px-3 py-1 border rounded disabled:opacity-40">Next</button>
        </div>
      </div>
    </PageHeader>
  );
}
