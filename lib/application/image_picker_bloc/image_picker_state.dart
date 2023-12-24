part of 'image_picker_bloc.dart';

final class ImagePickerState extends Equatable {
  const ImagePickerState({
    required this.failureOrImageOption,
    required this.uploading,
  });

  factory ImagePickerState.initial() {
    return ImagePickerState(
      failureOrImageOption: none(),
      uploading: false,
    );
  }

  final Option<Either<ImageFacadeFailure, File?>> failureOrImageOption;
  final bool uploading;

  ImagePickerState copyWith({
    Option<Either<ImageFacadeFailure, File?>>? failureOrImageOption,
    bool? uploading,
  }) {
    return ImagePickerState(
      failureOrImageOption: failureOrImageOption ?? this.failureOrImageOption,
      uploading: uploading ?? this.uploading,
    );
  }

  File? get imageFile => failureOrImageOption.fold(
        () => null,
        (failureOrImgFile) => failureOrImgFile.fold((f) => null, id),
      );

  @override
  List<Object> get props => [failureOrImageOption, uploading];
}
