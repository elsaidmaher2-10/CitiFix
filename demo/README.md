# CitiFix — Interactive Demo (React rebuild, iPhone frame)

Standalone React + Vite + TypeScript rebuild of the Flutter app `citifix` v1.0.1+2.
Original project is only READ — zero changes to Flutter files, no Flutter Web.

## Run
```sh
cd demo
npm install
npm run dev      # http://localhost:5173
```

## Build / host (static)
```sh
npm run build    # -> dist/
npm run preview  # serves dist on :8080
```
Host `dist/` on Firebase Hosting / GitHub Pages / Netlify (static, offline after load).

## What is inside
- Phone frame 390x844, Dynamic Island, status bar, home indicator, zoom + frame colours.
- Screens rebuilt: splash, onboarding, login, signup, forget, citizen-home, reports, add-report, report-details (timeline+comments), notifications inbox, achievements, worker-home dashboard, tasks, task-details (map+proof-of-work), verification, profile.
- Control panel: 5 push notifications (4 real flows from FCM code + 1 labelled example), deep links citifix://*, 6 simulated features (camera/map/PDF/geofence/OTP/verify), role/lang/theme switch, lock screen.
- Faithful values: citizen #003366, worker #FF7B00, bg #F6F7F8, Arabic+English strings from intl_en/intl_ar.arb.

## Simulated
Camera/gallery, OSRM routing, geofence, PDF export, OTP, backend auth — all in-memory sheets, labelled in UI/report.

## Left out
Admin web dashboard, real Firebase, real GPS/QR/biometrics/payments, full chat pagination, video compression binary.
