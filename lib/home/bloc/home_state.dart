import 'package:equatable/equatable.dart';
import 'package:movie_ticket_app/home/models/movie_schedule.dart';
import 'package:movie_ticket_app/home/models/movie_schedule_coming.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<MovieSchedule> movies;
  final List<MovieScheduleComing> movieComing;
  
  HomeSuccess({
    required this.movies,
    required this.movieComing,
  });

  @override
  List<Object?> get props => [movies, movieComing];
}

class HomeFailure extends HomeState {
  final String message;
  HomeFailure(this.message);

  @override
  List<Object?> get props => [message];
}