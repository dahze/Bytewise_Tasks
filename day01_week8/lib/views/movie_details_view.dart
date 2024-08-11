// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/movie_details_viewmodel.dart';
import '../viewmodels/library_viewmodel.dart';
import '../models/library_movie.dart';
import '../utils/database_helper.dart';

class MovieDetailsView extends StatefulWidget {
  final int movieId;
  final VoidCallback? onRemoveFromLibrary;

  const MovieDetailsView(
      {super.key, required this.movieId, this.onRemoveFromLibrary});

  @override
  // ignore: library_private_types_in_public_api
  _MovieDetailsViewState createState() => _MovieDetailsViewState();
}

class _MovieDetailsViewState extends State<MovieDetailsView> {
  bool isInLibrary = false;

  @override
  void initState() {
    super.initState();
    _checkIfInLibrary();
  }

  Future<void> _checkIfInLibrary() async {
    isInLibrary = await DatabaseHelper().isMovieInLibrary(widget.movieId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MovieDetailsViewModel(widget.movieId),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF2E2739),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: Image.asset(
            'assets/images/logo.png',
            height: 40,
          ),
          centerTitle: true,
        ),
        body: Consumer<MovieDetailsViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final movieDetails = viewModel.movieDetails;
            return movieDetails != null
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Stack(
                          children: [
                            Image.network(
                              'https://image.tmdb.org/t/p/w500${movieDetails.backdropPath}',
                              fit: BoxFit.cover,
                              height: 250,
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                color: Colors.black54,
                                child: Text(
                                  movieDetails.title,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Release Date: ${movieDetails.releaseDate}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Runtime: ${movieDetails.runtime} minutes',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Genres: ${movieDetails.genres.join(', ')}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                movieDetails.overview,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : const Center(
                    child: Text(
                      'No details available',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
          },
        ),
        backgroundColor: Colors.black,
        bottomNavigationBar: Consumer<MovieDetailsViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.movieDetails == null) return const SizedBox.shrink();

            final movieDetails = viewModel.movieDetails!;
            return Container(
              color: const Color(0xFF2E2739),
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () async {
                  final db = DatabaseHelper();
                  if (isInLibrary) {
                    await db.removeMovie(movieDetails.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('${movieDetails.title} removed from library'),
                      ),
                    );

                    widget.onRemoveFromLibrary?.call();
                  } else {
                    await db.addMovie(LibraryMovie(
                      id: movieDetails.id,
                      title: movieDetails.title,
                      posterPath: movieDetails.posterPath,
                      rating: movieDetails.rating,
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${movieDetails.title} added to library'),
                      ),
                    );
                  }

                  isInLibrary = !isInLibrary;
                  setState(() {});

                  final libraryViewModel =
                      Provider.of<LibraryViewModel>(context, listen: false);
                  await libraryViewModel.fetchMovies();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E2739),
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(27)),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(
                  isInLibrary ? 'Remove from Library' : 'Add to Library',
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
