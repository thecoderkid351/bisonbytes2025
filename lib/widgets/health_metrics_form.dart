import 'package:flutter/material.dart';

class HealthMetricsForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;

  const HealthMetricsForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _HealthMetricsFormState createState() => _HealthMetricsFormState();
}

class _HealthMetricsFormState extends State<HealthMetricsForm> {
  final _formKey = GlobalKey<FormState>();
  final _heartRateController = TextEditingController();
  final _restingHrController = TextEditingController();
  final _sleepHoursController = TextEditingController();
  final _stepsController = TextEditingController();
  final _distanceController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _heartRateController.dispose();
    _restingHrController.dispose();
    _sleepHoursController.dispose();
    _stepsController.dispose();
    _distanceController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit({
        'heart_rate': double.parse(_heartRateController.text),
        'resting_hr': double.parse(_restingHrController.text),
        'sleep_hours': double.parse(_sleepHoursController.text),
        'steps': int.parse(_stepsController.text),
        'distance_km': double.parse(_distanceController.text),
        'note': _noteController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Card(
            elevation: 4,
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter Health Metrics',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: 16),
                  _buildTextFormField(
                    controller: _heartRateController,
                    label: 'Heart Rate (bpm)',
                    validator: _numberValidator,
                  ),
                  _buildTextFormField(
                    controller: _restingHrController,
                    label: 'Resting Heart Rate (bpm)',
                    validator: _numberValidator,
                  ),
                  _buildTextFormField(
                    controller: _sleepHoursController,
                    label: 'Sleep Hours',
                    validator: _numberValidator,
                  ),
                  _buildTextFormField(
                    controller: _stepsController,
                    label: 'Steps',
                    validator: _integerValidator,
                  ),
                  _buildTextFormField(
                    controller: _distanceController,
                    label: 'Distance (km)',
                    validator: _numberValidator,
                  ),
                  _buildTextFormField(
                    controller: _noteController,
                    label: 'Notes (optional)',
                    maxLines: 3,
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Analyze Health Data'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    int? maxLines,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        maxLines: maxLines ?? 1,
        validator: validator,
      ),
    );
  }

  String? _numberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    return null;
  }

  String? _integerValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (int.tryParse(value) == null) {
      return 'Please enter a valid whole number';
    }
    return null;
  }
} 