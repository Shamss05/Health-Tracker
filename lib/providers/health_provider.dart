import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/health_record.dart';

class HealthProvider with ChangeNotifier {
  static const String _boxName = 'health_records';
  late Box<HealthRecord> _box;

  List<HealthRecord> _records = [];
  List<HealthRecord> get records => _records;

  Future<void> initialize() async {
    _box = await Hive.openBox<HealthRecord>(_boxName);
    _loadRecords();
  }

  void _loadRecords() {
    _records = _box.values.toList()
      ..sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }

  Future<void> addRecord(HealthRecord record) async {
    await _box.add(record);
    _loadRecords();
  }

  List<HealthRecord> getLastNRecords(int n) {
    return _records.take(n).toList();
  }

  Map<String, int> getFoodQualityDistribution() {
    final distribution = {'Good': 0, 'Average': 0, 'Poor': 0};
    for (var record in _records) {
      distribution[record.foodQuality] = (distribution[record.foodQuality] ?? 0) + 1;
    }
    return distribution;
  }

  Map<String, int> getMoodDistribution() {
    final distribution = {'Happy': 0, 'Neutral': 0, 'Sad': 0};
    for (var record in _records) {
      distribution[record.mood] = (distribution[record.mood] ?? 0) + 1;
    }
    return distribution;
  }

  List<MapEntry<DateTime, int>> getSleepData() {
    return _records
        .map((record) => MapEntry(record.date, record.hoursSlept))
        .toList();
  }
} 