import React, { useEffect, useState } from 'react';
import axios from 'axios';

const RiskRegister = () => {
  const [risks, setRisks] = useState([]);

  useEffect(() => {
    axios.get('/api/risks/').then(response => {
      setRisks(response.data);
    }).catch(error => {
      console.error('Error fetching risks:', error);
    });
  }, []);

  return (
    <div className="p-6">
      <h1 className="text-2xl font-bold mb-4">Risk Register</h1>
      <table className="w-full bg-white shadow rounded">
        <thead>
          <tr className="bg-gray-200">
            <th className="p-2">Title</th>
            <th className="p-2">Category</th>
            <th className="p-2">Likelihood</th>
            <th className="p-2">Impact</th>
            <th className="p-2">Status</th>
          </tr>
        </thead>
        <tbody>
          {risks.map(risk => (
            <tr key={risk.id}>
              <td className="p-2">{risk.title}</td>
              <td className="p-2">{risk.category}</td>
              <td className="p-2">{risk.likelihood}</td>
              <td className="p-2">{risk.impact}</td>
              <td className="p-2">{risk.status}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default RiskRegister;
