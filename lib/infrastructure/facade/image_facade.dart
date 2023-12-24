import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:event_mate/failure/facade/image_facade_failure.dart';
import 'package:event_mate/infrastructure/facade/i_image_facade.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImageFacade implements IImageFacade {
  ImageFacade(this._imagePicker);

  final ImagePicker _imagePicker;

  @override
  Future<Either<ImageFacadeFailure, File>> pickImage({
    ImageSource source = ImageSource.gallery,
  }) async {
    try {
      final image = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        return right(File(image.path));
      } else {
        return left(ImagePickerUnknownFailure("Image is null"));
      }
    } on PlatformException catch (e) {
      return left(ImagePickerPermissionFailure(e.message));
    }
  }
}
