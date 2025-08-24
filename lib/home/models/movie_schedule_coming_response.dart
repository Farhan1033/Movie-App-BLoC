import 'package:movie_ticket_app/home/models/movie_schedule_coming.dart';

class MovieScheduleComingResponse {
  final String message;
  final List<MovieScheduleComing> data;

  MovieScheduleComingResponse({required this.message, required this.data});

  factory MovieScheduleComingResponse.fromJson(Map<String, dynamic> json) {
    return MovieScheduleComingResponse(
      message: json['message'],
      data: (json['data'] as List)
          .map((e) => MovieScheduleComing.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "data": data.map((e) => e.toJson()).toList(),
    };
  }
}
