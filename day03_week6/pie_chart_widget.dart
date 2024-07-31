import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartWidget extends StatelessWidget {
  final double cases;
  final double deaths;
  final double recovered;

  const PieChartWidget(
      {super.key,
      required this.cases,
      required this.deaths,
      required this.recovered});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            color: Colors.blue,
            value: cases,
            title: 'Cases',
            radius: 50,
            titleStyle: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          PieChartSectionData(
            color: Colors.red,
            value: deaths,
            title: 'Deaths',
            radius: 50,
            titleStyle: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          PieChartSectionData(
            color: Colors.green,
            value: recovered,
            title: 'Recovered',
            radius: 50,
            titleStyle: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
        borderData: FlBorderData(show: false),
        sectionsSpace: 0,
        centerSpaceRadius: 40,
      ),
    );
  }
}
