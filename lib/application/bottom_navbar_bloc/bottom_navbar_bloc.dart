import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_navbar_event.dart';
part 'bottom_navbar_state.dart';

class BottomNavbarBloc extends Bloc<BottomNavbarEvent, BottomNavbarState> {
  BottomNavbarBloc() : super(const BottomNavbarHomePageState()) {
    on<_UpdateIndexBottomNavbarEvent>(
      _onUpdateIndexBottomNavbarEvent,
      transformer: droppable(),
    );
  }

  void addUpdateIndex(int index) {
    add(_UpdateIndexBottomNavbarEvent(index: index));
  }

  Future<void> _onUpdateIndexBottomNavbarEvent(
    _UpdateIndexBottomNavbarEvent event,
    Emitter<BottomNavbarState> emit,
  ) async {
    assert(
      event.index >= 0 && event.index < state.indexStateMap.length,
      'Invalid bottom navbar index: ${event.index}',
    );

    final newState =
        state.indexStateMap[event.index] ?? const BottomNavbarHomePageState();

    emit(newState);
  }
}
