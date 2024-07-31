import 'package:flutter/material.dart';
import 'pie_chart_widget.dart';

class CountryDetailPage extends StatelessWidget {
  final Map<String, dynamic> countryData;

  const CountryDetailPage({super.key, required this.countryData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(countryData['country']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200, // Constrained height
              child: PieChartWidget(
                cases: countryData['cases'].toDouble(),
                deaths: countryData['deaths'].toDouble(),
                recovered: countryData['recovered'].toDouble(),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Cases: ${countryData['cases']}',
                        style: const TextStyle(fontSize: 18)),
                    Text('Deaths: ${countryData['deaths']}',
                        style: const TextStyle(fontSize: 18)),
                    Text('Recovered: ${countryData['recovered']}',
                        style: const TextStyle(fontSize: 18)),
                    Text('Active: ${countryData['active']}',
                        style: const TextStyle(fontSize: 18)),
                    Text('Critical: ${countryData['critical']}',
                        style: const TextStyle(fontSize: 18)),
                    Text('Cases Today: ${countryData['todayCases']}',
                        style: const TextStyle(fontSize: 18)),
                    Text('Deaths Today: ${countryData['todayDeaths']}',
                        style: const TextStyle(fontSize: 18)),
                    Text('Recovered Today: ${countryData['todayRecovered']}',
                        style: const TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
