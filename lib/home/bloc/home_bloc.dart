import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket_app/home/bloc/home_event.dart';
import 'package:movie_ticket_app/home/bloc/home_state.dart';
import 'package:movie_ticket_app/home/models/movie_schedule.dart';
import 'package:movie_ticket_app/home/models/movie_schedule_coming.dart';
import 'package:movie_ticket_app/home/repositories/movie_schedule_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MovieScheduleRepository _movieScheduleRepository;
  List<MovieSchedule> _currentMovies = [];
  List<MovieScheduleComing> _comingMovies = [];

  HomeBloc(this._movieScheduleRepository) : super(HomeInitial()) {
    on<GetMovieSchedule>((event, emit) async {
      emit(HomeLoading());
      try {
        final response = await _movieScheduleRepository.fetchMovie();
        _currentMovies = response.data;

        emit(HomeSuccess(
          movies: _currentMovies,
          movieComing: _comingMovies,
        ));
      } catch (e) {
        emit(HomeFailure("Error fetching current movies: ${e.toString()}"));
      }
    });

    on<GetMovieComing>((event, emit) async {
      try {
        final response = await _movieScheduleRepository.fetchMovieComingSoon();
        _comingMovies = response.data;

        emit(HomeSuccess(
          movies: _currentMovies,
          movieComing: _comingMovies,
        ));
      } catch (e) {
        emit(HomeFailure("Error fetching coming movies: ${e.toString()}"));
      }
    });
  }
}
