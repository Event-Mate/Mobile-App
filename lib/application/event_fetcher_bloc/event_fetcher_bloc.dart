import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_mate/failure/repository/event_repository_failure.dart';
import 'package:event_mate/infrastructure/repository/event_repository/i_event_repository.dart';
import 'package:event_mate/model/event_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/kt.dart';

part 'event_fetcher_event.dart';
part 'event_fetcher_state.dart';

class EventFetcherBloc extends Bloc<EventFetcherEvent, EventFetcherState> {
  EventFetcherBloc(this._iEventRepository)
      : super(EventFetcherState.initial()) {
    on<EventFetcherEvent>(
      (event, emit) async {
        if (event is _FetchEventCategories) {
          await _onFetchEventCategories(event, emit);
        } else if (event is _FetchAllEvents) {
          await _onFetchAllEvents(event, emit);
        }
      },
      transformer: sequential(),
    );
  }

  final IEventRepository _iEventRepository;

  void addFetchAllEvents() {
    add(const _FetchAllEvents());
  }

  void addFetchCategories() {
    add(_FetchEventCategories());
  }

  Future<void> _onFetchEventCategories(
    EventFetcherEvent event,
    Emitter<EventFetcherState> emit,
  ) async {
    final failureOrCategories = await _iEventRepository.getCategories();
    emit(state.copyWith(failureOrCategoriesOption: some(failureOrCategories)));
  }

  Future<void> _onFetchAllEvents(
    _FetchAllEvents event,
    Emitter<EventFetcherState> emit,
  ) async {
    emit(state.copyWith(failureOrEventsOption: none(), isFetching: true));
    final failureOrEvents = await _iEventRepository.getAllEvents();
    emit(state.copyWith(
      failureOrEventsOption: some(failureOrEvents),
      isFetching: false,
    ));
  }
}
