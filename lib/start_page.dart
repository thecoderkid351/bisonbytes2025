body: Container(
  decoration: const BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.yellow, Colors.blue],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  ),
  child: SafeArea(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome, ${widget.userName}!",
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Health Categories Being Tracked:",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: [
                const HealthCard(
                  icon: Icons.favorite,
                  color: Colors.red,
                  text: "Heart Rate",
                ),
                const HealthCard(
                  icon: Icons.run_circle,
                  color: Colors.green,
                  text: "Steps Count",
                ),
                const HealthCard(
                  icon: Icons.local_hospital,
                  color: Colors.blue,
                  text: "Blood Pressure",
                ),
                const HealthCard(
                  icon: Icons.water_drop,
                  color: Colors.purple,
                  text: "Hydration Level",
                ),
                const HealthCard(
                  icon: Icons.bedtime,
                  color: Colors.orange,
                  text: "Sleep Quality",
                ),
                const SizedBox(height: 20),
                const Text(
                  "Any concerns?",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _concernsController,
                  maxLines: 3,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Type your health concerns here...",
                    hintStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitConcerns,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      foregroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 30,
                      ),
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ),
),
