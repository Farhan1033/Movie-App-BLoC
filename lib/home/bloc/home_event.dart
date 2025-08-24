import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMovieSchedule extends HomeEvent {}

class GetMovieComing extends HomeEvent {}
