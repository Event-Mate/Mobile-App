import 'package:equatable/equatable.dart';
import 'package:event_mate/failure/core/custom_failure.dart';

abstract class UserInformationStorageFailure extends Equatable
    implements CustomFailure {
  const UserInformationStorageFailure();

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class UserInformationStorageNotFoundFailure
    extends UserInformationStorageFailure {
  const UserInformationStorageNotFoundFailure();
}

class UserInformationStorageUnknownFailure extends UserInformationStorageFailure
    implements UnknownCustomFailure {
  const UserInformationStorageUnknownFailure(this._message);
  final String? _message;
  @override
  String toString() {
    return "UserInformationStorageUnknownFailure(); Exception message was: $message";
  }

  @override
  List<Object?> get props => [_message];

  @override
  String? get message => _message;
}
