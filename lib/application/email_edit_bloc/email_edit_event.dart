part of 'email_edit_bloc.dart';

sealed class EmailEditEvent extends Equatable {
  const EmailEditEvent();

  @override
  List<Object> get props => [];
}

class _EmailUpdatedEvent extends EmailEditEvent {
  const _EmailUpdatedEvent({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class _EmailValidatedEvent extends EmailEditEvent {
  const _EmailValidatedEvent();
}
