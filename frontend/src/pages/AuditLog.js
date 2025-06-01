import React, { useEffect, useState } from 'react';
import axios from 'axios';

const AuditLog = () => {
  const [audits, setAudits] = useState([]);

  useEffect(() => {
    axios.get('/api/audits/').then(response => {
      setAudits(response.data);
    }).catch(error => {
      console.error('Error fetching audits:', error);
    });
  }, []);

  return (
    <div className="p-6">
      <h1 className="text-2xl font-bold mb-4">Audit Log</h1>
      <table className="w-full bg-white shadow rounded">
        <thead>
          <tr className="bg-gray-200">
            <th className="p-2">Title</th>
            <th className="p-2">Risk</th>
            <th className="p-2">Control</th>
            <th className="p-2">Status</th>
            <th className="p-2">Audit Date</th>
          </tr>
        </thead>
        <tbody>
          {audits.map(audit => (
            <tr key={audit.id}>
              <td className="p-2">{audit.title}</td>
              <td className="p-2">{audit.risk}</td>
              <td className="p-2">{audit.control}</td>
              <td className="p-2">{audit.status}</td>
              <td className="p-2">{new Date(audit.audit_date).toLocaleDateString()}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default AuditLog;
