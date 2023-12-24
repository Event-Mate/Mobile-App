part of 'username_edit_bloc.dart';

sealed class UsernameEditEvent extends Equatable {
  const UsernameEditEvent();
  @override
  List<Object?> get props => [];
}

class _UsernameUpdatedEvent extends UsernameEditEvent {
  const _UsernameUpdatedEvent({required this.username});

  final String username;

  @override
  List<Object> get props => [username];
}

class _UsernameValidateEvent extends UsernameEditEvent {
  const _UsernameValidateEvent();
}
