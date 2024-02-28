import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:event_mate/infrastructure/controller/cache_controller/cache_key.dart';
import 'package:event_mate/infrastructure/controller/cache_controller/i_cache_controller.dart';
import 'package:event_mate/infrastructure/storage/user_data_storage/i_user_data_storage.dart';
import 'package:event_mate/model/user_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(
    this._iCacheController,
    this._iUserDataStorage,
  ) : super(const AuthInitialState()) {
    on<AuthenticationEvent>(
      (event, emit) async {
        if (event is _UpdateLoginStatusEvent) {
          await _onUpdateLoginStatus(event, emit);
        } else if (event is _AuthLogoutEvent) {
          await _onAuthLogout(event, emit);
        }
      },
      transformer: sequential(),
    );
  }

  final ICacheController _iCacheController;
  final IUserDataStorage _iUserDataStorage;

  void addUpdateLoginStatus() {
    add(_UpdateLoginStatusEvent());
  }

  void addLogout() {
    add(_AuthLogoutEvent());
  }

  Future<void> _onUpdateLoginStatus(
    _UpdateLoginStatusEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    final uid = _iCacheController.readString(key: CacheKey.UID);
    if (uid != null) {
      final userDataOrFailure = await _iUserDataStorage.get(uniqueId: uid);
      userDataOrFailure.fold(
        (_) => emit(const AuthLoggedOutState()),
        (userData) => emit(AuthLoggedInState(userData: userData)),
      );
    } else {
      emit(const AuthLoggedOutState());
    }
  }

  Future<void> _onAuthLogout(
    _AuthLogoutEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    await _deleteSessionInfo();
    emit(const AuthLoggedOutState());
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
