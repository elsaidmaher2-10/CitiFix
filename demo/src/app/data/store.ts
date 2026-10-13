export interface Report {
  id: string;
  title: string;
  titleAr: string;
  category: string;
  categoryAr: string;
  status: 'pending' | 'progress' | 'resolved';
  location: string;
  locationAr: string;
  time: string;
  desc: string;
  descAr: string;
}

export const REPORTS: Report[] = [
  { id: '#1042', title: 'Street pothole', titleAr: 'حفرة في الشارع', category: 'Roads', categoryAr: 'طرق', status: 'progress', location: 'Riverside Dr, Zone Alpha', locationAr: 'شارع ريفرسايد، المنطقة ألفا', time: '2h ago', desc: 'Large pothole near the bus stop, dangerous at night.', descAr: 'حفرة كبيرة قرب موقف الأتوبيس وخطيرة ليلاً.' },
  { id: '#1041', title: 'Broken streetlight', titleAr: 'كشاف إنارة مكسور', category: 'Electricity', categoryAr: 'كهرباء', status: 'pending', location: 'Zone B, St 12', locationAr: 'المنطقة ب، شارع 12', time: '5h ago', desc: 'Light pole off for 3 nights.', descAr: 'عمود الإنارة مطفي منذ 3 ليالٍ.' },
  { id: '#1039', title: 'Water leak', titleAr: 'تسرب مياه', category: 'Plumbing', categoryAr: 'سباكة', status: 'resolved', location: 'Apt 4B, Riverside', locationAr: 'شقة 4B ريفرسايد', time: '1d ago', desc: 'Pipe burst in main bathroom, fixed with before/after photos.', descAr: 'انفجار ماسورة وتم الإصلاح مع صور قبل/بعد.' },
  { id: '#1035', title: 'Waste accumulation', titleAr: 'تراكم نفايات', category: 'Waste', categoryAr: 'قمامة', status: 'resolved', location: 'Market St', locationAr: 'شارع السوق', time: '2d ago', desc: 'Garbage pile removed by Zone team.', descAr: 'تمت إزالة تراكم القمامة بواسطة فريق المنطقة.' },
];

export interface Task {
  id: string;
  title: string;
  titleAr: string;
  urgent: boolean;
  status: string;
  distance: string;
  address: string;
  addressAr: string;
}

export const TASKS: Task[] = [
  { id: 'T-77', title: 'Fix Water Leak', titleAr: 'إصلاح تسرب مياه', urgent: true, status: 'Assigned', distance: '1.2 KM', address: '842 Riverside Dr, Apt 4B', addressAr: '842 شارع ريفرسايد، شقة 4B' },
  { id: 'T-76', title: 'Pothole repair', titleAr: 'إصلاح حفرة', urgent: false, status: 'In Progress', distance: '2.4 KM', address: 'Bus stop, Zone Alpha', addressAr: 'موقف الأتوبيس، المنطقة ألفا' },
  { id: 'T-75', title: 'Streetlight fix', titleAr: 'إصلاح إنارة', urgent: false, status: 'Pending', distance: '3.1 KM', address: 'St 12, Zone B', addressAr: 'شارع 12، المنطقة ب' },
];

export const COMMENTS = [
  { who: 'Worker Ahmed', text: 'Main valve closed, repair starts in 30 min.', time: '10:42' },
  { who: 'Citizen Mona', text: 'Thanks! The leak is getting worse.', time: '10:50' },
  { who: 'Worker Ahmed', text: 'Before photos uploaded, stay tuned.', time: '11:05' },
];
