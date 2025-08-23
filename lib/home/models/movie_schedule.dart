class MovieSchedule {
  final String id;
  final String movieId;
  final String movieTitle;
  final String movieDesc;
  final String movieGenre;
  final String moviePoster;
  final String movieRating;
  final String studioName;
  final String studioLocation;
  final String startTime;
  final String endTime;
  final int price;
  final DateTime createdAt;
  final DateTime updatedAt;

  MovieSchedule({
    required this.id,
    required this.movieId,
    required this.movieTitle,
    required this.movieDesc,
    required this.movieGenre,
    required this.moviePoster,
    required this.movieRating,
    required this.studioName,
    required this.studioLocation,
    required this.startTime,
    required this.endTime,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MovieSchedule.fromJson(Map<String, dynamic> json) {
    return MovieSchedule(
      id: json['id'],
      movieId: json['movie_id'],
      movieTitle: json['movie_title'],
      movieDesc: json['movie_desc'],
      movieGenre: json['movie_genre'],
      moviePoster: json['movie_poster'],
      movieRating: json['movie_rating'],
      studioName: json['studio_name'],
      studioLocation: json['studio_location'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      price: json['price'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "movie_id": movieId,
      "movie_title": movieTitle,
      "movie_desc": movieDesc,
      "movie_genre": movieGenre,
      "movie_poster": moviePoster,
      "movie_rating": movieRating,
      "studio_name": studioName,
      "studio_location": studioLocation,
      "start_time": startTime,
      "end_time": endTime,
      "price": price,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
    };
  }
}
