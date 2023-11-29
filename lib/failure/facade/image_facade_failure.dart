import 'package:equatable/equatable.dart';
import 'package:event_mate/failure/core/custom_failure.dart';

sealed class ImageFacadeFailure extends Equatable implements CustomFailure {}

class ImagePickerPermissionFailure extends ImageFacadeFailure {
  ImagePickerPermissionFailure(this._message);
  final String? _message;

  @override
  List<Object?> get props => [_message];

  @override
  String toString() {
    return "ImagePickerPermissionFailure(); Exception message was: $_message";
  }
}

class ImagePickerUnknownFailure extends ImageFacadeFailure {
  ImagePickerUnknownFailure(this._message);
  final String? _message;

  @override
  List<Object?> get props => [_message];

  @override
  String toString() {
    return "ImagePickerUnknownFailure(); Exception message was: $_message";
  }
}
