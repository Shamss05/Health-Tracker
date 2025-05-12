import 'package:flutter/material.dart';
import 'package:health_app/providers/health_provider.dart';
import 'package:health_app/screens/home_screen.dart';
import 'package:provider/provider.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HealthProvider()..initialize(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Health Tracker',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: HomeScreen(),
      ),
    );
  }
}


