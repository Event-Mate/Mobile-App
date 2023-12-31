import 'package:equatable/equatable.dart';
import 'package:event_mate/failure/core/custom_failure.dart';

abstract class EventRepositoryFailure extends Equatable
    implements CustomFailure {
  const EventRepositoryFailure();
}

class EventUnknownFailure extends EventRepositoryFailure
    implements UnknownCustomFailure {
  const EventUnknownFailure(this._message);
  final String? _message;

  @override
  List<Object?> get props => [_message];

  @override
  String? get message => _message;

  @override
  String toString() {
    return "EventUnknownFailure(); Exception message was: $message";
  }
}
