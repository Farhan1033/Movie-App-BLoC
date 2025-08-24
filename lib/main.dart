import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket_app/authentication/bloc/auth_bloc.dart';
import 'package:movie_ticket_app/authentication/bloc/auth_event.dart';
import 'package:movie_ticket_app/authentication/bloc/auth_state.dart';
import 'package:movie_ticket_app/authentication/repositories/auth_repository.dart';
import 'package:movie_ticket_app/authentication/screens/login_screen.dart';
import 'package:movie_ticket_app/authentication/screens/register_screen.dart';
import 'package:movie_ticket_app/detail_movie/bloc/detail_bloc.dart';
import 'package:movie_ticket_app/detail_movie/repositories/movie_detail_repository.dart';
import 'package:movie_ticket_app/home/bloc/home_bloc.dart';
import 'package:movie_ticket_app/home/repositories/movie_schedule_repository.dart';
import 'package:movie_ticket_app/home/screen/home_screen.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AuthRepository authRepository = AuthRepository();
  final MovieScheduleRepository movieScheduleRepository =
      MovieScheduleRepository();
  final MovieDetailRepository movieDetailRepository = MovieDetailRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (_) => AuthBloc(authRepository)..add(AppStarted()),
            ),
            BlocProvider<HomeBloc>(
              create: (_) => HomeBloc(movieScheduleRepository),
            ),
            BlocProvider<DetailBloc>(
                create: (_) => DetailBloc(movieDetailRepository))
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthInitial || state is AuthLoading) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is Authenticated) {
                  return const HomeScreen();
                } else {
                  return const LoginScreen();
                }
              },
            ),
            routes: {
              '/login': (context) => const LoginScreen(),
              '/register': (context) => const RegisterScreen(),
              '/home': (context) => const HomeScreen(),
            },
          ),
        ));
  }
}
