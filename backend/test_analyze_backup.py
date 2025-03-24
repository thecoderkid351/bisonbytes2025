
import requests

# Sample patient data
patient_data = {
    "heart_rate": 122,
    "resting_hr": 86,
    "steps": 5800,
    "sleep_hours": 3.5,
    "distance_km": 2.7,
    "note": "feeling lightheaded and tired"
}

# Send POST request to the Flask backend
response = requests.post("http://127.0.0.1:5000/analyze", json=patient_data)

# Print the response
print("Status Code:", response.status_code)
print("Response JSON:", response.json())