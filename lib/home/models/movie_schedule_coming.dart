class MovieScheduleComing {
  final String id;
  final String title;
  final String description;
  final String genre;
  final int durationMinutes;
  final String rating;
  final String posterUrl;
  final bool statusMovie;
  final DateTime updatedAt;
  final DateTime createdAt;

  MovieScheduleComing(
      {required this.id,
      required this.title,
      required this.description,
      required this.genre,
      required this.durationMinutes,
      required this.rating,
      required this.posterUrl,
      required this.statusMovie,
      required this.createdAt,
      required this.updatedAt});

  factory MovieScheduleComing.fromJson(Map<String, dynamic> json) {
    return MovieScheduleComing(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        genre: json['genre'],
        durationMinutes: json['duration_minutes'],
        rating: json['rating'],
        posterUrl: json['poster_url'],
        statusMovie: json['status_movie'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'genre': genre,
      'duration_minutes': durationMinutes,
      'rating': rating,
      'poster_url': posterUrl,
      'status_movie': statusMovie,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String()
    };
  }
}
