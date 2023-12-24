part of 'email_login_bloc.dart';

sealed class EmailLoginEvent extends Equatable {
  const EmailLoginEvent();

  @override
  List<Object> get props => [];
}

class EmailLoginFormSentEvent extends EmailLoginEvent {
  const EmailLoginFormSentEvent({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}
