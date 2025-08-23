import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket_app/home/bloc/home_bloc.dart';
import 'package:movie_ticket_app/home/bloc/home_event.dart';
import 'package:movie_ticket_app/home/bloc/home_state.dart';
import 'package:movie_ticket_app/home/widgets/custom_home_appbar.dart';
import 'package:movie_ticket_app/home/widgets/error_state_widget.dart';
import 'package:movie_ticket_app/home/widgets/loading_state_widget.dart';
import 'package:movie_ticket_app/home/widgets/movie_grid.dart';
import 'package:movie_ticket_app/pkg/widget/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetMovieSchedule());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg ,
      body: Column(
        children: [
          const CustomHomeAppBar(),
          Expanded(
            child: BlocConsumer<HomeBloc, HomeState>(
              listener: _handleHomeStateChanges,
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const LoadingStateWidget();
                } else if (state is HomeFailure) {
                  return ErrorStateWidget(message: state.message);
                } else if (state is HomeSuccess) {
                  return MovieGrid(movies: state.movies);
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
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
