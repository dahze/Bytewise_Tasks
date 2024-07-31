import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://disease.sh/v3/covid-19';

  Future<Map<String, dynamic>> getGlobalData() async {
    final response = await http.get(Uri.parse('$baseUrl/all'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<dynamic>> getCountriesData() async {
    final response = await http.get(Uri.parse('$baseUrl/countries'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
