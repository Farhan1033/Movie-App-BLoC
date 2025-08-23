import 'package:equatable/equatable.dart';
import 'package:movie_ticket_app/home/models/movie_detail.dart';
import 'package:movie_ticket_app/home/models/movie_schedule.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<MovieSchedule> movies;
  HomeSuccess(this.movies);

  @override
  List<Object?> get props => [movies];
}

class HomeFailure extends HomeState {
  final String message;
  HomeFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class MovieDetailLoaded extends HomeState {
  final MovieDetail movie;
  MovieDetailLoaded(this.movie);

  @override
  List<Object?> get props => [movie];
}
