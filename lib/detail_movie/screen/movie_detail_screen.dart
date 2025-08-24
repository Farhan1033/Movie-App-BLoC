import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket_app/detail_movie/bloc/detail_bloc.dart';
import 'package:movie_ticket_app/detail_movie/bloc/detail_event.dart';
import 'package:movie_ticket_app/detail_movie/bloc/detail_state.dart';
import 'package:movie_ticket_app/detail_movie/models/movie_detail.dart';
import 'package:movie_ticket_app/detail_movie/widgets/movie_detail_widgets.dart';
import 'package:movie_ticket_app/pkg/widget/color.dart';

class MovieDetailScreen extends StatefulWidget {
  final String movieId;

  const MovieDetailScreen({super.key, required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DetailBloc>().add(GetDetailMovie(widget.movieId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      body: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) {
          if (state is DetailLoading) {
            return _buildLoadingState();
          }

          if (state is MovieDetailLoaded) {
            return _buildMovieDetailContent(state.movie, context);
          }

          if (state is DetailFailure) {
            return MovieDetailErrorState(
              message: state.message,
              onRetry: () => context
                  .read<DetailBloc>()
                  .add(GetDetailMovie(widget.movieId)),
            );
          }

          return const SizedBox();
        },
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
        MovieHeroSection(movie: movie),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MovieStatsCard(movie: movie),
                const SizedBox(height: 30),
                const SectionHeader(title: "Sinopsis"),
                const SizedBox(height: 16),
                SynopsisCard(description: movie.description),
                const SizedBox(height: 30),
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
