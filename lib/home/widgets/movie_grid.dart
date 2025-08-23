import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket_app/home/repositories/movie_schedule_repository.dart';
import 'package:movie_ticket_app/home/screen/movie_detail_screen.dart';
import '../models/movie_schedule.dart';
import 'movie_card.dart';

class MovieGrid extends StatelessWidget {
  final List<MovieSchedule> movies;
  const MovieGrid({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              const Text(
                "Now Playing",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE94560).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "${movies.length}",
                  style: const TextStyle(
                    color: Color(0xFFE94560),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: Builder(
            builder: (context) {
              return GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return InkWell(
                    onTap: () {
                      try {
                        final repository = context.read<MovieScheduleRepository>();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MovieDetailScreen(
                              movieId: movie.movieId,
                              movieScheduleRepository: repository,
                            ),
                          ),
                        );
                      } catch (e) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MovieDetailScreen(
                              movieId: movie.movieId,
                              movieScheduleRepository: MovieScheduleRepository(),
                            ),
                          ),
                        );
                      }
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    child: MovieCard(movie: movie),
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}