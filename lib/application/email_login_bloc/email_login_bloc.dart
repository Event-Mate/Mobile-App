import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_mate/failure/repository/login_repository_failure.dart';
import 'package:event_mate/infrastructure/controller/cache_controller/cache_key.dart';
import 'package:event_mate/infrastructure/controller/cache_controller/i_cache_controller.dart';
import 'package:event_mate/infrastructure/repository/login_repository/i_login_repository.dart';
import 'package:event_mate/infrastructure/storage/user_data_storage/i_user_data_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'email_login_event.dart';
part 'email_login_state.dart';

class EmailLoginBloc extends Bloc<EmailLoginEvent, EmailLoginState> {
  EmailLoginBloc(
    this._iLoginRepository,
    this._iCacheController,
    this._iUserDataStorage,
  ) : super(EmailLoginState.initial()) {
    on<EmailLoginFormSentEvent>(
      _onEmailLoginFormSentEvent,
    );
  }

  final ILoginRepository _iLoginRepository;
  final ICacheController _iCacheController;
  final IUserDataStorage _iUserDataStorage;

  Future<void> _onEmailLoginFormSentEvent(
    EmailLoginFormSentEvent event,
    Emitter<EmailLoginState> emit,
  ) async {
    emit(state.copyWith(failureOrUserDataWToken: none(), submitting: true));

    final email = event.email;
    final password = event.password;

    final failureOrUserDataWToken = await _iLoginRepository.loginUser(
      email: email,
      password: password,
    );

    final newState = await failureOrUserDataWToken.fold(
      (failure) async {
        return state.copyWith(
          failureOrUserDataWToken: some(left(failure)),
        );
      },
      (userDataWToken) async {
        final userData = userDataWToken.value1;
        final token = userDataWToken.value2;

        await _iCacheController.writeString(
          key: CacheKey.UID,
          value: userData.id,
        );

        await _iCacheController.writeString(
          key: CacheKey.ACCESS_TOKEN,
          value: token,
        );

        await _iUserDataStorage.put(uniqueId: userData.id, userData: userData);

        return state.copyWith(
          failureOrUserDataWToken: some(right(userDataWToken)),
        );
      },
    );

    emit(newState.copyWith(submitting: false));
  }
}
