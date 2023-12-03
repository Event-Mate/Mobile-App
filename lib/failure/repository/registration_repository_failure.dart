import 'package:equatable/equatable.dart';
import 'package:event_mate/failure/core/custom_failure.dart';

abstract class RegistrationRepositoryFailure extends Equatable
    implements CustomFailure {
  const RegistrationRepositoryFailure();
}

class RegistrationUnknownFailure extends RegistrationRepositoryFailure
    implements UnknownCustomFailure {
  const RegistrationUnknownFailure(this._message);
  final String? _message;

  @override
  List<Object?> get props => [_message];

  @override
  String? get message => _message;

  @override
  String toString() {
    return "RegistrationUnknownFailure(); Exception message was: $message";
  }
}

class RegistrationUsernameAlreadyExistsFailure
    extends RegistrationRepositoryFailure {
  const RegistrationUsernameAlreadyExistsFailure(this._message);
  final String? _message;

  @override
  List<Object?> get props => [_message];

  @override
  String toString() {
    return "RegistrationUsernameAlreadyExistsFailure(); Exception message was: $_message";
  }
}
