import React from 'react';
import { useDemo } from '../bridge/DemoContext';
import * as S from '../app/screens';

const ROUTES: Record<string, () => React.JSX.Element> = {
  splash: S.Splash,
  onboarding: S.Onboarding,
  login: S.Login,
  signup: S.Signup,
  forget: S.Forget,
  'citizen-home': S.CitizenHome,
  reports: S.ReportsList,
  'add-report': S.AddReport,
  'report-details': S.ReportDetails,
  notifications: S.Notifications,
  achievements: S.Achievements,
  profile: S.Profile,
  'worker-home': S.WorkerHome,
  tasks: S.Tasks,
  'task-details': S.TaskDetails,
  verification: S.Verification,
};

export function PhoneFrame() {
  const { route, banner, dismissBanner, locked, setLocked, inbox, sheet, closeSheet, t, dir, theme, frame, zoom, runAction } = useDemo();
  const Screen = ROUTES[route] ?? S.CitizenHome;
  return (
    <div className="phone-wrap">
      <div className={`phone ${frame}`} style={{ transform: `scale(${zoom})`, transformOrigin: 'top center' }}>
        <div className="side-btn left1" /><div className="side-btn left2" /><div className="side-btn right" />
        <div className="screen" dir={dir} data-theme={theme}>
          <div className="statusbar"><span>9:41</span><span>📶 📡 🔋</span></div>
          <div className="island"><div className="island-dot" /></div>
          <div className="app-body"><Screen /></div>
          {banner && !locked && (
            <div className="banner" role="status" aria-live="polite" onClick={() => dismissBanner(true)}>
              <span style={{ fontSize: 22 }}>🔔</span>
              <div style={{ flex: 1 }}><div style={{ fontWeight: 800, fontSize: 13 }}>{t(banner.title, banner.titleAr)}</div><div style={{ fontSize: 12, opacity: 0.9 }}>{t(banner.body, banner.bodyAr)}</div></div>
              <button aria-label="dismiss" onClick={(e) => { e.stopPropagation(); dismissBanner(false); }} style={{ background: 'transparent', border: 0, color: '#fff' }}>✕</button>
            </div>
          )}
          {locked && <LockScreen />}
          {sheet && <Sheet name={sheet} />}
          <div className="bottompad"><div className="home-ind" /></div>
        </div>
      </div>
      <div style={{ display: 'flex', gap: 8 }}>
        <button className="pbtn" onClick={() => setLocked(!locked)}>{locked ? '🔓 Unlock' : '🔒 Lock screen'} ({inbox.length})</button>
        {sheet && <button className="pbtn" onClick={closeSheet}>Close sheet</button>}
      </div>
    </div>
  );
}

function LockScreen() {
  const { inbox, setLocked, navigate, t } = useDemo();
  return (
    <div className="lockscreen">
      <div style={{ fontSize: 13, opacity: 0.8 }}>9:41 • {new Date().toLocaleDateString()}</div>
      <h2 style={{ margin: '4px 0 12px' }}>🔒 {t('Locked', 'مغلق')}</h2>
      {inbox.length === 0 && <div style={{ opacity: 0.7, fontSize: 13 }}>{t('No notifications', 'لا توجد إشعارات')}</div>}
      {inbox.slice(0, 4).map((n, i) => (
        <button key={i} className="lockcard" onClick={() => { setLocked(false); navigate(n.route); }}>
          <b style={{ fontSize: 13 }}>{t(n.title, n.titleAr)}</b><br /><span style={{ fontSize: 12 }}>{t(n.body, n.bodyAr)}</span>
        </button>
      ))}
      <button className="pbtn" style={{ marginTop: 14 }} onClick={() => setLocked(false)}>{t('Swipe to unlock', 'اسحب للفتح')}</button>
    </div>
  );
}

function Sheet({ name }: { name: string }) {
  const { closeSheet, t, notify } = useDemo();
  return (
    <>
      <div className="sheetbk" onClick={closeSheet} />
      <div className="sheet" role="dialog" aria-modal="true">
        {name === 'camera' && (<><h3>📷 {t('Camera / Gallery (simulated)', 'الكاميرا / المعرض (محاكاة)')}</h3><p style={{ fontSize: 13, color: 'var(--muted)' }}>image_picker • wechat_assets_picker • video_compress</p><div style={{ display: 'flex', gap: 8 }}><button className="btn primary" onClick={closeSheet}>📸 Capture</button><button className="btn ghost" onClick={closeSheet}>🖼️ Gallery</button></div></>)}
        {name === 'map' && (<><h3>🗺️ Map & Routing (simulated)</h3><p style={{ fontSize: 13, color: 'var(--muted)' }}>flutter_map • OSM • OSRM • geofencing — 1.2 KM, inside zone</p><button className="btn primary" onClick={closeSheet}>Got it</button></>)}
        {name === 'pdf' && (<><h3>🖨️ PDF export (simulated)</h3><p style={{ fontSize: 13, color: 'var(--muted)' }}>pdf + printing + screenshot — full lifecycle: report + photos + notes + timeline.</p><button className="btn primary" onClick={closeSheet}>Download PDF</button></>)}
        {name === 'geofence' && (<><h3>📡 Geofence check</h3><p>✅ Inside Work Zone — monitoring active.</p><button className="btn primary" onClick={closeSheet}>OK</button></>)}
        {name === 'otp' && (<><h3>🔢 OTP Verification</h3><div style={{ display: 'flex', gap: 8 }}>{[1, 2, 3, 4, 5, 6].map((x) => <input key={x} className="input" style={{ textAlign: 'center' }} maxLength={1} aria-label={`digit ${x}`} />)}</div><button className="btn primary" onClick={closeSheet}>{t('Confirm', 'تأكيد')}</button></>)}
        {name === 'verify' && (<><h3>✅ Submitted</h3><p style={{ fontSize: 13 }}>{t('Request sent successfully. Review takes 24–48h.', 'تم إرسال الطلب بنجاح. المراجعة 24-48 ساعة.')}</p><button className="btn primary" onClick={closeSheet}>OK</button></>)}
        {name === 'sent' && (<><h3>✅ {t('Report sent successfully', 'تم إرسال البلاغ بنجاح')}</h3><p style={{ fontSize: 13, color: 'var(--muted)' }}>FCM push → worker dashboard + local notification.</p><div style={{ display: 'flex', gap: 8 }}><button className="btn primary" onClick={() => { closeSheet(); notify({ id: 'x', title: 'New task assigned', titleAr: 'مهمة جديدة', body: 'Pothole #1042 assigned to you', bodyAr: 'تم إسناد الحفرة #1042 إليك', route: 'task-details', source: 'example' }); }}>Simulate worker push</button></div></>)}
        {name === 'done' && (<><h3>🎉 Task completed</h3><p style={{ fontSize: 13 }}>Proof-of-work uploaded. Citizen notified + PDF ready.</p><button className="btn primary" onClick={closeSheet}>Done</button></>)}
        <div style={{ height: 8 }} />
        <button className="btn ghost" onClick={closeSheet}>{t('Close', 'إغلاق')}</button>
      </div>
    </>
  );
}
