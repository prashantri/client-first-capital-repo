import { NavLink } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';

const nav = [
  { to: '/', label: 'Dashboard', icon: '📊' },
  { to: '/kyc', label: 'KYC Applications', icon: '📋' },
  { to: '/referrals', label: 'Referrals', icon: '🤝' },
  { to: '/users', label: 'Users', icon: '👥' },
  { to: '/commissions', label: 'Commissions', icon: '💰' },
  { to: '/leaderboard', label: 'Leaderboard', icon: '🏆' },
  { to: '/audit-log', label: 'Audit Log', icon: '🗒️' },
];

export default function Sidebar() {
  const { user, logout } = useAuth();

  return (
    <aside className="fixed left-0 top-0 h-screen w-64 bg-gray-900 text-white flex flex-col z-30">
      <div className="p-5 border-b border-gray-700">
        <h1 className="text-lg font-bold">Client First Capital</h1>
        <p className="text-xs text-gray-400 mt-1">Admin Panel</p>
      </div>

      <nav className="flex-1 overflow-y-auto py-4">
        {nav.map((item) => (
          <NavLink
            key={item.to}
            to={item.to}
            end={item.to === '/'}
            className={({ isActive }) =>
              `flex items-center gap-3 px-5 py-2.5 text-sm transition-colors ${
                isActive ? 'bg-primary-600 text-white' : 'text-gray-300 hover:bg-gray-800 hover:text-white'
              }`
            }
          >
            <span>{item.icon}</span>
            <span>{item.label}</span>
          </NavLink>
        ))}
      </nav>

      <div className="p-4 border-t border-gray-700">
        <p className="text-sm font-medium truncate">{user?.firstName} {user?.lastName}</p>
        <p className="text-xs text-gray-400 truncate">{user?.email}</p>
        <button onClick={logout} className="mt-2 text-xs text-red-400 hover:text-red-300">
          Sign Out
        </button>
      </div>
    </aside>
  );
}
