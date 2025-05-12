
part of 'health_record.dart';

class HealthRecordAdapter extends TypeAdapter<HealthRecord> {
  @override
  final int typeId = 0;

  @override
  HealthRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HealthRecord(
      date: fields[0] as DateTime,
      hoursSlept: fields[1] as int,
      foodQuality: fields[2] as String,
      didExercise: fields[3] as bool,
      mood: fields[4] as String,
      notes: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HealthRecord obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.hoursSlept)
      ..writeByte(2)
      ..write(obj.foodQuality)
      ..writeByte(3)
      ..write(obj.didExercise)
      ..writeByte(4)
      ..write(obj.mood)
      ..writeByte(5)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
