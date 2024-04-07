part of 'event_fetcher_bloc.dart';

sealed class EventFetcherEvent extends Equatable {
  const EventFetcherEvent();

  @override
  List<Object> get props => [];
}

class _FetchEventCategories extends EventFetcherEvent {}

class _FetchAllEvents extends EventFetcherEvent {
  const _FetchAllEvents();
}
