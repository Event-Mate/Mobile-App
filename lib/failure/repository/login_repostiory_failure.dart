import 'package:equatable/equatable.dart';
import 'package:event_mate/failure/core/custom_failure.dart';

abstract class LoginRepositoryFailure extends Equatable
    implements CustomFailure {
  const LoginRepositoryFailure();
}

class LoginUserNotExistFailure extends LoginRepositoryFailure {
  const LoginUserNotExistFailure(this._message);
  final String? _message;

  @override
  List<Object?> get props => [_message];

  @override
  String toString() {
    return "LoginUserNotExistFailure(); Exception message was: $_message";
  }
}

class LoginInvalidCredentialsFailure extends LoginRepositoryFailure {
  const LoginInvalidCredentialsFailure(this._message);
  final String? _message;

  @override
  List<Object?> get props => [_message];

  @override
  String toString() {
    return "LoginUserInvalidCredentialsFailure(); Exception message was: $_message";
  }
}

class LoginUnknownFailure extends LoginRepositoryFailure
    implements UnknownCustomFailure {
  const LoginUnknownFailure(this._message);
  final String? _message;

  @override
  List<Object?> get props => [_message];

  @override
  String? get message => _message;

  @override
  String toString() {
    return "LoginUnknownFailure(); Exception message was: $message";
  }
}
