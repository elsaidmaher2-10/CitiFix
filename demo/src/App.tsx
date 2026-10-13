import React from 'react';
import { DemoProvider } from './bridge/DemoContext';
import { PhoneFrame } from './shell/PhoneFrame';
import { ControlPanel } from './shell/ControlPanel';
import './app/theme.css';

export default function App() {
  return (
    <DemoProvider>
      <div className="demo-page">
        <PhoneFrame />
        <ControlPanel />
      </div>
    </DemoProvider>
  );
}
