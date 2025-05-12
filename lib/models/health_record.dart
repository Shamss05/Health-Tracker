import 'package:hive/hive.dart';

part 'health_record.g.dart';

@HiveType(typeId: 0)
class HealthRecord extends HiveObject {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final int hoursSlept;

  @HiveField(2)
  final String foodQuality;

  @HiveField(3)
  final bool didExercise;

  @HiveField(4)
  final String mood;

  @HiveField(5)
  final String? notes;

  HealthRecord({
    required this.date,
    required this.hoursSlept,
    required this.foodQuality,
    required this.didExercise,
    required this.mood,
    this.notes,
  });
} 