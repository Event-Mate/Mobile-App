import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'avatar_edit_event.dart';
part 'avatar_edit_state.dart';

class AvatarEditBloc extends Bloc<AvatarEditEvent, AvatarEditState> {
  AvatarEditBloc() : super(AvatarEditState.initial()) {
    on<_AvatarUpdatedEvent>(
      _onAvatarUpdatedEvent,
    );
  }

  void addAvatarUpdated({required File avatarFile}) {
    add(_AvatarUpdatedEvent(avatarFile: avatarFile));
  }

  FutureOr<void> _onAvatarUpdatedEvent(
    _AvatarUpdatedEvent event,
    Emitter<AvatarEditState> emit,
  ) {
    emit(state.copyWith(avatarOption: some(event.avatarFile)));
  }
}
