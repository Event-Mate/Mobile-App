import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'email_edit_event.dart';
part 'email_edit_state.dart';

class EmailEditBloc extends Bloc<EmailEditEvent, EmailEditState> {
  EmailEditBloc() : super(EmailEditState.initial()) {
    on<_EmailUpdatedEvent>(
      _onEmailUpdatedEvent,
    );
    on<_EmailValidatedEvent>(
      _onEmailValidatedEvent,
      transformer: sequential(),
    );
  }

  void addEmailUpdated({required String email}) {
    add(_EmailUpdatedEvent(email: email));
  }

  void addEmailValidate() {
    add(const _EmailValidatedEvent());
  }

  FutureOr<void> _onEmailUpdatedEvent(
    _EmailUpdatedEvent event,
    Emitter<EmailEditState> emit,
  ) {
    emit(state.copyWith(emailOption: some(event.email)));
  }

  FutureOr<void> _onEmailValidatedEvent(
    _EmailValidatedEvent event,
    Emitter<EmailEditState> emit,
  ) {
    emit(state.copyWith(validating: true));

    final regex = RegExp(
      r'^(?:[A-Za-z0-9_-]+(?:\.[A-Za-z0-9_-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?!yok\.com$)((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    );

    final newErrorOption = state.emailOption.fold(
      () {
        return some('registration.email_empty_error_message');
      },
      (email) {
        if (email.trim().isEmpty) {
          return some('registration.email_empty_error_message');
        } else if (!regex.hasMatch(email)) {
          return some('registration.email_invalid_error_message');
        } else {
          // TODO(Furkan): Check if email is already taken, if not return null.
          return some(null);
        }
      },
    );

    emit(state.copyWith(errorOption: newErrorOption, validating: false));
  }
}
