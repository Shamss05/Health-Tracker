import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/health_record.dart';
import '../providers/health_provider.dart';

class HealthInputForm extends StatefulWidget {
  const HealthInputForm({super.key});

  @override
  State<HealthInputForm> createState() => _HealthInputFormState();
}

class _HealthInputFormState extends State<HealthInputForm> {
  final _formKey = GlobalKey<FormState>();
  int _hoursSlept = 7;
  String _foodQuality = 'Good';
  bool _didExercise = false;
  String _mood = 'Happy';
  final _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Daily Health Input',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            // Hours Slept
            Row(
              children: [
                const Text('Hours Slept:', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    initialValue: _hoursSlept.toString(),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _hoursSlept = int.tryParse(value) ?? 7;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Food Quality
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Food Quality:', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'Good', label: Text('Good')),
                    ButtonSegment(value: 'Average', label: Text('Average')),
                    ButtonSegment(value: 'Poor', label: Text('Poor')),
                  ],
                  selected: {_foodQuality},
                  onSelectionChanged: (Set<String> selection) {
                    setState(() {
                      _foodQuality = selection.first;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Exercise:', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                SegmentedButton<bool>(
                  segments: const [
                    ButtonSegment(value: true, label: Text('Yes')),
                    ButtonSegment(value: false, label: Text('No')),
                  ],
                  selected: {_didExercise},
                  onSelectionChanged: (Set<bool> selection) {
                    setState(() {
                      _didExercise = selection.first;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Mood:', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'Happy', label: Text('Happy')),
                    ButtonSegment(value: 'Neutral', label: Text('Neutral')),
                    ButtonSegment(value: 'Sad', label: Text('Sad')),
                  ],
                  selected: {_mood},
                  onSelectionChanged: (Set<String> selection) {
                    setState(() {
                      _mood = selection.first;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Notes',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),

            FilledButton(
              onPressed: _saveRecord,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'SAVE',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveRecord() {
    if (_formKey.currentState!.validate()) {
      final record = HealthRecord(
        date: DateTime.now(),
        hoursSlept: _hoursSlept,
        foodQuality: _foodQuality,
        didExercise: _didExercise,
        mood: _mood,
        notes: _notesController.text.isEmpty ? null : _notesController.text,
      );

      context.read<HealthProvider>().addRecord(record);
      _notesController.clear();
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Health record saved!')),
      );
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }
} 