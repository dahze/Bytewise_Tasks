// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '../models/library_movie.dart';
import '../utils/database_helper.dart';

class LibraryViewModel extends ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<LibraryMovie> _movies = [];
  bool _isLoading = false;

  List<LibraryMovie> get movies => _movies;
  bool get isLoading => _isLoading;

  LibraryViewModel() {
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    _setLoading(true);
    try {
      final moviesData = await _databaseHelper.getAllMovies();
      _movies = moviesData;
      notifyListeners();
    } catch (e) {
      print('Error fetching movies: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addMovie(LibraryMovie movie) async {
    try {
      await _databaseHelper.addMovie(movie);
      fetchMovies();
    } catch (e) {
      print('Error adding movie: $e');
    }
  }

  Future<void> removeMovie(int movieId) async {
    try {
      await _databaseHelper.removeMovie(movieId);
      fetchMovies();
    } catch (e) {
      print('Error removing movie: $e');
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
