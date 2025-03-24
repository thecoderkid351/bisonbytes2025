import React, { useState } from "react";
import "./index.css";
import {
  LineChart,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
} from "recharts";

const samplePatients = [
  {
    user_id: "jordan_h",
    heart_rate: 122,
    resting_hr: 86,
    steps: 5800,
    sleep_hours: 3.5,
    distance_km: 2.7,
  },
  {
    user_id: "maya_r",
    heart_rate: 98,
    resting_hr: 68,
    steps: 8300,
    sleep_hours: 7.2,
    distance_km: 5.1,
  },
];

function App() {
  const [results, setResults] = useState({});
  const [notes, setNotes] = useState({});

  const handleNoteChange = (id, value) => {
    setNotes((prev) => ({ ...prev, [id]: value }));
  };

  const analyzePatient = async (patient) => {
    const patientWithNote = {
      ...patient,
      note: notes[patient.user_id] || "",
    };

    try {
      const response = await fetch("http://localhost:5000/analyze", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(patientWithNote),
      });

      if (!response.ok) throw new Error("Error from server");

      const data = await response.json();
      setResults((prev) => ({ ...prev, [patient.user_id]: data }));
    } catch (error) {
      console.error("Fetch error:", error);
    }
  };

  return (
    <div style={{ padding: "2rem", maxWidth: "800px", margin: "0 auto" }}>
      <h1>🧾 VitalSync AI – Health Dashboard</h1>
      <p style={{ textAlign: "center", color: "#444", marginBottom: "2rem" }}>
        Personalized insights. Real-time vitals. AI-powered clarity.
      </p>

      {samplePatients.map((patient) => (
        <div key={patient.user_id} className="card">
          <h2>👤 {patient.user_id}</h2>
          <p>❤️ Heart Rate: {patient.heart_rate} bpm</p>
          <p>💤 Sleep: {patient.sleep_hours} hrs</p>
          <p>🚶 Steps: {patient.steps}</p>
          <p>📏 Distance: {patient.distance_km} km</p>
          <p>💤 Resting Heart Rate: {patient.resting_hr} bpm</p>

          {(patient.heart_rate > 130 || patient.sleep_hours < 2 || patient.resting_hr > 110) && (
            <div className="emergency-alert">
              🚨 Emergency Alert: Patient may be in critical condition. Immediate attention advised!
            </div>
          )}

          <input
            placeholder="📝 Enter any symptoms..."
            value={notes[patient.user_id] || ""}
            onChange={(e) => handleNoteChange(patient.user_id, e.target.value)}
            style={{
              width: "100%",
              padding: "10px",
              borderRadius: "6px",
              border: "1px solid #ccc",
              marginBottom: "10px",
            }}
          />

          <button onClick={() => analyzePatient(patient)}>
            🧠 Generate Summary 
          </button>

          {results[patient.user_id] && (
            <div style={{ marginTop: "1rem" }}>
              <h4>🧠Patient Summary:</h4>
              <p>{results[patient.user_id].summary}</p>

              <button
                onClick={() => {
                  const utterance = new SpeechSynthesisUtterance(results[patient.user_id]?.summary);
                  window.speechSynthesis.speak(utterance);
                }}
                style={{ marginTop: "0.5rem", backgroundColor: "#FFE066", color: "#000", padding: "8px", borderRadius: "6px" }}
              >
                🔊 Read Summary Aloud
              </button>

              {results[patient.user_id].risk === "high" && (
                <p className="risk-high">🚨 High Risk</p>
              )}
              {results[patient.user_id].risk === "medium" && (
                <p className="risk-medium">⚠️ Medium Risk</p>
              )}
              {results[patient.user_id].risk === "low" && (
                <p className="risk-low">✅ Low Risk</p>
              )}

              {/* ✅ Chart now safely rendered */}
              <h4 style={{ marginTop: "1rem" }}>📈 Heart Rate Trend</h4>
              <ResponsiveContainer width="100%" height={200}>
                <LineChart
                  data={[
                    { time: "8AM", bpm: patient.heart_rate - 10 },
                    { time: "10AM", bpm: patient.heart_rate - 5 },
                    { time: "12PM", bpm: patient.heart_rate },
                    { time: "2PM", bpm: patient.heart_rate + 3 },
                    { time: "4PM", bpm: patient.heart_rate + 2 },
                  ]}
                >
                  <CartesianGrid strokeDasharray="3 3" />
                  <XAxis dataKey="time" />
                  <YAxis />
                  <Tooltip />
                  <Line
                    type="monotone"
                    dataKey="bpm"
                    stroke="rgb(100, 130, 255)"
                    strokeWidth={2}
                  />
                </LineChart>
              </ResponsiveContainer>
            </div>
          )}
        </div>
      ))}
    </div>
  );
}

export default App;
