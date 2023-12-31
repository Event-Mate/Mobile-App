import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_mate/failure/repository/event_repository_failure.dart';
import 'package:event_mate/infrastructure/repository/event_repository/i_event_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/kt.dart';

part 'event_fetcher_event.dart';
part 'event_fetcher_state.dart';

class EventFetcherBloc extends Bloc<EventFetcherEvent, EventFetcherState> {
  EventFetcherBloc(this._iEventRepository)
      : super(EventFetcherState.initial()) {
    on<_FetchEventCategories>(
      _onFetchEventCategories,
    );
  }

  final IEventRepository _iEventRepository;

  void addFetch() {
    add(_FetchEventCategories());
  }

  Future<void> _onFetchEventCategories(
    EventFetcherEvent event,
    Emitter<EventFetcherState> emit,
  ) async {
    final failureOrCategories = await _iEventRepository.getCategories();
    emit(state.copyWith(failureOrCategoriesOption: some(failureOrCategories)));
  }
}
