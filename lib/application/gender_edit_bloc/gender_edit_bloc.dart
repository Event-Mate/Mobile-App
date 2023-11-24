import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_mate/core/enums/gender_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'gender_edit_event.dart';
part 'gender_edit_state.dart';

class GenderEditBloc extends Bloc<GenderEditEvent, GenderEditState> {
  GenderEditBloc() : super(GenderEditState.initial()) {
    on<_GenderUpdatedEvent>(
      _onGenderUpdatedEvent,
    );
    on<_GenderValidatedEvent>(
      _onGenderValidatedEvent,
    );
  }

  void addGenderUpdated({required GenderType gender}) {
    add(_GenderUpdatedEvent(gender: gender));
  }

  void addGenderValidated() {
    add(const _GenderValidatedEvent());
  }

  FutureOr<void> _onGenderUpdatedEvent(
    _GenderUpdatedEvent event,
    Emitter<GenderEditState> emit,
  ) {
    emit(state.copyWith(genderOption: some(event.gender)));
  }

  FutureOr<void> _onGenderValidatedEvent(
    _GenderValidatedEvent event,
    Emitter<GenderEditState> emit,
  ) {
    emit(state.copyWith(validating: true));
    emit(state.copyWith(
      validating: false,
      errorOption: state.genderOption.fold(
        () {
          return some('registration.gender_empty_error_message');
        },
        (_) {
          return some(null);
        },
      ),
    ));
  }
}
