import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'password_edit_event.dart';
part 'password_edit_state.dart';

class PasswordEditBloc extends Bloc<PasswordEditEvent, PasswordEditState> {
  PasswordEditBloc() : super(PasswordEditState.initial()) {
    on<_PasswordUpdatedEvent>(
      _onPasswordUpdatedEvent,
    );
    on<_PasswordVisibilityToggled>(
      _onPasswordVisibilityToggled,
    );
    on<_PasswordValidatedEvent>(
      _onPasswordValidatedEvent,
      transformer: sequential(),
    );
  }

  void addPasswordUpdated({required String password}) {
    add(_PasswordUpdatedEvent(password: password));
  }

  void addPasswordVisibilityToggled() {
    add(const _PasswordVisibilityToggled());
  }

  void addPasswordValidate() {
    add(const _PasswordValidatedEvent());
  }

  FutureOr<void> _onPasswordUpdatedEvent(
    _PasswordUpdatedEvent event,
    Emitter<PasswordEditState> emit,
  ) {
    emit(state.copyWith(passwordOption: some(event.password)));
  }

  FutureOr<void> _onPasswordValidatedEvent(
    _PasswordValidatedEvent event,
    Emitter<PasswordEditState> emit,
  ) {
    emit(state.copyWith(validating: true));
    emit(
      state.copyWith(
        validating: false,
        errorOption: state.passwordOption.fold(
          () => some('registration.password_empty_error_message'),
          (password) {
            if (password.trim().isEmpty) {
              return some('registration.password_empty_error_message');
            } else if (password.trim().length < 6) {
              return some('registration.password_length_error_message');
            }
            return some(null);
          },
        ),
      ),
    );
  }

  FutureOr<void> _onPasswordVisibilityToggled(
    _PasswordVisibilityToggled event,
    Emitter<PasswordEditState> emit,
  ) {
    emit(state.copyWith(hidePassword: !state.hidePassword));
  }
}
