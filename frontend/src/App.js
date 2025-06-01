import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Dashboard from './pages/Dashboard';
import RiskRegister from './pages/RiskRegister';
import ControlCatalog from './pages/ControlCatalog';
import AuditLog from './pages/AuditLog';

function App() {
  return (
    <Router>
      <div className="min-h-screen bg-gray-100">
        <Routes>
          <Route path="/" element={<Dashboard />} />
          <Route path="/risks" element={<RiskRegister />} />
          <Route path="/controls" element={<ControlCatalog />} />
          <Route path="/audits" element={<AuditLog />} />
        </Routes>
      </div>
    </Router>
  );
}

export default App;
