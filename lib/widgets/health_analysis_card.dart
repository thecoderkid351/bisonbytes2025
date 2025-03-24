import 'package:flutter/material.dart';

class HealthAnalysisCard extends StatelessWidget {
  final String summary;
  final String risk;

  const HealthAnalysisCard({
    Key? key,
    required this.summary,
    required this.risk,
  }) : super(key: key);

  Color _getRiskColor() {
    switch (risk.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Health Analysis',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Chip(
                  label: Text(
                    risk.toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: _getRiskColor(),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(summary),
          ],
        ),
      ),
    );
  }
} 