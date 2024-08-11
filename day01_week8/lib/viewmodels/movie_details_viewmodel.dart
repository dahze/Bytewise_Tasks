// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '../models/movie_details.dart';
import '../services/movie_service.dart';

class MovieDetailsViewModel extends ChangeNotifier {
  final MovieService _movieService = MovieService();
  final int movieId;

  MovieDetails? movieDetails;
  bool isLoading = false;

  MovieDetailsViewModel(this.movieId) {
    fetchMovieDetails();
  }

  Future<void> fetchMovieDetails() async {
    isLoading = true;
    notifyListeners();

    try {
      movieDetails = await _movieService.fetchMovieDetails(movieId);
    } catch (e) {
      print('Error fetching movie details: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
