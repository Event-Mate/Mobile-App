part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthInitialState extends AuthenticationState {}

final class AuthLoggedInState extends AuthenticationState {}

final class AuthLoggedOutState extends AuthenticationState {}
