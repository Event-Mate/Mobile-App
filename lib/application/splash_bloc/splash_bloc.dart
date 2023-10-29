import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:event_mate/infrastructure/controller/cache_controller/i_cache_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc(this._iCacheController) : super(SplashInitialState()) {
    on<_SplashCheckAppStateEvent>(
      _onSplashCheckAppStateEvent,
    );
  }
  // ignore: unused_field
  final ICacheController _iCacheController;

  void addCheckAppState() {
    add(const _SplashCheckAppStateEvent());
  }

  Future<void> _onSplashCheckAppStateEvent(
    _SplashCheckAppStateEvent event,
    Emitter<SplashState> emit,
  ) async {
    emit(SplashLoadingState());

    //* Burada app'i yayına aldıktan sonra, update var mı vs. kontrolu sağlanacak şimdilik temsili bir delay koyuyoruz.
    log('SplashLoadingState active...', name: 'SplashBloc');
    await Future.delayed(const Duration(seconds: 2));

    emit(SplashLoadedState());
    log('SplashLoadedState', name: 'SplashBloc');
  }
}
