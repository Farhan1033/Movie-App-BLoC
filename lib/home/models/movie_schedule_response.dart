import 'package:movie_ticket_app/home/models/movie_schedule.dart';

class MovieScheduleResponse {
  final String message;
  final List<MovieSchedule> data;

  MovieScheduleResponse({
    required this.message,
    required this.data,
  });

  factory MovieScheduleResponse.fromJson(Map<String, dynamic> json) {
    return MovieScheduleResponse(
      message: json['message'],
      data:
          (json['data'] as List).map((e) => MovieSchedule.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "data": data.map((e) => e.toJson()).toList(),
    };
  }
}
