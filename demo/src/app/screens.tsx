import React, { useState } from 'react';
import { useDemo } from '../bridge/DemoContext';
import { REPORTS, TASKS, COMMENTS } from './data/store';
import { Header, Chip, MapFake, BottomNav, Field } from './components';

export function Splash() {
  const { navigate, t } = useDemo();
  return (
    <div style={{ padding: 24, textAlign: 'center', paddingTop: 90 }}>
      <div className="logo citizen" style={{ width: 84, height: 84, fontSize: 44, margin: '0 auto', borderRadius: 24 }}>C</div>
      <h1 style={{ margin: '16px 0 4px' }}>CitiFix</h1>
      <p style={{ color: 'var(--muted)' }}>{t('Bridging citizens & city maintenance', 'نوصّل المواطن بفرق صيانة المدينة')}</p>
      <div className="card"><div className="kv"><span>Version</span><b>1.0.1+2</b></div><div className="kv"><span>Stack</span><b>Flutter • Firebase • OSM</b></div></div>
      <button className="btn primary" onClick={() => navigate('onboarding')}>{t('Get Started', 'ابدأ الآن')}</button>
    </div>
  );
}

export function Onboarding() {
  const { navigate, t } = useDemo();
  const [i, setI] = useState(0);
  const slides = [
    { e: '📢', en: 'Report in seconds with photos & location', ar: 'بلّغ في ثواني بالصور واللوكيشن' },
    { e: '🛠️', en: 'Verified workers navigate & fix', ar: 'عمال موثقون يوصلوا ويصلحوا' },
    { e: '📄', en: 'Track live + PDF proof', ar: 'تابع لحظياً + توثيق PDF' },
  ];
  return (
    <div style={{ padding: 20, paddingTop: 60, textAlign: 'center' }}>
      <div style={{ fontSize: 80 }}>{slides[i].e}</div>
      <h2>{t(slides[i].en, slides[i].ar)}</h2>
      <div style={{ display: 'flex', gap: 6, justifyContent: 'center', margin: 12 }}>{slides.map((_, k) => <div key={k} style={{ width: 22, height: 6, borderRadius: 3, background: k === i ? '#003366' : '#cbd5e1' }} />)}</div>
      <div style={{ display: 'flex', gap: 8 }}>
        <button className="btn ghost" onClick={() => navigate('login')}>{t('Skip', 'تخطي')}</button>
        <button className="btn primary" onClick={() => (i < 2 ? setI(i + 1) : navigate('login'))}>{t('Next', 'التالي')}</button>
      </div>
    </div>
  );
}

export function Login() {
  const { navigate, t, setRole } = useDemo();
  return (
    <div style={{ padding: 18, paddingTop: 40 }}>
      <h2 style={{ marginBottom: 2 }}>{t('Log in', 'تسجيل الدخول')}</h2>
      <p style={{ color: 'var(--muted)', fontSize: 13 }}>{t('OTP-secured sessions, citizen & worker roles', 'جلسات مؤمنة بـ OTP ودورين')}</p>
      <Field ph={t('Enter your email address', 'أدخل بريدك الإلكتروني')} />
      <Field ph="********" />
      <div style={{ display: 'flex', gap: 8, margin: '8px 0' }}>
        <button className="btn primary" onClick={() => setRole('citizen')}>{t('Login as Citizen', 'دخول كمواطن')}</button>
      </div>
      <button className="btn worker" onClick={() => setRole('worker')}>{t('Login as Worker', 'دخول كعامل')}</button>
      <div style={{ display: 'flex', justifyContent: 'space-between', marginTop: 10, fontSize: 13 }}>
        <button className="btn small ghost" onClick={() => navigate('signup')}>{t('Sign up', 'إنشاء حساب')}</button>
        <button className="btn small ghost" onClick={() => navigate('forget')}>{t('Forgot Password', 'نسيت كلمة المرور')}</button>
      </div>
    </div>
  );
}

