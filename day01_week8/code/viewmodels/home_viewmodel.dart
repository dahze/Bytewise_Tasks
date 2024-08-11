import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/movie_service.dart';

class HomeViewModel extends ChangeNotifier {
  final MovieService _movieService = MovieService();
  List<Movie> popularMovies = [];
  List<Movie> topRatedMovies = [];
  List<Movie> upcomingMovies = [];
  List<Movie> nowPlayingMovies = [];
  bool isLoading = false;

  HomeViewModel() {
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    isLoading = true;
    notifyListeners();
    try {
      popularMovies = await _movieService.fetchPopularMovies();
      topRatedMovies = await _movieService.fetchTopRatedMovies();
      upcomingMovies = await _movieService.fetchUpcomingMovies();
      nowPlayingMovies = await _movieService.fetchNowPlayingMovies();
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching movies: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
