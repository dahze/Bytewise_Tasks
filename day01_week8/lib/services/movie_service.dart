// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';
import '../models/movie_details.dart';
import '../models/genre.dart';
import '../utils/constants.dart';

class MovieService {
  final String apiKey = Constants.apiKey;

  Future<List<Movie>> fetchPopularMovies() async {
    final response = await http
        .get(Uri.parse('${Constants.baseUrl}/movie/popular?api_key=$apiKey'));
    if (response.statusCode == 200) {
      final List<dynamic> results = json.decode(response.body)['results'];
      return results.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  Future<List<Movie>> fetchTopRatedMovies() async {
    final response = await http
        .get(Uri.parse('${Constants.baseUrl}/movie/top_rated?api_key=$apiKey'));
    if (response.statusCode == 200) {
      final List<dynamic> results = json.decode(response.body)['results'];
      return results.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load top rated movies');
    }
  }

  Future<List<Movie>> fetchUpcomingMovies() async {
    final response = await http
        .get(Uri.parse('${Constants.baseUrl}/movie/upcoming?api_key=$apiKey'));
    if (response.statusCode == 200) {
      final List<dynamic> results = json.decode(response.body)['results'];
      return results.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load upcoming movies');
    }
  }

  Future<List<Movie>> fetchNowPlayingMovies() async {
    final response = await http.get(
        Uri.parse('${Constants.baseUrl}/movie/now_playing?api_key=$apiKey'));
    if (response.statusCode == 200) {
      final List<dynamic> results = json.decode(response.body)['results'];
      return results.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load now playing movies');
    }
  }

  Future<MovieDetails> fetchMovieDetails(int movieId) async {
    final response = await http
        .get(Uri.parse('${Constants.baseUrl}/movie/$movieId?api_key=$apiKey'));
    if (response.statusCode == 200) {
      return MovieDetails.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    final response = await http.get(Uri.parse(
        '${Constants.baseUrl}/search/movie?query=$query&api_key=$apiKey'));
    if (response.statusCode == 200) {
      final List<dynamic> results = json.decode(response.body)['results'];
      return results.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to search movies');
    }
  }

  Future<List<Genre>> fetchGenres() async {
    final response = await http.get(Uri.parse(
        '${Constants.baseUrl}/genre/movie/list?api_key=$apiKey&language=en-US'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> genresJson = data['genres'];
      print('Genres fetched: $genresJson');
      return genresJson.map((json) => Genre.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load genres');
    }
  }

  Future<List<Movie>> fetchMoviesByGenre(int genreId) async {
    final response = await http.get(Uri.parse(
        '${Constants.baseUrl}/discover/movie?with_genres=$genreId&api_key=$apiKey'));
    if (response.statusCode == 200) {
      final List<dynamic> results = json.decode(response.body)['results'];
      return results.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load movies by genre');
    }
  }
}
