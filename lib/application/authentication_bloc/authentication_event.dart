part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class _CheckLoginStatusEvent extends AuthenticationEvent {}

class _LogoutEvent extends AuthenticationEvent {}
