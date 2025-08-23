import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket_app/home/bloc/home_bloc.dart';
import 'package:movie_ticket_app/home/bloc/home_event.dart';
import 'package:movie_ticket_app/home/bloc/home_state.dart';
import 'package:movie_ticket_app/home/repositories/movie_schedule_repository.dart';
import 'package:movie_ticket_app/home/models/movie_detail.dart';
import 'package:movie_ticket_app/home/widgets/movie_detail_widgets.dart';
import 'package:movie_ticket_app/pkg/widget/color.dart';

class MovieDetailScreen extends StatelessWidget {
  final String movieId;
  final MovieScheduleRepository movieScheduleRepository;

  const MovieDetailScreen({
    super.key,
    required this.movieId,
    required this.movieScheduleRepository,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(movieScheduleRepository)..add(GetDetailMovie(movieId)),
      child: Scaffold(
        backgroundColor: darkBg,
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return _buildLoadingState();
            } 
            
            if (state is MovieDetailLoaded) {
              return _buildMovieDetailContent(state.movie, context);
            } 
            
            if (state is HomeFailure) {
              return MovieDetailErrorState(
                message: state.message,
                onRetry: () => context.read<HomeBloc>().add(GetDetailMovie(movieId)),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE94560)),
      ),
    );
  }

  Widget _buildMovieDetailContent(MovieDetail movie, BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Hero Section dengan poster dan title
        MovieHeroSection(movie: movie),
        
        // Content Section
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Movie Stats (Duration, Rating)
                MovieStatsCard(movie: movie),
                
                const SizedBox(height: 30),
                
                // Synopsis Section
                const SectionHeader(title: "Sinopsis"),
                const SizedBox(height: 16),
                SynopsisCard(description: movie.description),
                
                const SizedBox(height: 30),
                
                // Book Ticket Button
                BookTicketButton(
                  movieTitle: movie.title,
                  onPressed: () => _handleBookTicket(context, movie),
                ),
                
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _handleBookTicket(BuildContext context, MovieDetail movie) {
    // Implement booking logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Booking tiket untuk ${movie.title}'),
        backgroundColor: const Color(0xFFE94560),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}