import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'username_edit_event.dart';
part 'username_edit_state.dart';

class UsernameEditBloc extends Bloc<UsernameEditEvent, UsernameEditState> {
  UsernameEditBloc() : super(UsernameEditState.initial()) {
    on<_UsernameUpdatedEvent>(
      _onUsernameUpdatedEvent,
    );
    on<_UsernameValidateEvent>(
      _onUsernameValidateEvent,
    );
  }

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

  FutureOr<void> _onUsernameValidateEvent(
    _UsernameValidateEvent event,
    Emitter<UsernameEditState> emit,
  ) {
    emit(state.copyWith(validating: true));
    //* backend username exist doğrulaması ona göre aşağıya yeni hata stringi eklenecek
    emit(
      state.copyWith(
        validating: false,
        errorOption: state.usernameOption.fold(
          () => some('registration.username_empty_error_message'),
          (username) {
            if (username.trim().isEmpty) {
              return some('registration.username_empty_error_message');
            } else if (username.trim().length < 2) {
              return some('registration.username_length_error_message');
            }
            return some(null);
          },
        ),
      ),
    );
  }
}
