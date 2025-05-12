import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../providers/health_provider.dart';

class HealthCharts extends StatelessWidget {
  const HealthCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HealthProvider>(
      builder: (context, provider, child) {
        final sleepData = provider.getSleepData();
        final foodQualityData = provider.getFoodQualityDistribution();
        final moodData = provider.getMoodDistribution();

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Health Data',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              const Text('Hours Slept', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              SizedBox(
                height: 200,
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: true),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                        ),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(show: true),
                    lineBarsData: [
                      LineChartBarData(
                        spots: sleepData
                            .asMap()
                            .entries
                            .map((e) => FlSpot(
                                e.key.toDouble(), e.value.value.toDouble()))
                            .toList(),
                        isCurved: true,
                        color: Colors.blue,
                        barWidth: 3,
                        dotData: const FlDotData(show: true),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              const Text('Food Quality Distribution',
                  style: TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              SizedBox(
                height: 200,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: foodQualityData['Good']?.toDouble() ?? 0,
                        title: 'Good',
                        color: Colors.green,
                      ),
                      PieChartSectionData(
                        value: foodQualityData['Average']?.toDouble() ?? 0,
                        title: 'Average',
                        color: Colors.orange,
                      ),
                      PieChartSectionData(
                        value: foodQualityData['Poor']?.toDouble() ?? 0,
                        title: 'Poor',
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              const Text('Mood Distribution', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              SizedBox(
                height: 200,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: moodData['Happy']?.toDouble() ?? 0,
                        title: 'Happy',
                        color: Colors.green,
                      ),
                      PieChartSectionData(
                        value: moodData['Neutral']?.toDouble() ?? 0,
                        title: 'Neutral',
                        color: Colors.blue,
                      ),
                      PieChartSectionData(
                        value: moodData['Sad']?.toDouble() ?? 0,
                        title: 'Sad',
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
} 