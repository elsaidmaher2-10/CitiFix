import React from 'react';
import { useDemo } from '../bridge/DemoContext';

export function Header({ title, sub }: { title: string; sub?: string }) {
  const { unread, navigate, role, t } = useDemo();
  return (
    <div className="hdr">
      <div className="brand">
        <div className={`logo ${role === 'worker' ? 'worker' : 'citizen'}`}>C</div>
        <div>
          <div style={{ fontWeight: 800 }}>{title}</div>
          {sub && <div style={{ fontSize: 12, color: 'var(--muted)' }}>{sub}</div>}
        </div>
      </div>
      <button className="bell" aria-label={t('Notifications', 'الإشعارات')} onClick={() => navigate('notifications')}>
        🔔{unread > 0 && <span className="badge">{unread}</span>}
      </button>
    </div>
  );
}

export function Chip({ status }: { status: string }) {
  const map: Record<string, string> = { pending: 'Pending • قيد الانتظار', progress: 'In Progress • قيد التنفيذ', resolved: 'Resolved • تم الحل' };
  const cls = status === 'pending' ? 'pending' : status === 'progress' ? 'progress' : 'resolved';
  return <span className={`chip ${cls}`}>{map[status] ?? status}</span>;
}

export function MapFake({ routeLine }: { routeLine?: boolean }) {
  return (
    <div className="mapfake" role="img" aria-label="Map preview">
      {routeLine && <div className="routeline" />}
      <div className="pin">📍</div>
      <div style={{ position: 'absolute', bottom: 8, left: 8, background: '#fff', borderRadius: 8, padding: '4px 8px', fontSize: 12, fontWeight: 700 }}>OpenStreetMap • OSRM</div>
    </div>
  );
}

export function BottomNav({ items }: { items: { id: string; icon: string; label: string; labelAr: string }[] }) {
  const { route, navigate, t, role } = useDemo();
  const w = role === 'worker';
  return (
    <div className="bottomnav">
      {items.map((it) => (
        <button key={it.id} className={`navbtn ${route.startsWith(it.id) ? 'active' : ''} ${w ? 'w' : ''}`} onClick={() => navigate(it.id)}>
          <span className="ic">{it.icon}</span>
          {t(it.label, it.labelAr)}
        </button>
      ))}
    </div>
  );
}

export function Field({ ph }: { ph: string }) {
  return <input className="input" placeholder={ph} />;
}
