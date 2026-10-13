export type Role = 'citizen' | 'worker';
export type Lang = 'en' | 'ar';

export interface DemoNotification {
  id: string;
  title: string;
  titleAr: string;
  body: string;
  bodyAr: string;
  route: string;
  image?: boolean;
  source: 'real' | 'example';
}

export const DEMO_CONFIG = {
  appName: 'CitiFix',
  appNameAr: 'سيتيفيكس',
  description: 'Citizens report city issues, workers fix them — with maps, proof-of-work and PDF.',
  version: '1.0.1+2',
  accent: '#003366',
  accent2: '#FF7B00',
  notifications: [
    {
      id: 'n1',
      title: 'Report update: In Progress',
      titleAr: 'تحديث البلاغ: قيد التنفيذ',
      body: 'Your pothole report #1042 is now In Progress. Worker Ahmed is on the way.',
      bodyAr: 'بلاغ الحفرة #1042 أصبح قيد التنفيذ. العامل أحمد في الطريق.',
      route: 'report-details',
      source: 'real',
    },
    {
      id: 'n2',
      title: 'Report Resolved ✓',
      titleAr: 'تم حل البلاغ ✓',
      body: 'Street-light issue fixed. Check before/after photos and rate the work.',
      bodyAr: 'تم إصلاح عمود الإنارة. شاهد صور قبل/بعد وقيّم العمل.',
      route: 'achievements',
      source: 'real',
    },
    {
      id: 'n3',
      title: 'URGENT: New task assigned',
      titleAr: 'عاجل: مهمة جديدة',
      body: 'Fix Water Leak — 842 Riverside Dr, 1.2 KM away. Inside Work Zone.',
      bodyAr: 'إصلاح تسرب مياه — على بعد 1.2 كم. داخل منطقة العمل.',
      route: 'task-details',
      source: 'real',
    },
    {
      id: 'n4',
      title: 'Verification Complete',
      titleAr: 'اكتمل التوثيق',
      body: 'Your worker digital ID has been issued. Continue to the dashboard.',
      bodyAr: 'تم إصدار هويتك الرقمية كعامل. تابع إلى لوحة التحكم.',
      route: 'worker-home',
      source: 'real',
    },
    {
      id: 'n5',
      title: 'New comment on #1042',
      titleAr: 'تعليق جديد على #1042',
      body: 'Worker: Main valve closed, repair starts in 30 min. Citizen: Thanks!',
      bodyAr: 'العامل: تم غلق المحبس والبدء خلال 30 دقيقة. المواطن: شكراً!',
      route: 'report-details',
      image: true,
      source: 'example',
    },
  ] as DemoNotification[],
  features: [
    { id: 'camera', label: 'Camera / Gallery', labelAr: 'كاميرا / معرض' },
    { id: 'map', label: 'Map & Routing (OSRM)', labelAr: 'خريطة ومسار' },
    { id: 'pdf', label: 'Print to PDF', labelAr: 'طباعة PDF' },
    { id: 'geofence', label: 'Geofence check', labelAr: 'فحص النطاق' },
    { id: 'otp', label: 'OTP sheet', labelAr: 'شاشة OTP' },
    { id: 'verify', label: 'ID Verification', labelAr: 'توثيق الهوية' },
  ],
  deepLinks: [
    { label: 'citifix://report/1042', route: 'report-details' },
    { label: 'citifix://tasks/77', route: 'task-details' },
    { label: 'citifix://achievements', route: 'achievements' },
    { label: 'citifix://verify', route: 'verification' },
  ],
};
