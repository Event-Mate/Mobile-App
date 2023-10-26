part of 'registration_bloc.dart';

sealed class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class EmailRegisterEvent extends RegistrationEvent {
  const EmailRegisterEvent({required this.user});
  final UserInformation user;
  @override
  List<Object> get props => [user];
}
