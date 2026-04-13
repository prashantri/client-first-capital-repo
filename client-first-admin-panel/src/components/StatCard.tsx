interface Props {
  label: string;
  value: string | number;
  change?: string;
  icon?: string;
}

export default function StatCard({ label, value, change, icon }: Props) {
  return (
    <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-5">
      <div className="flex items-center justify-between">
        <p className="text-sm font-medium text-gray-500">{label}</p>
        {icon && <span className="text-2xl">{icon}</span>}
      </div>
      <p className="text-2xl font-bold text-gray-900 mt-2">{value}</p>
      {change && (
        <p className={`text-xs mt-1 ${change.startsWith('+') ? 'text-green-600' : 'text-red-600'}`}>
          {change}
        </p>
      )}
    </div>
  );
}
