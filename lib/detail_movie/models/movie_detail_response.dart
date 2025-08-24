import 'package:movie_ticket_app/detail_movie/models/movie_detail.dart';

class MovieDetailResponse {
  final String message;
  final MovieDetail data;

  MovieDetailResponse({required this.message, required this.data});

  factory MovieDetailResponse.fromJson(Map<String, dynamic> json) {
    return MovieDetailResponse(
      message: json['message'],
      data: MovieDetail.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "data": data.toJson(),
    };
  }
}
