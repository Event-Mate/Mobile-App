part of 'birthday_edit_bloc.dart';

sealed class BirthdayEditEvent extends Equatable {
  const BirthdayEditEvent();

  @override
  List<Object> get props => [];
}

class _BirthdayInitEvent extends BirthdayEditEvent {
  const _BirthdayInitEvent({required this.langCode});
  final String langCode;
}

class _BirthdayUpdatedEvent extends BirthdayEditEvent {
  const _BirthdayUpdatedEvent({required this.date});

  final DateTime date;

  @override
  List<Object> get props => [date];
}

class _BirthdayValidatedEvent extends BirthdayEditEvent {
  const _BirthdayValidatedEvent();
}
