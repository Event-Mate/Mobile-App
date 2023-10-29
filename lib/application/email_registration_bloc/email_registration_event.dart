part of 'email_registration_bloc.dart';

sealed class EmailRegistrationEvent extends Equatable {
  const EmailRegistrationEvent();

  @override
  List<Object> get props => [];
}

class _InitEvent extends EmailRegistrationEvent {
  const _InitEvent();
}

class _NameUpdatedEvent extends EmailRegistrationEvent {
  const _NameUpdatedEvent({required this.name});

  final String name;
  @override
  List<Object> get props => [name];
}

class _NavigatedToPreviousStep extends EmailRegistrationEvent {
  const _NavigatedToPreviousStep();
}

class _NavigatedToNextStep extends EmailRegistrationEvent {
  const _NavigatedToNextStep();
}

class _RegisterCompletedEvent extends EmailRegistrationEvent {
  const _RegisterCompletedEvent({required this.user});
  final UserInformation user;
  @override
  List<Object> get props => [user];
}
