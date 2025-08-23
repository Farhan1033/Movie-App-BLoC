import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginRequest extends AuthEvent {
  final String email;
  final String password;

  LoginRequest(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class RegisterRequest extends AuthEvent {
  final String email;
  final String password;
  final String fullName;
  final String phoneNumber;

  RegisterRequest(this.email, this.password, this.fullName, this.phoneNumber);

  @override
  List<Object?> get props => [email, password, fullName, phoneNumber];
}

class LogoutRequest extends AuthEvent {}

class AppStarted extends AuthEvent {}
