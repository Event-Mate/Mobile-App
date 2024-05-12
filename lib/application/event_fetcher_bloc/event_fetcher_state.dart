// ignore_for_file: unused_result

part of 'event_fetcher_bloc.dart';

final class EventFetcherState extends Equatable {
  const EventFetcherState({
    required this.failureOrEventsOption,
    required this.failureOrCategoriesOption,
    required this.fetchingEvents,
    required this.fetchingCategories,
  });

  factory EventFetcherState.initial() {
    return EventFetcherState(
      failureOrEventsOption: none(),
      failureOrCategoriesOption: none(),
      fetchingEvents: false,
      fetchingCategories: false,
    );
  }

  EventFetcherState copyWith({
    Option<Either<CustomFailure, KtList<EventData>>>? failureOrEventsOption,
    Option<Either<CustomFailure, KtList<String>>>? failureOrCategoriesOption,
    bool? fetchingEvents,
    bool? fetchingCategories,
  }) {
    return EventFetcherState(
      failureOrEventsOption:
          failureOrEventsOption ?? this.failureOrEventsOption,
      failureOrCategoriesOption:
          failureOrCategoriesOption ?? this.failureOrCategoriesOption,
      fetchingEvents: fetchingEvents ?? this.fetchingEvents,
      fetchingCategories: fetchingCategories ?? this.fetchingCategories,
    );
  }

  final Option<Either<CustomFailure, KtList<EventData>>> failureOrEventsOption;
  final Option<Either<CustomFailure, KtList<String>>> failureOrCategoriesOption;
  final bool fetchingEvents;
  final bool fetchingCategories;

  KtList<String> get categoriesOrEmptyList => failureOrCategoriesOption.fold(
        emptyList,
        (failureOrCategories) => failureOrCategories.fold(
          (failure) => emptyList(),
          (categories) => categories,
        ),
      );

  KtList<EventData> get eventsOrEmptyList => failureOrEventsOption.fold(
        emptyList,
        (failureOrEvents) => failureOrEvents.fold(
          (failure) => emptyList(),
          (events) => events,
        ),
      );

  IconData getIconForCategory(String category) {
    switch (category) {
      case 'Stand Up':
        return Icons.accessibility_new_rounded;
      case 'Concert':
        return Icons.mic_external_on_rounded;
      case 'Sports':
        return Icons.sports_basketball;
      case 'Festival':
        return Icons.festival_outlined;
      case 'Theater':
        return Icons.theater_comedy;
      case 'Conference':
        return Icons.school;
      default:
        return Icons.error;
    }
  }

  @override
  List<Object> get props => [
        failureOrEventsOption,
        failureOrCategoriesOption,
        fetchingEvents,
        fetchingCategories,
      ];
}
