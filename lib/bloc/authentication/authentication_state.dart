part of 'authentication_bloc.dart';

abstract class AuthenticationState {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final String token;

  const AuthenticationSuccess(this.token);
}

class AuthenticationFailure extends AuthenticationState {
  final String error;

  const AuthenticationFailure(this.error);
}