export function Signup() {
  const { navigate, t, runAction } = useDemo();
  return (
    <div style={{ padding: 18 }}>
      <h3>{t('Sign Up • Select a role', 'إنشاء حساب • اختر الدور')}</h3>
      <Field ph={t('Enter your First Name', 'أدخل اسمك الأول')} />
      <Field ph={t('Enter your Last Name', 'أدخل اسمك الأخير')} />
      <Field ph={t('Enter National number', 'أدخل الرقم القومي')} />
      <button className="btn ghost" onClick={() => runAction('camera')}>📷 {t('Add personal photo', 'أضف الصورة الشخصية')}</button>
      <div style={{ height: 8 }} />
      <button className="btn primary" onClick={() => runAction('otp')}>{t('Send Code', 'إرسال الكود')}</button>
      <div style={{ height: 8 }} />
      <button className="btn ghost" onClick={() => navigate('login')}>{t('Have an account already? Log in', 'لديك حساب؟ سجل الدخول')}</button>
    </div>
  );
}

export function Forget() {
  const { navigate, t, runAction } = useDemo();
  return (
    <div style={{ padding: 18, paddingTop: 50 }}>
      <h3>{t('Forgot Password', 'نسيت كلمة المرور')}</h3>
      <p style={{ color: 'var(--muted)', fontSize: 13 }}>{t("We'll send you an OTP to reset your password.", 'سنرسل لك رمز تحقق لإعادة التعيين.')}</p>
      <Field ph="email@example.com" />
      <button className="btn primary" onClick={() => runAction('otp')}>{t('Send Code', 'إرسال الكود')}</button>
      <div style={{ height: 8 }} />
      <button className="btn ghost" onClick={() => navigate('login')}>{t('Back', 'رجوع')}</button>
    </div>
  );
}

export function CitizenHome() {
  const { navigate, t, role } = useDemo();
  return (
    <div>
      <Header title="CitiFix" sub={t('Welcome, Mona — report & track', 'مرحباً منى — بلّغ وتابع')} />
      <div className="card">
        <b>{t('My Recent Reports', 'آخر البلاغات')}</b>
        <div style={{ fontSize: 12, color: 'var(--muted)' }}>{t('Search for "Water leak"', 'ابحث عن "تسرب مياه"')}</div>
      </div>
      {REPORTS.slice(0, 2).map((r) => (
        <div className="card" key={r.id}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
            <b>{t(r.title, r.titleAr)} {r.id}</b><Chip status={r.status} />
          </div>
          <div style={{ fontSize: 12, color: 'var(--muted)' }}>{t(r.location, r.locationAr)} • {r.time}</div>
          <button className="btn small primary" style={{ marginTop: 8 }} onClick={() => navigate('report-details')}>{t('Details', 'التفاصيل')}</button>
        </div>
      ))}
      <div style={{ padding: '0 14px' }}><button className="btn primary" onClick={() => navigate('add-report')}>＋ {t('Add Report', 'إضافة بلاغ')}</button></div>
      <BottomNav items={[
        { id: 'citizen-home', icon: '🏠', label: 'Home', labelAr: 'الرئيسية' },
        { id: 'reports', icon: '📝', label: 'Reports', labelAr: 'البلاغات' },
        { id: 'achievements', icon: '🏆', label: 'Achievement', labelAr: 'الإنجازات' },
        { id: 'profile', icon: '👤', label: 'Profile', labelAr: 'الملف الشخصي' },
      ]} />
    </div>
  );
}

