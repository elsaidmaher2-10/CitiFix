import React from 'react';
import { useDemo, DEMO_CONFIG } from '../bridge/DemoContext';

export function ControlPanel() {
  const d = useDemo();
  return (
    <div className="panel">
      <h2>📱 {d.t(DEMO_CONFIG.appName, DEMO_CONFIG.appNameAr)} — Demo Console</h2>
      <p className="d">{DEMO_CONFIG.description} • v{DEMO_CONFIG.version} • original: Flutter, rebuilt in React (no Flutter Web).</p>

      <div className="psec">
        <h3>Role / الدور</h3>
        <div className="prow">
          <button className={`pbtn ${d.role === 'citizen' ? 'on' : ''}`} onClick={() => d.setRole('citizen')}>🧍 Citizen</button>
          <button className={`pbtn ${d.role === 'worker' ? 'on' : ''}`} onClick={() => d.setRole('worker')}>🦺 Worker</button>
        </div>
      </div>

      <div className="psec">
        <h3>Push notifications — from real flows (FCM + local)</h3>
        <div className="prow">
          {DEMO_CONFIG.notifications.map((n) => (
            <button key={n.id} className="pbtn" onClick={() => d.notify(n)}>🔔 {d.lang === 'ar' ? n.titleAr : n.title}</button>
          ))}
        </div>
        <div style={{ fontSize: 11, color: '#7d93b2', marginTop: 6 }}>Banner + inbox badge + lock-screen stay in sync (like production handler). Last one has 🖼️ rich image.</div>
      </div>

      <div className="psec">
        <h3>Deep links</h3>
        <div className="prow">
          {DEMO_CONFIG.deepLinks.map((l) => (
            <button key={l.label} className="pbtn" onClick={() => d.navigate(l.route)}>🔗 {l.label}</button>
          ))}
        </div>
      </div>

      <div className="psec">
        <h3>Features (simulated hardware/backend)</h3>
        <div className="prow">
          {DEMO_CONFIG.features.map((f) => (
            <button key={f.id} className="pbtn" onClick={() => d.runAction(f.id === 'camera' ? 'camera' : f.id === 'map' ? 'map' : f.id === 'pdf' ? 'pdf' : f.id === 'geofence' ? 'geofence' : f.id === 'otp' ? 'otp' : 'verify')}>⚡ {d.lang === 'ar' ? f.labelAr : f.label}</button>
          ))}
        </div>
      </div>

      <div className="psec">
        <h3>Screens</h3>
        <div className="prow">
          {['splash', 'onboarding', 'login', 'citizen-home', 'reports', 'add-report', 'report-details', 'notifications', 'achievements', 'worker-home', 'tasks', 'task-details', 'verification', 'profile'].map((r) => (
            <button key={r} className={`pbtn ${d.route === r ? 'on' : ''}`} onClick={() => d.navigate(r)}>{r}</button>
          ))}
        </div>
        <div className="prow" style={{ marginTop: 8 }}>
          <button className="pbtn" onClick={d.back}>← Back</button>
          <button className={`pbtn ${d.lang === 'ar' ? 'on' : ''}`} onClick={() => d.setLang(d.lang === 'en' ? 'ar' : 'en')}>{d.lang === 'en' ? 'عربي RTL' : 'English LTR'}</button>
          <button className={`pbtn ${d.theme === 'dark' ? 'on' : ''}`} onClick={() => d.setTheme(d.theme === 'light' ? 'dark' : 'light')}>🌙 {d.theme}</button>
        </div>
      </div>

      <div className="psec">
        <h3>Frame</h3>
        <div className="prow">
          {['black', 'titanium', 'blue', 'orange'].map((c) => <button key={c} className={`pbtn ${d.frame === c ? 'on' : ''}`} onClick={() => d.setFrame(c)}>{c}</button>)}
          {[0.8, 1, 1.15].map((z) => <button key={z} className={`pbtn ${d.zoom === z ? 'on' : ''}`} onClick={() => d.setZoom(z)}>{Math.round(z * 100)}%</button>)}
        </div>
      </div>
    </div>
  );
}
