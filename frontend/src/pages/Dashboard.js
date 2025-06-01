import React, { useEffect, useState } from 'react';
import axios from 'axios';

const Dashboard = () => {
  const [data, setData] = useState({});

  useEffect(() => {
    axios.get('/api/dashboards/').then(response => {
      setData(response.data);
    }).catch(error => {
      console.error('Error fetching dashboard data:', error);
    });
  }, []);

  return (
    <div className="p-6">
      <h1 className="text-2xl font-bold mb-4">Risk Management Dashboard</h1>
      <div className="grid grid-cols-3 gap-4">
        <div className="bg-white p-4 rounded shadow">
          <h2 className="text-lg font-semibold">Total Risks</h2>
          <p className="text-2xl">{data.total_risks || 0}</p>
        </div>
        <div className="bg-white p-4 rounded shadow">
          <h2 className="text-lg font-semibold">Total Controls</h2>
          <p className="text-2xl">{data.total_controls || 0}</p>
        </div>
        <div className="bg-white p-4 rounded shadow">
          <h2 className="text-lg font-semibold">Open Audits</h2>
          <p className="text-2xl">{data.open_audits || 0}</p>
        </div>
      </div>
    </div>
  );
};

export default Dashboard;
