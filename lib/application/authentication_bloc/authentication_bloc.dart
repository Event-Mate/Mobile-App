import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
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
    on<AuthenticationEvent>(
      (event, emit) async {
        if (event is _CheckLoginStatusEvent) {
          await _onCheckLoginStatus(event, emit);
        } else if (event is _AuthLogoutEvent) {
          await _onAuthLogout(event, emit);
        }
      },
      transformer: sequential(),
    );
  }

  final ICacheController _iCacheController;
  final IUserDataStorage _iUserDataStorage;

  void addCheckLoginStatus() {
    add(_CheckLoginStatusEvent());
  }

  void addLogout() {
    add(_AuthLogoutEvent());
  }

  Future<void> _onCheckLoginStatus(
    _CheckLoginStatusEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    final uid = _iCacheController.readString(key: CacheKey.UID);
    if (uid != null) {
      emit(AuthLoggedInState());
    } else {
      emit(AuthLoggedOutState());
    }
  }

  Future<void> _onAuthLogout(
    _AuthLogoutEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    await _deleteSessionInfo();
    emit(AuthLoggedOutState());
  }

  Future<void> _deleteSessionInfo() async {
    final uid = _iCacheController.readString(key: CacheKey.UID);
    assert(uid != null, 'uid must not be null! ');

    await Future.wait([
      _iUserDataStorage.delete(uniqueId: uid!),
      _iCacheController.delete(key: CacheKey.UID),
      _iCacheController.delete(key: CacheKey.ACCESS_TOKEN),
    ]);
  }
}
