import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_mate/failure/core/custom_failure.dart';

import 'package:event_mate/infrastructure/controller/cache_controller/cache_key.dart';
import 'package:event_mate/infrastructure/controller/cache_controller/i_cache_controller.dart';
import 'package:event_mate/infrastructure/storage/user_data_storage/i_user_data_storage.dart';
import 'package:event_mate/model/user_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'my_profile_event.dart';
part 'my_profile_state.dart';

class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileState> {
  MyProfileBloc(this._iUserDataStorage, this._iCacheController)
      : super(MyProfileState.initial()) {
    on<_MyProfileFetchEvent>(
      _onMyProfileFetcherFetchEvent,
    );
  }

  final IUserDataStorage _iUserDataStorage;
  final ICacheController _iCacheController;

  void addFetch() {
    add(const _MyProfileFetchEvent());
  }

  Future<void> _onMyProfileFetcherFetchEvent(
    _MyProfileFetchEvent event,
    Emitter<MyProfileState> emit,
  ) async {
    emit(state.copyWith(userDataOption: none()));
    final uniqueId = _iCacheController.readString(key: CacheKey.UID)!;
    final failureOrUserData = await _iUserDataStorage.get(uniqueId: uniqueId);
    emit(state.copyWith(userDataOption: some(failureOrUserData)));
  }
}
