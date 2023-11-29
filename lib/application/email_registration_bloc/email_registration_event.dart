part of 'email_registration_bloc.dart';

sealed class EmailRegistrationEvent extends Equatable {
  const EmailRegistrationEvent();

  @override
  List<Object> get props => [];
}

class _NavigatedToPreviousStep extends EmailRegistrationEvent {
  const _NavigatedToPreviousStep();
}

class _NavigatedToNextStep extends EmailRegistrationEvent {
  const _NavigatedToNextStep({required this.userData});
  final UserData userData;

  @override
  List<Object> get props => [userData];
}

class _RegistrationCompletedEvent extends EmailRegistrationEvent {
  const _RegistrationCompletedEvent({required this.userData});
  final UserData userData;
  @override
  List<Object> get props => [userData];
}
