import 'package:flutter/material.dart';
import 'package:movie_ticket_app/home/models/movie_detail.dart';
import 'package:movie_ticket_app/pkg/widget/color.dart';

class MovieHeroSection extends StatelessWidget {
  final MovieDetail movie;

  const MovieHeroSection({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 400,
      floating: false,
      pinned: true,
      backgroundColor: darkBg,
      iconTheme: const IconThemeData(color: Colors.white),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image atau placeholder
            _buildBackgroundImage(),

            // Gradient Overlay
            _buildGradientOverlay(),

            // Movie info overlay
            _buildMovieInfoOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundImage() {
    if (movie.posterUrl != '') {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(movie.posterUrl),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFE94560).withOpacity(0.3),
            darkBg,
          ],
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.movie,
          size: 80,
          color: Colors.white54,
        ),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.5, 1.0],
          colors: [
            Colors.black.withOpacity(0.3),
            Colors.transparent,
            darkBg.withOpacity(0.9),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieInfoOverlay() {
    return Positioned(
      bottom: 20,
      left: 16,
      right: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            movie.title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  offset: Offset(0, 2),
                  blurRadius: 4,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          if (movie.genre != '') GenreChip(genre: movie.genre),
        ],
      ),
    );
  }
}

// Widget untuk Genre Chip
class GenreChip extends StatelessWidget {
  final String genre;

  const GenreChip({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE94560).withOpacity(0.9),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        genre,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// Widget untuk Movie Stats (Duration, Rating, etc)
class MovieStatsCard extends StatelessWidget {
  final MovieDetail movie;

  const MovieStatsCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    if (movie.durationMinutes == 0 && movie.rating == '') {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (movie.durationMinutes != 0)
            MovieStatItem(
              icon: Icons.access_time_rounded,
              value: "${movie.durationMinutes} min",
              label: "Durasi",
            ),
          if (movie.durationMinutes != 0 && movie.rating != '')
            Container(
              height: 40,
              width: 1,
              color: Colors.grey.withOpacity(0.3),
            ),
          if (movie.rating != '')
            MovieStatItem(
              icon: Icons.star_rounded,
              value: movie.rating,
              label: "Rating",
              iconColor: Colors.amber,
            ),
        ],
      ),
    );
  }
}

// Widget untuk individual stat item
class MovieStatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color iconColor;

  const MovieStatItem({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.iconColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: iconColor, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

// Widget untuk Section Header dengan accent line
class SectionHeader extends StatelessWidget {
  final String title;
  final Color accentColor;

  const SectionHeader({
    super.key,
    required this.title,
    this.accentColor = const Color(0xFFE94560),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

// Widget untuk Synopsis Card
class SynopsisCard extends StatelessWidget {
  final String description;

  const SynopsisCard({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Text(
        description,
        style: TextStyle(
          color: Colors.grey[300],
          fontSize: 16,
          height: 1.6,
          letterSpacing: 0.3,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }
}

// Widget untuk Action Button (Book Ticket)
class BookTicketButton extends StatelessWidget {
  final String movieTitle;
  final VoidCallback? onPressed;

  const BookTicketButton({
    super.key,
    required this.movieTitle,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE94560), Color(0xFFFF6B8A)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE94560).withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed ??
            () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Booking tiket untuk $movieTitle'),
                  backgroundColor: const Color(0xFFE94560),
                ),
              );
            },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.movie_creation_outlined, color: Colors.white, size: 24),
            SizedBox(width: 12),
            Text(
              'Pesan Tiket',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget untuk Error State
class MovieDetailErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const MovieDetailErrorState({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.red.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                size: 48,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Oops! Ada Masalah",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 16,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text("Coba Lagi"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE94560),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
