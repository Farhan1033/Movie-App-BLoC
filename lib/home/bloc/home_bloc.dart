import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket_app/home/bloc/home_event.dart';
import 'package:movie_ticket_app/home/bloc/home_state.dart';
import 'package:movie_ticket_app/home/repositories/movie_schedule_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MovieScheduleRepository _movieScheduleRepository;

  HomeBloc(this._movieScheduleRepository) : super(HomeInitial()) {
    on<GetMovieSchedule>((event, emit) async {
      emit(HomeLoading());
      try {
        final response = await _movieScheduleRepository.fetchMovie();
        emit(HomeSuccess(response.data));
      } catch (e) {
        emit(HomeFailure("Error: ${e.toString()}"));
      }
    });

    on<GetDetailMovie>((event, emit) async {
      emit(HomeLoading());
      try {
        final movie =
            await _movieScheduleRepository.fetchDetailMovie(event.movieId);
        emit(MovieDetailLoaded(movie.data));
      } catch (e) {
        emit(HomeFailure("Error: ${e.toString()}"));
      }
    });
  }
}
