class MovieDetails {
  final int id;
  final String title;
  final String backdropPath;
  final String posterPath;
  final double rating;
  final String releaseDate;
  final int runtime;
  final List<String> genres;
  final String overview;

  MovieDetails({
    required this.id,
    required this.title,
    required this.backdropPath,
    required this.posterPath,
    required this.rating,
    required this.releaseDate,
    required this.runtime,
    required this.genres,
    required this.overview,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    return MovieDetails(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Unknown Title',
      backdropPath: json['backdrop_path'] ?? '',
      posterPath: json['poster_path'] ?? '',
      rating: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      releaseDate: json['release_date'] ?? 'Unknown Release Date',
      runtime: json['runtime'] ?? 0,
      genres: (json['genres'] as List<dynamic>? ?? [])
          .map((genre) => genre['name'] as String? ?? 'Unknown Genre')
          .toList(),
      overview: json['overview'] ?? 'No Overview Available',
    );
  }
}
