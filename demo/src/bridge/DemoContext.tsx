import React, { createContext, useCallback, useContext, useMemo, useState } from 'react';
import { DEMO_CONFIG, DemoNotification, Lang, Role } from '../demo.config';

export interface InAppNotif extends DemoNotification { time: string; read: boolean }

interface DemoState {
  route: string;
  stack: string[];
  navigate: (r: string) => void;
  back: () => void;
  role: Role;
  setRole: (r: Role) => void;
  lang: Lang;
  setLang: (l: Lang) => void;
  dir: 'ltr' | 'rtl';
  theme: 'light' | 'dark';
  setTheme: (t: 'light' | 'dark') => void;
  locked: boolean;
  setLocked: (v: boolean) => void;
  banner: InAppNotif | null;
  notify: (n: DemoNotification) => void;
  dismissBanner: (openRoute?: boolean) => void;
  inbox: InAppNotif[];
  markAllRead: () => void;
  clearInbox: () => void;
  unread: number;
  frame: string;
  setFrame: (f: string) => void;
  zoom: number;
  setZoom: (z: number) => void;
  sheet: string | null;
  runAction: (name: string) => void;
  closeSheet: () => void;
  t: (en: string, ar: string) => string;
}

const Ctx = createContext<DemoState | null>(null);

export function DemoProvider({ children }: { children: React.ReactNode }) {
  const [stack, setStack] = useState<string[]>(['splash']);
  const [role, setRoleState] = useState<Role>('citizen');
  const [lang, setLang] = useState<Lang>('en');
  const [theme, setTheme] = useState<'light' | 'dark'>('light');
  const [locked, setLocked] = useState(false);
  const [banner, setBanner] = useState<InAppNotif | null>(null);
  const [inbox, setInbox] = useState<InAppNotif[]>([]);
  const [frame, setFrame] = useState('black');
  const [zoom, setZoom] = useState(1);
  const [sheet, setSheet] = useState<string | null>(null);

  const route = stack[stack.length - 1];
  const dir = lang === 'ar' ? 'rtl' : 'ltr';

  const navigate = useCallback((r: string) => {
    setStack((s) => (s[s.length - 1] === r ? s : [...s, r].slice(-20)));
  }, []);
  const back = useCallback(() => setStack((s) => (s.length > 1 ? s.slice(0, -1) : s)), []);

  const notify = useCallback((n: DemoNotification) => {
    const item: InAppNotif = {
      ...n,
      time: new Date().toLocaleTimeString(),
      read: false,
    };
    setInbox((prev) => [item, ...prev].slice(0, 20));
    setBanner(item);
  }, []);

  const dismissBanner = useCallback(
    (openRoute?: boolean) => {
      if (banner && openRoute) navigate(banner.route);
      setBanner(null);
    },
    [banner, navigate],
  );

  const markAllRead = useCallback(() => setInbox((p) => p.map((x) => ({ ...x, read: true }))), []);
  const clearInbox = useCallback(() => setInbox([]), []);

  const setRole = useCallback(
    (r: Role) => {
      setRoleState(r);
      navigate(r === 'citizen' ? 'citizen-home' : 'worker-home');
    },
    [navigate],
  );

  const runAction = useCallback((name: string) => setSheet(name), []);
  const closeSheet = useCallback(() => setSheet(null), []);
  const t = useCallback((en: string, ar: string) => (lang === 'ar' ? ar : en), [lang]);

  const unread = useMemo(() => inbox.filter((x) => !x.read).length, [inbox]);

  const value: DemoState = {
    route, stack, navigate, back, role, setRole, lang, setLang, dir,
    theme, setTheme, locked, setLocked, banner, notify, dismissBanner,
    inbox, markAllRead, clearInbox, unread, frame, setFrame, zoom, setZoom,
    sheet, runAction, closeSheet, t,
  };
  return <Ctx.Provider value={value}>{children}</Ctx.Provider>;
}

export function useDemo(): DemoState {
  const v = useContext(Ctx);
  if (!v) throw new Error('useDemo outside provider');
  return v;
}

export { DEMO_CONFIG };
