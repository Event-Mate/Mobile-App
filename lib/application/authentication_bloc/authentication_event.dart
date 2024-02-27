part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class _CheckLoginStatusEvent extends AuthenticationEvent {}

class _AuthLogoutEvent extends AuthenticationEvent {}
