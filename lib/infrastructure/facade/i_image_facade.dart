import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:event_mate/failure/facade/image_facade_failure.dart';
import 'package:image_picker/image_picker.dart';

abstract class IImageFacade {
  Future<Either<ImageFacadeFailure, File>> pickImage({
    ImageSource source = ImageSource.gallery,
  });
}
