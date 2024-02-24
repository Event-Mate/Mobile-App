import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:event_mate/infrastructure/controller/cache_controller/cache_key.dart';
import 'package:event_mate/infrastructure/controller/cache_controller/i_cache_controller.dart';
import 'package:event_mate/infrastructure/storage/user_data_storage/i_user_data_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(
    this._iCacheController,
    this._iUserDataStorage,
  ) : super(AuthInitialState()) {
    on<_CheckLoginStatus>(
      _onCheckLoginStatus,
    );
    on<_Logout>(
      _onLogout,
    );
  }

  final ICacheController _iCacheController;
  final IUserDataStorage _iUserDataStorage;

  void addCheckLoginStatus() {
    add(_CheckLoginStatus());
  }

  void addLogout() {
    add(_Logout());
  }

  Future<void> _onCheckLoginStatus(
    _CheckLoginStatus event,
    Emitter<AuthenticationState> emit,
  ) async {
    final uid = _iCacheController.readString(key: CacheKey.UID);
    if (uid != null) {
      emit(AuthLoggedInState());
    } else {
      emit(AuthLoggedOutState());
    }
  }

  Future<void> _onLogout(
    _Logout event,
    Emitter<AuthenticationState> emit,
  ) async {
    final uid = _iCacheController.readString(key: CacheKey.UID);
    assert(uid != null);

    await _iUserDataStorage.delete(uniqueId: uid!);
    await _iCacheController.clear();
    emit(AuthLoggedOutState());
  }
}
