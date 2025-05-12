import 'package:flutter/material.dart';
import 'package:health_app/src/app_root.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/health_record.dart';



void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HealthRecordAdapter());
  runApp(MyApp());
}