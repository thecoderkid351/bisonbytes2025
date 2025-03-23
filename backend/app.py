from flask import Flask, request, jsonify
from flask_cors import CORS
import openai
import os
from dotenv import load_dotenv
import logging

app = Flask(__name__)
CORS(app)

# Load environment variables
load_dotenv()
openai.api_key = os.getenv("OPENAI_API_KEY")

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def rule_based_risk_assessment(data):
    """Fallback rule-based risk assessment."""
    heart_rate = data.get("heart_rate", 0)
    resting_hr = data.get("resting_hr", 0)
    sleep_hours = data.get("sleep_hours", 0)

    risk = "low"
    if heart_rate > 100 or resting_hr > 90:
        risk = "high"
    elif sleep_hours < 5:
        risk = "medium"
    return risk

@app.route("/analyze", methods=["POST"])
def analyze():
    data = request.get_json()

    # Input validation
    required_fields = ["heart_rate", "resting_hr", "sleep_hours", "steps", "distance_km"]
    if not all(field in data for field in required_fields):
        return jsonify({"error": "Missing required fields"}), 400

    # Prompt building
    prompt = f"""
    You are a medical assistant. Here's the patient's vitals:
    - Heart rate: {data['heart_rate']} bpm
    - Resting heart rate: {data['resting_hr']} bpm
    - Sleep: {data['sleep_hours']} hours
    - Steps: {data['steps']}
    - Distance: {data['distance_km']} km
    - Patient note: "{data.get('note', '')}"

    Give a short medical-style summary of their health and classify the risk as low, medium, or high.
    """

    try:
        # Call GPT-3.5-turbo API
        response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo",
            messages=[{"role": "user", "content": prompt}],
            max_tokens=200
        )
        gpt_output = response.choices[0].message["content"]

        # Simple risk extraction
        risk = "low"
        if "high" in gpt_output.lower():
            risk = "high"
        elif "medium" in gpt_output.lower():
            risk = "medium"

        return jsonify({
            "summary": gpt_output,
            "risk": risk
        })

    except Exception as e:
        logger.error(f"OpenAI API error: {e}")
        # Fallback to rule-based risk assessment
        risk = rule_based_risk_assessment(data)
        return jsonify({
            "summary": "Unable to generate AI summary. Using rule-based risk assessment.",
            "risk": risk
        }), 200

if __name__ == "__main__":
    app.run(debug=True)