import { Routes, Route, Navigate } from 'react-router-dom';
import { useAuth } from './context/AuthContext';
import AdminLayout from './components/AdminLayout';
import LoginPage from './pages/LoginPage';
import DashboardPage from './pages/DashboardPage';
import UsersPage from './pages/UsersPage';
import ReferralsPage from './pages/ReferralsPage';
import CommissionsPage from './pages/CommissionsPage';
import PortfoliosPage from './pages/PortfoliosPage';
import KycPage from './pages/KycPage';
import AppointmentsPage from './pages/AppointmentsPage';
import MarketingPage from './pages/MarketingPage';
import LeaderboardPage from './pages/LeaderboardPage';
import ValuationsPage from './pages/ValuationsPage';
import ShareholdingsPage from './pages/ShareholdingsPage';
import EducationPage from './pages/EducationPage';
import CompliancePage from './pages/CompliancePage';
import NotificationsPage from './pages/NotificationsPage';
import AuditLogPage from './pages/AuditLogPage';

function ProtectedRoute({ children }: { children: React.ReactNode }) {
  const { user, loading } = useAuth();
  if (loading) return <div className="min-h-screen flex items-center justify-center text-gray-400">Loading...</div>;
  if (!user) return <Navigate to="/login" replace />;
  return <>{children}</>;
}

export default function App() {
  const { user, loading } = useAuth();

  if (loading) return <div className="min-h-screen flex items-center justify-center text-gray-400">Loading...</div>;

  return (
    <Routes>
      <Route path="/login" element={user ? <Navigate to="/" replace /> : <LoginPage />} />
      <Route path="/" element={<ProtectedRoute><AdminLayout /></ProtectedRoute>}>
        <Route index element={<DashboardPage />} />
        <Route path="users" element={<UsersPage />} />
        <Route path="referrals" element={<ReferralsPage />} />
        <Route path="commissions" element={<CommissionsPage />} />
        <Route path="portfolios" element={<PortfoliosPage />} />
        <Route path="kyc" element={<KycPage />} />
        <Route path="appointments" element={<AppointmentsPage />} />
        <Route path="marketing" element={<MarketingPage />} />
        <Route path="leaderboard" element={<LeaderboardPage />} />
        <Route path="valuations" element={<ValuationsPage />} />
        <Route path="shareholdings" element={<ShareholdingsPage />} />
        <Route path="education" element={<EducationPage />} />
        <Route path="compliance" element={<CompliancePage />} />
        <Route path="notifications" element={<NotificationsPage />} />
        <Route path="audit-log" element={<AuditLogPage />} />
      </Route>
      <Route path="*" element={<Navigate to="/" replace />} />
    </Routes>
  );
}