export function ReportsList() {
  const { navigate, t } = useDemo();
  const [f, setF] = useState('all');
  const list = REPORTS.filter((r) => f === 'all' || r.status === f);
  return (
    <div>
      <Header title={t('Reports', 'البلاغات')} />
      <div className="tabs">
        {[['all', 'All', 'الكل'], ['pending', 'Pending', 'انتظار'], ['progress', 'In Progress', 'تنفيذ'], ['resolved', 'Resolved', 'تم الحل']].map(([id, en, ar]) => (
          <button key={id} className={`tab ${f === id ? 'active' : ''}`} onClick={() => setF(id)}>{t(en, ar)}</button>
        ))}
      </div>
      {list.map((r) => (
        <div className="card" key={r.id}>
          <div style={{ display: 'flex', justifyContent: 'space-between' }}><b>{t(r.title, r.titleAr)}</b><Chip status={r.status} /></div>
          <div style={{ fontSize: 12, color: 'var(--muted)' }}>{t(r.category, r.categoryAr)} • {r.id}</div>
          <button className="btn small ghost" style={{ marginTop: 8 }} onClick={() => navigate('report-details')}>{t('Report Details', 'تفاصيل البلاغ')}</button>
        </div>
      ))}
      {list.length === 0 && <div className="card">{t('No reports available currently', 'لا توجد تقارير متاحة حالياً')}</div>}
      <BottomNav items={[
        { id: 'citizen-home', icon: '🏠', label: 'Home', labelAr: 'الرئيسية' },
        { id: 'reports', icon: '📝', label: 'Reports', labelAr: 'البلاغات' },
        { id: 'achievements', icon: '🏆', label: 'Achievement', labelAr: 'الإنجازات' },
        { id: 'profile', icon: '👤', label: 'Profile', labelAr: 'الملف الشخصي' },
      ]} />
    </div>
  );
}

export function AddReport() {
  const { t, runAction, navigate } = useDemo();
  return (
    <div style={{ paddingBottom: 8 }}>
      <Header title={t('Add Report', 'إضافة بلاغ')} />
      <div className="card">
        <Field ph={t('Report title', 'عنوان البلاغ')} />
        <Field ph={t('Write a detailed description...', 'اكتب وصفاً تفصيلياً...')} />
        <div style={{ display: 'flex', gap: 8 }}>
          <button className="btn small ghost">⚡ {t('Electricity', 'كهرباء')}</button>
          <button className="btn small ghost">🚰 {t('Plumbing', 'سباكة')}</button>
          <button className="btn small ghost">🛣️ {t('Roads', 'طرق')}</button>
        </div>
        <div style={{ height: 8 }} />
        <button className="btn ghost" onClick={() => runAction('camera')}>📷 {t('Add Photo or Video', 'إضافة صورة او فيديو')}</button>
      </div>
      <div className="card">
        <b>📍 {t('Location', 'الموقع')}</b>
        <div style={{ fontSize: 12, color: 'var(--muted)', marginBottom: 6 }}>{t('Tap the map or search to choose the report location.', 'اضغط على الخريطة أو ابحث لاختيار موقع البلاغ.')}</div>
        <MapFake />
        <div style={{ height: 8 }} />
        <button className="btn primary" onClick={() => { runAction('sent'); }}>{t('Submit Report', 'إرسال البلاغ')}</button>
      </div>
    </div>
  );
}

