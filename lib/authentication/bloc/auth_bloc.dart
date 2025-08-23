import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket_app/authentication/bloc/auth_event.dart';
import 'package:movie_ticket_app/authentication/bloc/auth_state.dart';
import 'package:movie_ticket_app/authentication/repositories/auth_repository.dart';
import 'package:movie_ticket_app/pkg/storage/secure_storage.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<LoginRequest>((event, emit) async {
      emit(AuthLoading());
      try {
        final success = await _authRepository.signIn(
            email: event.email, password: event.password);
        if (success != null) {
          emit(AuthSuccess());
        } else {
          emit(AuthFailure(
              'Login failed, please check your email and password again.'));
        }
      } catch (e) {
        emit(AuthFailure('Error: ${e.toString()}'));
      }
    });

    on<RegisterRequest>((event, emit) async {
      emit(AuthLoading());
      try {
        final success = await _authRepository.signUp(
            email: event.email,
            password: event.password,
            fullName: event.fullName,
            phoneNumber: event.phoneNumber);

        if (success != null) {
          emit(AuthSuccess());
        } else {
          emit(AuthFailure('Failed to create an account, please try again'));
        }
      } catch (e) {
        emit(AuthFailure('Error: ${e.toString()}'));
      }
    });

    on<LogoutRequest>((event, emit) async {
      emit(AuthLoading());
      try {
        final token = await SecureStorage.findToken();
        if (token != null) {
          final success = await _authRepository.signOut(token: token);
          if (success != null) {
            emit(AuthSuccess());
          } else {
            emit(AuthFailure('Invalid format token'));
          }
          await SecureStorage.deleteToken();
        }
      } catch (e) {
        emit(AuthFailure('Error: ${e.toString()}'));
      }
    });

    on<AppStarted>((event, emit) async {
      emit(AuthLoading());
      final token = await SecureStorage.findToken();
      if (token != null) {
        emit(Authenticated(token));
      } else {
        emit(Unauthenticated());
      }
    });
  }
}
