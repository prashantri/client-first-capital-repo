import { useEffect, useState } from 'react';
import api from '../lib/api';
import PageHeader from '../components/PageHeader';
import DataTable from '../components/DataTable';
import Badge from '../components/Badge';

const DOC_TYPES = ['license_document', 'pan_card', 'aadhaar_front', 'aadhaar_back', 'address_proof'];
const DOC_LABELS: Record<string, string> = {
  license_document: 'License / ID Document',
  pan_card: 'PAN Card',
  aadhaar_front: 'Aadhaar Front',
  aadhaar_back: 'Aadhaar Back',
  address_proof: 'Address Proof',
};

const STATUS_OPTIONS = ['all', 'submitted', 'approved', 'rejected', 'in_progress', 'not_started'];

export default function KycPage() {
  const [data, setData] = useState<any[]>([]);
  const [total, setTotal] = useState(0);
  const [pendingCount, setPendingCount] = useState(0);
  const [page, setPage] = useState(1);
  const [loading, setLoading] = useState(true);
  const [statusFilter, setStatusFilter] = useState('all');
  const [selectedApp, setSelectedApp] = useState<any>(null);
  const [detailLoading, setDetailLoading] = useState(false);
  const [reviewNote, setReviewNote] = useState('');

  // Reject reason modal state
  const [rejectModal, setRejectModal] = useState<{ id: string; name: string } | null>(null);
  const [rejectReason, setRejectReason] = useState('');
  const [rejectLoading, setRejectLoading] = useState(false);

  const fetchData = () => {
    setLoading(true);
    const params: any = { page, limit: 20 };
    if (statusFilter !== 'all') params.status = statusFilter;
    Promise.all([
      api.get('/kyc', { params }),
      api.get('/kyc/pending-count'),
    ]).then(([kyc, pending]) => {
      setData(kyc.data.data || kyc.data);
      setTotal(kyc.data.total || 0);
      setPendingCount(pending.data);
      setLoading(false);
    }).catch(() => setLoading(false));
  };

  useEffect(() => { fetchData(); }, [page, statusFilter]);

  const handleApprove = async (id: string) => {
    await api.post(`/kyc/${id}/review`, { status: 'approved', reviewNotes: reviewNote || 'Approved by admin' });
    setSelectedApp(null);
    setReviewNote('');
    fetchData();
  };

  const openRejectModal = (id: string, name: string) => {
    setRejectReason('');
    setRejectModal({ id, name });
    setSelectedApp(null);
  };

  const handleReject = async () => {
    if (!rejectReason.trim()) return;
    if (!rejectModal) return;
    setRejectLoading(true);
    await api.post(`/kyc/${rejectModal.id}/review`, {
      status: 'rejected',
      rejectionReason: rejectReason.trim(),
      reviewNotes: rejectReason.trim(),
    });
    setRejectModal(null);
    setRejectReason('');
    setRejectLoading(false);
    fetchData();
  };

  const viewDetail = async (app: any) => {
    setDetailLoading(true);
    setSelectedApp(app);
    setReviewNote('');
    try {
      const res = await api.get(`/kyc/${app._id}`);
      setSelectedApp(res.data);
    } catch {
      // use list data if detail fails
    }
    setDetailLoading(false);
  };

  const viewDocument = async (appId: string, docType: string) => {
    try {
      const res = await api.get(`/kyc/${appId}/document/${docType}`, { responseType: 'blob' });
      const url = URL.createObjectURL(res.data);
      window.open(url, '_blank');
    } catch {
      alert('Failed to load document');
    }
  };

  const statusColor = (s: string): 'green' | 'yellow' | 'blue' | 'red' | 'gray' | 'purple' => {
    const map: Record<string, any> = { approved: 'green', pending: 'yellow', submitted: 'blue', rejected: 'red', under_review: 'purple', in_progress: 'yellow', not_started: 'gray' };
    return map[s] || 'gray';
  };

  const columns = [
    {
      key: 'user', label: 'Applicant', render: (k: any) => {
        const u = k.userId;
        return u && typeof u === 'object' ? (
          <div>
            <div className="font-medium text-gray-900">{u.fullName}</div>
            <div className="text-xs text-gray-500">{u.email}</div>
          </div>
        ) : (k.fullName || '—');
      },
    },
    {
      key: 'userStatus', label: 'Account', render: (k: any) => {
        const u = k.userId;
        const s = u?.status || '—';
        const c = s === 'active' ? 'green' : s === 'pending' ? 'yellow' : s === 'suspended' ? 'red' : 'gray';
        return <Badge label={s} color={c as any} />;
      },
    },
    {
      key: 'documents', label: 'Documents', render: (k: any) => {
        const docs = k.documents || {};
        const uploaded = DOC_TYPES.filter(dt => docs[dt]?.fileName);
        return <span className="text-xs text-gray-600">{uploaded.length}/{DOC_TYPES.length} uploaded</span>;
      },
    },
    { key: 'status', label: 'KYC Status', render: (k: any) => <Badge label={k.status?.replace(/_/g, ' ')} color={statusColor(k.status)} /> },
    { key: 'submittedAt', label: 'Submitted', render: (k: any) => k.submittedAt ? new Date(k.submittedAt).toLocaleDateString() : '—' },
    {
      key: 'actions', label: 'Actions', render: (k: any) => (
        <div className="flex gap-2">
          <button onClick={() => viewDetail(k)} className="text-xs bg-blue-100 text-blue-700 px-2 py-1 rounded hover:bg-blue-200">View</button>
          {k.status === 'submitted' && (
            <>
              <button onClick={() => handleApprove(k._id)} className="text-xs bg-green-100 text-green-700 px-2 py-1 rounded hover:bg-green-200">Approve</button>
              <button onClick={() => openRejectModal(k._id, k.userId?.fullName || k.fullName)} className="text-xs bg-red-100 text-red-700 px-2 py-1 rounded hover:bg-red-200">Reject</button>
            </>
          )}
        </div>
      ),
    },
  ];

  return (
    <PageHeader
      title="KYC Applications"
      action={
        <select
          value={statusFilter}
          onChange={(e) => { setStatusFilter(e.target.value); setPage(1); }}
          className="text-sm border border-gray-300 rounded-lg px-3 py-2 bg-white"
        >
          {STATUS_OPTIONS.map(s => (
            <option key={s} value={s}>{s === 'all' ? 'All Statuses' : s.replace(/_/g, ' ').replace(/\b\w/g, c => c.toUpperCase())}</option>
          ))}
        </select>
      }
    >
      {/* Pending Review Banner */}
      {pendingCount > 0 && (
        <div className="mb-4 flex items-center gap-3 bg-amber-50 border border-amber-200 rounded-lg px-4 py-3">
          <span className="inline-flex items-center justify-center w-8 h-8 rounded-full bg-amber-500 text-white text-sm font-bold">{pendingCount}</span>
          <div>
            <p className="text-sm font-semibold text-amber-800">
              {pendingCount} application{pendingCount > 1 ? 's' : ''} pending review
            </p>
            <p className="text-xs text-amber-600">Filter by "Submitted" to see the queue</p>
          </div>
          <button
            onClick={() => { setStatusFilter('submitted'); setPage(1); }}
            className="ml-auto text-xs bg-amber-500 text-white px-3 py-1.5 rounded-lg hover:bg-amber-600 font-medium"
          >
            View Queue
          </button>
        </div>
      )}

      <DataTable columns={columns} data={data} loading={loading} />
      <div className="flex items-center justify-between mt-4 text-sm text-gray-500">
        <span>Total: {total}</span>
        <div className="flex gap-2">
          <button onClick={() => setPage(p => Math.max(1, p - 1))} disabled={page <= 1} className="px-3 py-1 border rounded disabled:opacity-40">Prev</button>
          <span className="px-3 py-1">Page {page}</span>
          <button onClick={() => setPage(p => p + 1)} disabled={data.length < 20} className="px-3 py-1 border rounded disabled:opacity-40">Next</button>
        </div>
      </div>

      {/* Detail Modal */}
      {selectedApp && (
        <div className="fixed inset-0 bg-black/40 flex items-center justify-center z-50" onClick={() => setSelectedApp(null)}>
          <div className="bg-white rounded-xl shadow-xl max-w-2xl w-full mx-4 max-h-[85vh] overflow-y-auto" onClick={e => e.stopPropagation()}>
            <div className="px-6 py-4 border-b border-gray-200 flex items-center justify-between">
              <h2 className="text-lg font-semibold text-gray-900">KYC Application Details</h2>
              <button onClick={() => setSelectedApp(null)} className="text-gray-400 hover:text-gray-600 text-xl">&times;</button>
            </div>

            {detailLoading ? (
              <div className="p-8 text-center text-gray-400">Loading...</div>
            ) : (
              <div className="p-6 space-y-6">
                {/* Applicant Info */}
                <div>
                  <h3 className="text-sm font-semibold text-gray-500 uppercase tracking-wide mb-3">Applicant</h3>
                  <div className="grid grid-cols-2 gap-3 text-sm">
                    <div><span className="text-gray-500">Name:</span> <span className="font-medium">{selectedApp.userId?.fullName || selectedApp.fullName}</span></div>
                    <div><span className="text-gray-500">Email:</span> <span className="font-medium">{selectedApp.userId?.email || selectedApp.email}</span></div>
                    <div><span className="text-gray-500">Phone:</span> <span className="font-medium">{selectedApp.phone || '—'}</span></div>
                    <div><span className="text-gray-500">Role:</span> <Badge label={selectedApp.userId?.role || '—'} color="purple" /></div>
                    <div><span className="text-gray-500">Account Status:</span> <Badge label={selectedApp.userId?.status || '—'} color={selectedApp.userId?.status === 'active' ? 'green' : 'yellow'} /></div>
                    <div><span className="text-gray-500">KYC Status:</span> <Badge label={selectedApp.status?.replace(/_/g, ' ')} color={statusColor(selectedApp.status)} /></div>
                    {selectedApp.submittedAt && <div><span className="text-gray-500">Submitted:</span> <span className="font-medium">{new Date(selectedApp.submittedAt).toLocaleString()}</span></div>}
                    {selectedApp.reviewedAt && <div><span className="text-gray-500">Reviewed:</span> <span className="font-medium">{new Date(selectedApp.reviewedAt).toLocaleString()}</span></div>}
                  </div>
                </div>

                {/* Documents */}
                <div>
                  <h3 className="text-sm font-semibold text-gray-500 uppercase tracking-wide mb-3">Documents</h3>
                  <div className="space-y-2">
                    {DOC_TYPES.map(dt => {
                      const doc = selectedApp.documents?.[dt];
                      return (
                        <div key={dt} className="flex items-center justify-between bg-gray-50 rounded-lg px-4 py-3">
                          <div>
                            <div className="text-sm font-medium text-gray-700">{DOC_LABELS[dt]}</div>
                            {doc?.fileName ? (
                              <div className="text-xs text-gray-500">{doc.fileName} &middot; {doc.uploadedAt ? new Date(doc.uploadedAt).toLocaleDateString() : ''}</div>
                            ) : (
                              <div className="text-xs text-gray-400">Not uploaded</div>
                            )}
                          </div>
                          {doc?.fileName && (
                            <button onClick={() => viewDocument(selectedApp._id, dt)} className="text-xs bg-blue-100 text-blue-700 px-3 py-1.5 rounded hover:bg-blue-200 font-medium">
                              View
                            </button>
                          )}
                        </div>
                      );
                    })}
                  </div>
                </div>

                {/* Review Actions */}
                {selectedApp.status === 'submitted' && (
                  <div className="border-t border-gray-200 pt-4">
                    <h3 className="text-sm font-semibold text-gray-500 uppercase tracking-wide mb-3">Review</h3>
                    <textarea
                      value={reviewNote}
                      onChange={e => setReviewNote(e.target.value)}
                      placeholder="Review notes (optional)..."
                      className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm mb-3 resize-none"
                      rows={2}
                    />
                    <div className="flex gap-3">
                      <button
                        onClick={() => handleApprove(selectedApp._id)}
                        className="flex-1 bg-green-600 text-white py-2 rounded-lg text-sm font-medium hover:bg-green-700"
                      >
                        ✓ Approve &amp; Activate
                      </button>
                      <button
                        onClick={() => openRejectModal(selectedApp._id, selectedApp.userId?.fullName || selectedApp.fullName)}
                        className="flex-1 bg-red-600 text-white py-2 rounded-lg text-sm font-medium hover:bg-red-700"
                      >
                        ✕ Reject
                      </button>
                    </div>
                  </div>
                )}

                {/* Review history */}
                {selectedApp.reviewNotes && (
                  <div className="bg-gray-50 rounded-lg p-3 text-sm">
                    <span className="text-gray-500">Review Notes:</span> <span className="font-medium">{selectedApp.reviewNotes}</span>
                  </div>
                )}
                {selectedApp.rejectionReason && (
                  <div className="bg-red-50 rounded-lg p-3 text-sm">
                    <span className="text-red-500 font-semibold">Rejection Reason:</span> <span className="font-medium">{selectedApp.rejectionReason}</span>
                  </div>
                )}
              </div>
            )}
          </div>
        </div>
      )}

      {/* Reject Reason Modal */}
      {rejectModal && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50" onClick={() => setRejectModal(null)}>
          <div className="bg-white rounded-xl shadow-xl w-full max-w-md mx-4" onClick={e => e.stopPropagation()}>
            <div className="px-6 py-4 border-b border-gray-200 flex items-center justify-between">
              <h2 className="text-base font-semibold text-gray-900">Reject Application</h2>
              <button onClick={() => setRejectModal(null)} className="text-gray-400 hover:text-gray-600 text-xl">&times;</button>
            </div>
            <div className="p-6">
              <p className="text-sm text-gray-600 mb-4">
                You are rejecting the application from <strong>{rejectModal.name}</strong>. The rejection reason will be emailed to the applicant.
              </p>
              <label className="block text-xs font-semibold text-gray-500 uppercase tracking-wide mb-2">
                Rejection Reason <span className="text-red-500">*</span>
              </label>
              <textarea
                value={rejectReason}
                onChange={e => setRejectReason(e.target.value)}
                placeholder="Enter a clear reason for rejection (this will be sent to the applicant)..."
                className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm resize-none focus:outline-none focus:ring-2 focus:ring-red-300"
                rows={4}
                autoFocus
              />
              {!rejectReason.trim() && (
                <p className="text-xs text-red-500 mt-1">A rejection reason is required.</p>
              )}
              <div className="flex gap-3 mt-4">
                <button
                  onClick={() => setRejectModal(null)}
                  className="flex-1 border border-gray-300 text-gray-700 py-2 rounded-lg text-sm font-medium hover:bg-gray-50"
                >
                  Cancel
                </button>
                <button
                  onClick={handleReject}
                  disabled={!rejectReason.trim() || rejectLoading}
                  className="flex-1 bg-red-600 text-white py-2 rounded-lg text-sm font-medium hover:bg-red-700 disabled:opacity-50 disabled:cursor-not-allowed"
                >
                  {rejectLoading ? 'Rejecting...' : 'Confirm Reject & Send Email'}
                </button>
              </div>
            </div>
          </div>
        </div>
      )}
    </PageHeader>
  );
}
