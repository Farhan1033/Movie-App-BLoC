import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket_app/home/bloc/home_bloc.dart';
import 'package:movie_ticket_app/home/bloc/home_event.dart';
import 'package:movie_ticket_app/home/bloc/home_state.dart';
import 'package:movie_ticket_app/home/widgets/custom_home_appbar.dart';
import 'package:movie_ticket_app/home/widgets/error_state_widget.dart';
import 'package:movie_ticket_app/home/widgets/loading_state_widget.dart';
import 'package:movie_ticket_app/home/widgets/movie_grid.dart';
import 'package:movie_ticket_app/home/widgets/movie_grid_comingsoon.dart';
import 'package:movie_ticket_app/pkg/widget/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    final bloc = context.read<HomeBloc>();
    bloc.add(GetMovieSchedule());
    bloc.add(GetMovieComing());
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      body: Column(
        children: [
          const CustomHomeAppBar(),
          _buildToggleButtons(),
          Expanded(
            child: BlocConsumer<HomeBloc, HomeState>(
              listener: _handleHomeStateChanges,
              builder: (context, state) => _buildContent(state),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButtons() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: _buildToggleButton(
              title: "Now Playing",
              isSelected: _selectedIndex == 0,
              onTap: () => _onTabSelected(0),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildToggleButton(
              title: "Coming Soon",
              isSelected: _selectedIndex == 1,
              onTap: () => _onTabSelected(1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE94560) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFE94560)
                : Colors.grey.withOpacity(0.3),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildContent(HomeState state) {
    if (state is HomeLoading) {
      return const LoadingStateWidget();
    } else if (state is HomeFailure) {
      return ErrorStateWidget(message: state.message);
    } else if (state is HomeSuccess) {
      return _selectedIndex == 0
          ? MovieGrid(movies: state.movies)
          : MovieGridComingsoon(movies: state.movieComing);
    }
    return const SizedBox.shrink();
  }

  void _handleHomeStateChanges(BuildContext context, HomeState state) {
    if (state is HomeFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: Colors.red.withOpacity(0.8),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
