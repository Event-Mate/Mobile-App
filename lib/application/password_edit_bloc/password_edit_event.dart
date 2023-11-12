part of 'password_edit_bloc.dart';

sealed class PasswordEditEvent extends Equatable {
  const PasswordEditEvent();

  @override
  List<Object> get props => [];
}

class _PasswordUpdatedEvent extends PasswordEditEvent {
  const _PasswordUpdatedEvent({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class _PasswordValidatedEvent extends PasswordEditEvent {
  const _PasswordValidatedEvent();
}

class _PasswordVisibilityToggled extends PasswordEditEvent {
  const _PasswordVisibilityToggled();
}
