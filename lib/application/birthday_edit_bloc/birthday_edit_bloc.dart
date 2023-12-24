import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_mate/core/enums/locale_type.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'birthday_edit_event.dart';
part 'birthday_edit_state.dart';

class BirthdayEditBloc extends Bloc<BirthdayEditEvent, BirthdayEditState> {
  BirthdayEditBloc() : super(BirthdayEditState.initial()) {
    on<_BirthdayInitEvent>(
      _onBirthdayInitEvent,
    );
    on<_BirthdayUpdatedEvent>(
      _onBirthdayUpdatedEvent,
    );
    on<_BirthdayValidatedEvent>(
      _onBirthdayValidatedEvent,
      transformer: sequential(),
    );
  }

  void addInit({required String langCode}) {
    add(_BirthdayInitEvent(langCode: langCode));
  }

  void addBirthdayUpdated({required DateTime date}) {
    add(_BirthdayUpdatedEvent(date: date));
  }

  void addBirthdayValidate() {
    add(const _BirthdayValidatedEvent());
  }

  FutureOr<void> _onBirthdayUpdatedEvent(
    _BirthdayUpdatedEvent event,
    Emitter<BirthdayEditState> emit,
  ) {
    emit(state.copyWith(birthdayOption: some(event.date)));
  }

  FutureOr<void> _onBirthdayValidatedEvent(
    _BirthdayValidatedEvent event,
    Emitter<BirthdayEditState> emit,
  ) {
    emit(state.copyWith(validating: true));
    emit(
      state.copyWith(
        validating: false,
        errorOption: state.birthdayOption.fold(
          () => some('registration.birthday_empty_error_message'),
          (_) => some(null),
        ),
      ),
    );
  }

  FutureOr<void> _onBirthdayInitEvent(
    _BirthdayInitEvent event,
    Emitter<BirthdayEditState> emit,
  ) {
    emit(state.copyWith(langCode: event.langCode));
  }
}
