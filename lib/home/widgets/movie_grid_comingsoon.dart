import 'package:flutter/material.dart';
import 'package:movie_ticket_app/detail_movie/screen/movie_detail_screen.dart';
import 'package:movie_ticket_app/home/models/movie_schedule_coming.dart';
import 'package:movie_ticket_app/home/widgets/movie_card_coming.dart';

class MovieGridComingsoon extends StatelessWidget {
  final List<MovieScheduleComing> movies;
  const MovieGridComingsoon({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final filteredMovies = movies.where((m) => m.statusMovie == false).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              const Text(
                "Coming Soon",
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
                  "${filteredMovies.length}",
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
          child: filteredMovies.isEmpty
              ? const Center(
                  child: Text(
                    "No movies available",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: filteredMovies.length,
                  itemBuilder: (context, index) {
                    final movie = filteredMovies[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                MovieDetailScreen(movieId: movie.id),
                          ),
                        );
                      },
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      child: MovieCardComing(movie: movie),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
