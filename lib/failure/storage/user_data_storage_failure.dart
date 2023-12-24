import 'package:equatable/equatable.dart';
import 'package:event_mate/failure/core/custom_failure.dart';

abstract class UserDataStorageFailure extends Equatable
    implements CustomFailure {
  const UserDataStorageFailure();

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class UserDataStorageNotFoundFailure extends UserDataStorageFailure {
  const UserDataStorageNotFoundFailure();
}

class UserDataStorageUnknownFailure extends UserDataStorageFailure
    implements UnknownCustomFailure {
  const UserDataStorageUnknownFailure(this._message);
  final String? _message;
  @override
  String toString() {
    return "UserDataStorageUnknownFailure(); Exception message was: $message";
  }

  @override
  List<Object?> get props => [_message];

  @override
  String? get message => _message;
}
