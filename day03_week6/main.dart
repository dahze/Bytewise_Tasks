import 'package:flutter/material.dart';
import 'api_service.dart';
import 'country_detail_page.dart';
import 'pie_chart_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COVID-19 Tracker',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
        ),
        cardTheme: CardTheme(
          color: Colors.grey[850],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService apiService = ApiService();
  Map<String, dynamic>? globalData;
  List<dynamic>? countriesData;
  List<dynamic>? filteredCountriesData;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    globalData = await apiService.getGlobalData();
    countriesData = await apiService.getCountriesData();
    filteredCountriesData = countriesData;
    setState(() {});
  }

  void filterCountries(String query) {
    List<dynamic> filtered = countriesData!.where((country) {
      String countryName = country['country'].toLowerCase();
      return countryName.contains(query.toLowerCase());
    }).toList();
    setState(() {
      filteredCountriesData = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COVID-19 Tracker'),
      ),
      body: globalData == null || filteredCountriesData == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Global Data',
                        style: TextStyle(fontSize: 24, color: Colors.white)),
                  ),
                  Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 200, // Constrained height
                              child: PieChartWidget(
                                cases: globalData!['cases'].toDouble(),
                                deaths: globalData!['deaths'].toDouble(),
                                recovered: globalData!['recovered'].toDouble(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Total Cases: ${globalData!['cases']}',
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.white)),
                                Text('Total Deaths: ${globalData!['deaths']}',
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.white)),
                                Text(
                                    'Total Recovered: ${globalData!['recovered']}',
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.white)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.white),
                        labelText: 'Search Countries',
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                      onChanged: filterCountries,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Countries Data',
                        style: TextStyle(fontSize: 24, color: Colors.white)),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredCountriesData!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16.0),
                          title: Text(filteredCountriesData![index]['country'],
                              style: const TextStyle(color: Colors.white)),
                          subtitle: Text(
                              'Cases: ${filteredCountriesData![index]['cases']}',
                              style: const TextStyle(color: Colors.white70)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CountryDetailPage(
                                  countryData: filteredCountriesData![index],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
