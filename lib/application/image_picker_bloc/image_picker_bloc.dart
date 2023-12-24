import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_mate/failure/facade/image_facade_failure.dart';
import 'package:event_mate/infrastructure/facade/i_image_facade.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  ImagePickerBloc(this._iImageFacade) : super(ImagePickerState.initial()) {
    on<_PickImageFromGalleryEvent>(
      _onPickImageFromGalleryEvent,
    );
  }

  final IImageFacade _iImageFacade;

  void addPickImageFromGallery() {
    add(const _PickImageFromGalleryEvent());
  }

  Future<void> _onPickImageFromGalleryEvent(
    _PickImageFromGalleryEvent event,
    Emitter<ImagePickerState> emit,
  ) async {
    emit(state.copyWith(
      failureOrImageOption: none(),
      uploading: true,
    ));

    final failureOrImgFile = await _iImageFacade.pickImage();

    emit(state.copyWith(
      failureOrImageOption: some(failureOrImgFile),
      uploading: false,
    ));
  }
}
