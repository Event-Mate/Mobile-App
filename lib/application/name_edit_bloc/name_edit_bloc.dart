import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'name_edit_event.dart';
part 'name_edit_state.dart';

class NameEditBloc extends Bloc<NameEditEvent, NameEditState> {
  NameEditBloc() : super(NameEditState.initial()) {
    on<_NameUpdatedEvent>(
      _onNameUpdatedEvent,
    );
    on<_NameValidatedEvent>(
      _onNameValidatedEvent,
      transformer: sequential(),
    );
  }

  void addNameUpdated({required String name}) {
    add(_NameUpdatedEvent(name: name));
  }

  void addNameValidate() {
    add(const _NameValidatedEvent());
  }

  FutureOr<void> _onNameUpdatedEvent(
    _NameUpdatedEvent event,
    Emitter<NameEditState> emit,
  ) {
    emit(state.copyWith(nameOption: some(event.name)));
  }

  FutureOr<void> _onNameValidatedEvent(
    _NameValidatedEvent event,
    Emitter<NameEditState> emit,
  ) {
    emit(state.copyWith(validating: true));
    emit(
      state.copyWith(
        validating: false,
        errorOption: state.nameOption.fold(
          () => some('registration.name_empty_error_message'),
          (name) {
            if (name.trim().isEmpty) {
              return some('registration.name_empty_error_message');
            } else if (name.trim().length < 3) {
              return some('registration.name_length_error_message');
            }
            return some(null);
          },
        ),
      ),
    );
  }
}
