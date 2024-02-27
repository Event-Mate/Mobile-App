part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthenticationState {}

class AuthLoggedInState extends AuthenticationState {}

class AuthLoggedOutState extends AuthenticationState {}
