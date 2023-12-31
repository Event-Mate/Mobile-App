part of 'event_fetcher_bloc.dart';

final class EventFetcherState extends Equatable {
  const EventFetcherState({
    required this.failureOrCategoriesOption,
  });

  factory EventFetcherState.initial() {
    return EventFetcherState(
      failureOrCategoriesOption: none(),
    );
  }

  EventFetcherState copyWith({
    Option<Either<EventRepositoryFailure, KtList<String>>>?
        failureOrCategoriesOption,
  }) {
    return EventFetcherState(
      failureOrCategoriesOption:
          failureOrCategoriesOption ?? this.failureOrCategoriesOption,
    );
  }

  final Option<Either<EventRepositoryFailure, KtList<String>>>
      failureOrCategoriesOption;

  KtList<String> get categoriesOrEmpty => failureOrCategoriesOption.fold(
        emptyList,
        (failureOrCategories) => failureOrCategories.fold(
          (failure) => emptyList(),
          (categories) => categories,
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
  List<Object> get props => [failureOrCategoriesOption];
}
