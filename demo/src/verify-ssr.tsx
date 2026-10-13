import React from 'react';
import { renderToString } from 'react-dom/server';
import { DemoProvider } from './bridge/DemoContext';
import * as S from './app/screens';
import { ControlPanel } from './shell/ControlPanel';
import { DEMO_CONFIG } from './demo.config';

const cases: Array<[string, React.ComponentType, string[]]> = [
  ['splash', S.Splash, ['CitiFix', 'Get Started', '1.0.1+2']],
  ['onboarding', S.Onboarding, ['Skip', 'Next']],
  ['login', S.Login, ['Log in', 'Login as Citizen', 'Login as Worker']],
  ['signup', S.Signup, ['Sign Up', 'National number']],
  ['forget', S.Forget, ['Forgot Password', 'Send Code']],
  ['citizen-home', S.CitizenHome, ['My Recent Reports', 'Add Report', '#1042']],
  ['reports', S.ReportsList, ['Reports', 'In Progress']],
  ['add-report', S.AddReport, ['Add Report', 'OpenStreetMap', 'Submit Report']],
  ['report-details', S.ReportDetails, ['Report Details', 'Progress Tracking', 'Comments']],
  ['notifications', S.Notifications, ['Notifications', 'caught up']],
  ['achievements', S.Achievements, ['Achievement', 'Resolved Reports']],
  ['profile', S.Profile, ['Mona Ahmed', 'Language', 'Dark Mode']],
  ['worker-home', S.WorkerHome, ['Worker Dashboard', 'TOTAL REPORTS', 'URGENT']],
  ['tasks', S.Tasks, ['Tasks', 'T-77', 'Fix Water Leak']],
  ['task-details', S.TaskDetails, ['Task Details', 'DISTANCE TO TASK', 'PROOF OF WORK']],
  ['verification', S.Verification, ['Account Verification', 'National number', 'Under Review']],
];

let fail = 0;
for (const [name, Comp, needles] of cases) {
  const html = renderToString(
    React.createElement(DemoProvider, null, React.createElement(Comp)),
  );
  const missing = needles.filter((n) => !html.includes(n));
  if (missing.length) {
    fail++;
    console.log(`FAIL ${name}: missing [${missing.join(' | ')}]`);
  } else {
    console.log(`OK ${name} (${html.length} chars)`);
  }
}

const panel = renderToString(React.createElement(DemoProvider, null, React.createElement(ControlPanel)));
const panelChecks = ['Demo Console', 'citifix://report/1042', 'Camera / Gallery', ...DEMO_CONFIG.notifications.map((n) => n.title)];
const pm = panelChecks.filter((n) => !panel.includes(n));
console.log(pm.length ? `FAIL panel: missing [${pm.join(' | ')}]` : `OK panel (${panel.length} chars)`);
if (pm.length) fail++;

console.log(fail === 0 ? 'ALL_SCREENS_RENDER_OK' : `${fail} FAILURES`);
process.exit(fail === 0 ? 0 : 1);
