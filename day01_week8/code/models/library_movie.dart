class LibraryMovie {
  final int id;
  final String title;
  final String posterPath;
  final double rating;

  LibraryMovie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.rating,
  });

  factory LibraryMovie.fromMap(Map<String, dynamic> map) {
    return LibraryMovie(
      id: map['id'],
      title: map['title'],
      posterPath: map['posterPath'],
      rating: map['rating'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'posterPath': posterPath,
      'rating': rating,
    };
  }
}
