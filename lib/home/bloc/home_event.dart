import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMovieSchedule extends HomeEvent {}

class GetDetailMovie extends HomeEvent {
  final String movieId;
  GetDetailMovie(this.movieId);

  @override
  List<Object?> get props => [movieId];
}
