import React, { useEffect, useState } from 'react';
import axios from 'axios';

const ControlCatalog = () => {
  const [controls, setControls] = useState([]);

  useEffect(() => {
    axios.get('/api/controls/').then(response => {
      setControls(response.data);
    }).catch(error => {
      console.error('Error fetching controls:', error);
    });
  }, []);

  return (
    <div className="p-6">
      <h1 className="text-2xl font-bold mb-4">Control Catalog (NIST 800-53)</h1>
      <table className="w-full bg-white shadow rounded">
        <thead>
          <tr className="bg-gray-200">
            <th className="p-2">Control ID</th>
            <th className="p-2">Family</th>
            <th className="p-2">Title</th>
            <th className="p-2">Status</th>
          </tr>
        </thead>
        <tbody>
          {controls.map(control => (
            <tr key={control.id}>
              <td className="p-2">{control.control_id}</td>
              <td className="p-2">{control.family}</td>
              <td className="p-2">{control.title}</td>
              <td className="p-2">{control.implementation_status}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default ControlCatalog;
