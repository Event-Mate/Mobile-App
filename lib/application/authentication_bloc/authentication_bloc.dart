import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:event_mate/infrastructure/controller/cache_controller/cache_key.dart';
import 'package:event_mate/infrastructure/controller/cache_controller/i_cache_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(this._iCacheController) : super(AuthInitialState()) {
    on<_CheckLoginStatus>(
      _onCheckLoginStatus,
    );
  }

  final ICacheController _iCacheController;

  void addCheckLoginStatus() {
    add(_CheckLoginStatus());
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
}
