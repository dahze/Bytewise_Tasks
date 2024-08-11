// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '../models/genre.dart';
import '../models/movie.dart';
import '../services/movie_service.dart';

class SearchViewModel extends ChangeNotifier {
  final MovieService _movieService = MovieService();
  List<Movie> searchResults = [];
  List<Genre> genres = [];
  bool isLoading = false;

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      searchResults = [];
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      searchResults = await _movieService.searchMovies(query);
      print('Search Results: ${searchResults.length} movies found');
    } catch (e) {
      print('Error searching movies: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadGenres() async {
    isLoading = true;
    notifyListeners();

    try {
      genres = await _movieService.fetchGenres();
      print('Genres Loaded: ${genres.length} genres found');
    } catch (e) {
      print('Error fetching genres: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<List<Movie>> fetchMoviesByGenre(int genreId) async {
    isLoading = true;
    notifyListeners();

    try {
      final movies = await _movieService.fetchMoviesByGenre(genreId);
      print('Movies for Genre $genreId: ${movies.length} movies found');
      return movies;
    } catch (e) {
      print('Error fetching movies by genre: $e');
      return [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
