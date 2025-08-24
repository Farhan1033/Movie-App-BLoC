  import 'package:equatable/equatable.dart';
  import 'package:movie_ticket_app/detail_movie/models/movie_detail.dart';

  class DetailState extends Equatable {
    @override
    List<Object?> get props => [];
  }

  class DetailInitial extends DetailState {}

  class DetailLoading extends DetailState {}

  class DetailFailure extends DetailState {
    final String message;
    DetailFailure(this.message);

    @override
    List<Object?> get props => [message];
  }


  class MovieDetailLoaded extends DetailState {
    final MovieDetail movie;
    MovieDetailLoaded(this.movie);

    @override
    List<Object?> get props => [movie];
  }
