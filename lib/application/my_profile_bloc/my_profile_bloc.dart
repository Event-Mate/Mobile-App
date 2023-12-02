import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_mate/failure/storage/user_information_storage_failure.dart';
import 'package:event_mate/infrastructure/storage/user_information_storage/i_user_information_storage.dart';
import 'package:event_mate/model/registration_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'my_profile_event.dart';
part 'my_profile_state.dart';

class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileState> {
  MyProfileBloc(this._iUserInformationStorage)
      : super(MyProfileState.initial()) {
    on<_MyProfileFetchEvent>(
      _onMyProfileFetcherFetchEvent,
    );
  }

  final IUserInformationStorage _iUserInformationStorage;

  void addFetch() {
    add(const _MyProfileFetchEvent());
  }

  Future<void> _onMyProfileFetcherFetchEvent(
    _MyProfileFetchEvent event,
    Emitter<MyProfileState> emit,
  ) async {
    final failureOrUserInfo = await _iUserInformationStorage.get();
    emit(state.copyWith(userInformationOption: some(failureOrUserInfo)));
  }
}
