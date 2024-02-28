part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthenticationState {
  const AuthInitialState();
}

class AuthLoggedOutState extends AuthenticationState {
  const AuthLoggedOutState();
}

class AuthLoggedInState extends AuthenticationState {
  const AuthLoggedInState({required this.userData});
  final UserData userData;

  @override
  List<Object> get props => [userData];
}
