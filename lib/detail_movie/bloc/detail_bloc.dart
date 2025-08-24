import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket_app/detail_movie/bloc/detail_event.dart';
import 'package:movie_ticket_app/detail_movie/bloc/detail_state.dart';
import 'package:movie_ticket_app/detail_movie/repositories/movie_detail_repository.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final MovieDetailRepository _movieDetailRepository;

  DetailBloc(this._movieDetailRepository) : super(DetailInitial()) {
    on<GetDetailMovie>((event, emit) async {
      emit(DetailLoading());
      try {
        final movie =
            await _movieDetailRepository.fetchDetailMovie(event.movieId);
        emit(MovieDetailLoaded(movie.data));
      } catch (e) {
        emit(DetailFailure("Error: ${e.toString()}"));
      }
    });
  }
}
