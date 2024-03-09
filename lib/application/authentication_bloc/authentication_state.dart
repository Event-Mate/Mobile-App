part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  UserData get userData;

  @override
  List<Object> get props => [userData];
}

class AuthInitialState extends AuthenticationState {
  const AuthInitialState();

  @override
  UserData get userData =>
      throw StateError('$runtimeType does not have userData.');
}

class AuthLoggedOutState extends AuthenticationState {
  const AuthLoggedOutState();

  @override
  UserData get userData =>
      throw StateError('$runtimeType does not have userData.');
}

class AuthLoggedInState extends AuthenticationState {
  const AuthLoggedInState({required this.userData});

  @override
  final UserData userData;

  @override
  List<Object> get props => [userData];
}
