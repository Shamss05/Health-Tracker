import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/health_provider.dart';

class HealthRecordsList extends StatelessWidget {
  const HealthRecordsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HealthProvider>(
      builder: (context, provider, child) {
        final records = provider.records;

        if (records.isEmpty) {
          return const Center(
            child: Text('No health records yet. Start tracking your health!'),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: records.length,
          itemBuilder: (context, index) {
            final record = records[index];
            final date = DateFormat('MMMM dd, yyyy').format(record.date);

            return Card(
              margin: const EdgeInsets.only(bottom: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildInfoRow('Hours Slept:', record.hoursSlept.toString()),
                    _buildInfoRow('Food Quality:', record.foodQuality),
                    _buildInfoRow(
                        'Exercise:', record.didExercise ? 'Yes' : 'No'),
                    _buildInfoRow('Mood:', record.mood),
                    if (record.notes != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Notes:',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        record.notes!,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
} 