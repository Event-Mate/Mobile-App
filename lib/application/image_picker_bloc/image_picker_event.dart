part of 'image_picker_bloc.dart';

sealed class ImagePickerEvent extends Equatable {
  const ImagePickerEvent();

  @override
  List<Object> get props => [];
}

class _PickImageFromGalleryEvent extends ImagePickerEvent {
  const _PickImageFromGalleryEvent();

  @override
  List<Object> get props => [];
}