export function ReportDetails() {
  const { t } = useDemo();
  return (
    <div>
      <Header title={t('Report Details', 'تفاصيل البلاغ')} sub="#1042 • Street pothole" />
      <div className="card">
        <div style={{ display: 'flex', justifyContent: 'space-between' }}><b>🕳️ {t('Street pothole', 'حفرة في الشارع')}</b><Chip status="progress" /></div>
        <p style={{ fontSize: 13, color: 'var(--muted)' }}>{t('Large pothole near the bus stop, dangerous at night.', 'حفرة كبيرة قرب موقف الأتوبيس وخطيرة ليلاً.')}</p>
        <div style={{ display: 'flex', gap: 8 }}>
          <div style={{ flex: 1, background: '#e2e8f0', borderRadius: 10, height: 80, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>🖼️ Before</div>
          <div style={{ flex: 1, background: '#dcfce7', borderRadius: 10, height: 80, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>✅ After</div>
        </div>
      </div>
      <div className="card">
        <b>{t('Progress Tracking', 'تتبع حالة البلاغ')}</b>
        <div className="timeline" style={{ marginTop: 10 }}>
          {[{ c: '#08a43a', en: 'Submitted', ar: 'تم التقديم' }, { c: '#f59e0b', en: 'Assigned to Ahmed', ar: 'أُسند إلى أحمد' }, { c: '#ff7b00', en: 'In Progress now', ar: 'قيد التنفيذ الآن' }, { c: '#cbd5e1', en: 'Resolved (pending)', ar: 'تم الحل (معلق)' }].map((s, i) => (
            <div key={i}><span className="tdot" style={{ background: s.c }} />{t(s.en, s.ar)}</div>
          ))}
        </div>
      </div>
      <div className="card">
        <b>💬 {t('Comments', 'التعليقات')} • 3 {t('Messages', 'رسائل')}</b>
        {COMMENTS.map((c, i) => <div key={i} style={{ fontSize: 13, padding: '6px 0', borderBottom: '1px solid var(--border)' }}><b>{c.who}</b> <span style={{ color: 'var(--muted)' }}>{c.time}</span><br />{c.text}</div>)}
        <Field ph={t('Add a reply or a new inquiry...', 'أضف رداً أو استفساراً جديداً...')} />
      </div>
    </div>
  );
}

export function Notifications() {
  const { inbox, markAllRead, clearInbox, t, navigate } = useDemo();
  return (
    <div>
      <Header title={t('Notifications', 'الإشعارات')} />
      <div style={{ display: 'flex', gap: 8, padding: '0 14px' }}>
        <button className="btn small ghost" onClick={markAllRead}>{t('Mark all read', 'تحديد الكل كمقروء')}</button>
        <button className="btn small ghost" onClick={clearInbox}>{t('Delete all', 'حذف الكل')}</button>
      </div>
      {inbox.length === 0 && <div className="card">🔕 {t('No new notifications — You are all caught up!', 'لا توجد إشعارات — أنت مطلع على كل شيء!')}</div>}
      {inbox.map((n, i) => (
        <div className="card" key={i} style={{ opacity: n.read ? 0.65 : 1 }}>
          <b>{t(n.title, n.titleAr)}</b>
          <div style={{ fontSize: 13, color: 'var(--muted)' }}>{t(n.body, n.bodyAr)}</div>
          <div style={{ fontSize: 11, color: 'var(--muted)' }}>{n.time} • {n.source === 'real' ? 'from app flow' : 'demo example'} {n.image ? '• 🖼️ rich image' : ''}</div>
          <button className="btn small primary" style={{ marginTop: 6 }} onClick={() => navigate(n.route)}>{t('Open', 'فتح')}</button>
        </div>
      ))}
    </div>
  );
}

export function Achievements() {
  const { t } = useDemo();
  return (
    <div>
      <Header title={t('Top Achievement Reports', 'أبرز تقارير الإنجازات')} />
      <div className="card" style={{ background: 'linear-gradient(135deg,#003366,#1162d4)', color: '#fff', border: 0 }}>
        <div style={{ fontSize: 13 }}>🏆 {t('Resolved Reports', 'البلاغات المنجزة')}</div>
        <div style={{ fontSize: 34, fontWeight: 800 }}>12</div>
      </div>
      {REPORTS.filter((r) => r.status === 'resolved').map((r) => (
        <div className="card" key={r.id}><b>{t(r.title, r.titleAr)}</b><div style={{ fontSize: 12, color: 'var(--muted)' }}>{t('Completed By', 'تم الإنجاز بواسطة')} Ahmed • {t('Department', 'القسم المختص')}: {t(r.category, r.categoryAr)}</div><Chip status="resolved" /></div>
      ))}
      <BottomNav items={[
        { id: 'citizen-home', icon: '🏠', label: 'Home', labelAr: 'الرئيسية' },
        { id: 'reports', icon: '📝', label: 'Reports', labelAr: 'البلاغات' },
        { id: 'achievements', icon: '🏆', label: 'Achievement', labelAr: 'الإنجازات' },
        { id: 'profile', icon: '👤', label: 'Profile', labelAr: 'الملف الشخصي' },
      ]} />
    </div>
  );
}

export function Profile() {
  const { t, setLang, lang, theme, setTheme } = useDemo();
  return (
    <div>
      <Header title={t('Profile', 'الملف الشخصي')} />
      <div className="card" style={{ textAlign: 'center' }}>
        <div style={{ width: 64, height: 64, borderRadius: 32, background: '#d7e2ff', margin: '0 auto', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 30 }}>👩</div>
        <b>Mona Ahmed</b><div style={{ fontSize: 12, color: 'var(--muted)' }}>mona@citi.fix • Cairo</div>
        <div style={{ fontSize: 11, color: 'var(--success)' }}>🔒 {t('Your data is securely stored and encrypted.', 'بياناتك مخزنة ومُشفرة بشكل آمن.')}</div>
      </div>
      <div className="card">
        <div className="kv"><span>🌐 {t('Language', 'اللغة')}</span><button className="btn small ghost" onClick={() => setLang(lang === 'en' ? 'ar' : 'en')}>{lang === 'en' ? 'العربية' : 'English'}</button></div>
        <div className="kv"><span>🌙 {t('Dark Mode', 'المظهر الداكن')}</span><button className="btn small ghost" onClick={() => setTheme(theme === 'light' ? 'dark' : 'light')}>{theme}</button></div>
        <div className="kv"><span>❓ {t('Help & Terms', 'المساعدة والشروط')}</span><span>›</span></div>
        <div className="kv"><span>🚪 {t('Log out', 'تسجيل الخروج')}</span><span>›</span></div>
      </div>
    </div>
  );
}

export function WorkerHome() {
  const { t, navigate } = useDemo();
  return (
    <div>
      <Header title={t('Worker Dashboard', 'لوحة العامل')} sub={t("Stay focused and let's get to work!", 'ابقَ مركزاً ولنبدأ العمل!')} />
      <div style={{ display: 'flex', gap: 8, padding: '0 14px' }}>
        <div className="card" style={{ flex: 1, margin: 0, textAlign: 'center' }}><div style={{ fontSize: 11, color: 'var(--muted)' }}>{t('TOTAL REPORTS', 'إجمالي البلاغات')}</div><b style={{ fontSize: 22 }}>24</b></div>
        <div className="card" style={{ flex: 1, margin: 0, textAlign: 'center' }}><div style={{ fontSize: 11, color: 'var(--muted)' }}>{t('PROGRESS', 'معدل الإنجاز')}</div><b style={{ fontSize: 22 }}>68%</b></div>
      </div>
      <div className="card" style={{ borderColor: '#fecaca', background: '#fef2f2' }}><span className="chip urgent">URGENT • {t('عاجل', 'عاجل')}</span><b> Fix Water Leak — 1.2 KM</b><div style={{ fontSize: 12 }}>842 Riverside Dr • {t('Inside Work Zone', 'داخل منطقة العمل')}</div>
        <button className="btn worker" style={{ marginTop: 8 }} onClick={() => navigate('task-details')}>{t('View Details', 'عرض التفاصيل')}</button>
      </div>
      <div className="card"><b>{t('Available Tasks', 'المهام المتاحة')}</b>{TASKS.map((x) => <div key={x.id} className="kv"><span>{t(x.title, x.titleAr)} • {x.distance}</span><span>{x.status}</span></div>)}</div>
      <BottomNav items={[
        { id: 'worker-home', icon: '🏠', label: 'Home', labelAr: 'الرئيسية' },
        { id: 'tasks', icon: '🧰', label: 'Tasks', labelAr: 'المهام' },
        { id: 'verification', icon: '🪪', label: 'Verify', labelAr: 'التوثيق' },
        { id: 'profile', icon: '👤', label: 'Profile', labelAr: 'الملف' },
      ]} />
    </div>
  );
}

export function Tasks() {
  const { t, navigate } = useDemo();
  return (
    <div>
      <Header title={t('Tasks', 'المهام')} sub={t('Keep track of your daily progress', 'تابع تقدمك اليومي بانتظام')} />
      {TASKS.map((x) => (
        <div className="card" key={x.id}>
          <div style={{ display: 'flex', justifyContent: 'space-between' }}><b>{t(x.title, x.titleAr)}</b>{x.urgent && <span className="chip urgent">URGENT</span>}</div>
          <div style={{ fontSize: 12, color: 'var(--muted)' }}>{x.id} • {t(x.address, x.addressAr)} • {x.distance}</div>
          <button className="btn small worker" style={{ marginTop: 6 }} onClick={() => navigate('task-details')}>{t('Start Task', 'بدء المهمة')}</button>
        </div>
      ))}
    </div>
  );
}

export function TaskDetails() {
  const { t, runAction } = useDemo();
  return (
    <div>
      <Header title={t('Task Details', 'تفاصيل المهمة')} sub="T-77 • Fix Water Leak" />
      <div className="card">
        <div className="kv"><span>📏 {t('DISTANCE TO TASK', 'المسافة إلى المهمة')}</span><b>1.2 KM</b></div>
        <div className="kv"><span>🟢 {t('Inside Work Zone', 'داخل منطقة العمل')}</span><b>{t('Monitoring Area', 'مراقبة المنطقة')}</b></div>
        <MapFake routeLine />
        <div style={{ fontSize: 12, color: 'var(--muted)', marginTop: 6 }}>Emergency pipe burst reported in the main bathroom. Residents shut off the main valve.</div>
      </div>
      <div className="card">
        <b>📸 {t('PROOF OF WORK *', 'إثبات العمل *')}</b>
        <div style={{ display: 'flex', gap: 8, margin: '8px 0' }}>
          <div style={{ flex: 1, background: '#f1f5f9', borderRadius: 10, height: 70, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>Before</div>
          <div style={{ flex: 1, border: '2px dashed var(--border)', borderRadius: 10, height: 70, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>＋ Add</div>
        </div>
        <Field ph={t('Add Notes', 'أضف ملاحظاتك')} />
        <div style={{ display: 'flex', gap: 8, marginTop: 8 }}>
          <button className="btn ghost" onClick={() => runAction('pdf')}>🖨️ PDF</button>
          <button className="btn worker" onClick={() => runAction('done')}>{t('Mark as Completed', 'تحديد كمكتمل')}</button>
        </div>
      </div>
    </div>
  );
}

export function Verification() {
  const { t, runAction } = useDemo();
  return (
    <div style={{ padding: 14 }}>
      <h3 style={{ margin: 4 }}>🪪 {t('Account Verification', 'توثيق الحساب')}</h3>
      <p style={{ fontSize: 12, color: 'var(--muted)' }}>{t('Please complete the following data to verify your account as a professional worker', 'يرجى إكمال البيانات التالية لتوثيق حسابك كعامل محترف')}</p>
      <div style={{ display: 'flex', gap: 8 }}>
        <button className="btn ghost" onClick={() => runAction('camera')}>ID Front<br />{t('Tap to scan', 'اضغط للتصوير')}</button>
        <button className="btn ghost" onClick={() => runAction('camera')}>ID Back<br />{t('Tap to scan', 'اضغط للتصوير')}</button>
      </div>
      <div style={{ height: 8 }} />
      <Field ph={t('Enter National number', 'أدخل الرقم القومي')} />
      <Field ph={t('Additional Notes', 'ملاحظات إضافية')} />
      <button className="btn worker" onClick={() => runAction('verify')}>{t('Submit', 'إرسال')}</button>
      <div className="card" style={{ background: '#fffbeb' }}>⏳ <b>{t('Under Review', 'قيد المراجعة')}</b><div style={{ fontSize: 12 }}>{t('Your request is currently being reviewed by our team.', 'طلبك حالياً قيد المراجعة من قبل فريقنا.')}</div></div>
    </div>
  );
}
