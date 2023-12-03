import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_mate/infrastructure/repository/i_registration_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'username_edit_event.dart';
part 'username_edit_state.dart';

class UsernameEditBloc extends Bloc<UsernameEditEvent, UsernameEditState> {
  UsernameEditBloc(
    this._iRegistrationRepository,
  ) : super(UsernameEditState.initial()) {
    on<_UsernameUpdatedEvent>(
      _onUsernameUpdatedEvent,
    );
    on<_UsernameValidateEvent>(
      _onUsernameValidateEvent,
    );
  }

  final IRegistrationRepository _iRegistrationRepository;

  void addUsernameUpdated({required String username}) {
    add(_UsernameUpdatedEvent(username: username));
  }

  void addUsernameValidate() {
    add(const _UsernameValidateEvent());
  }

  FutureOr<void> _onUsernameUpdatedEvent(
    _UsernameUpdatedEvent event,
    Emitter<UsernameEditState> emit,
  ) {
    emit(state.copyWith(usernameOption: some(event.username)));
  }

  // TODO(Furkan): Profil ayarlarını yapacağımız zaman bu ve diğer edit bloclarda bir de save eventi koyalım  repository'i ve storage'i güncelleyelim.
  // TODO(Furkan): Aynı zamanda bir init eventi de ekleyelim ve state'i storage'dan okuyup dolduralım.

  Future<void> _onUsernameValidateEvent(
    _UsernameValidateEvent event,
    Emitter<UsernameEditState> emit,
  ) async {
    emit(state.copyWith(validating: true));

    final failureOrUnit = await _iRegistrationRepository.validateUsername(
      username: state.usernameOrEmpty,
    );

    emit(
      state.copyWith(
        validating: false,
        errorOption: state.usernameOption.fold(
          () => some('registration.username_empty_error_message'),
          (username) {
            final hasWhiteSpace = RegExp(r'\s').hasMatch(username.trim());
            if (username.trim().isEmpty) {
              return some('registration.username_empty_error_message');
            } else if (username.trim().length < 2) {
              return some('registration.username_length_error_message');
            } else if (hasWhiteSpace) {
              return some('registration.username_whitespace_error_message');
            } else if (failureOrUnit.isLeft()) {
              return some('registration.username_already_exists_error_message');
            }
            return some(null);
          },
        ),
      ),
    );
  }
}
