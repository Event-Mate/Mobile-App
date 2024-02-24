part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class _CheckLoginStatus extends AuthenticationEvent {}

class _Logout extends AuthenticationEvent {}
