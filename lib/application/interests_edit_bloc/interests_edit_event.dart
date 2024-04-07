part of 'interests_edit_bloc.dart';

sealed class InterestsEditEvent extends Equatable {
  const InterestsEditEvent();

  @override
  List<Object> get props => [];
}

class _InterestsFetchCategoriesEvent extends InterestsEditEvent {
  const _InterestsFetchCategoriesEvent();
}

class _InterestToggledEvent extends InterestsEditEvent {
  const _InterestToggledEvent({required this.interest});

  final InterestCategoryData interest;

  @override
  List<Object> get props => [interest];
}

class _InterestsValidatedEvent extends InterestsEditEvent {
  const _InterestsValidatedEvent();
}
