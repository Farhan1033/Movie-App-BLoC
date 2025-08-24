import 'package:equatable/equatable.dart';

class DetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetDetailMovie extends DetailEvent {
  final String movieId;
  GetDetailMovie(this.movieId);

  @override
  List<Object?> get props => [movieId];
}
