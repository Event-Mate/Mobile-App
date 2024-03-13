// ignore_for_file: unused_result

part of 'interests_edit_bloc.dart';

final class InterestsEditState extends Equatable {
  const InterestsEditState({
    required this.failureOrInterestListOption,
    required this.selectedInterests,
    required this.errorOption,
    required this.validating,
  });

  factory InterestsEditState.initial() {
    return InterestsEditState(
      failureOrInterestListOption: none(),
      selectedInterests: emptyList(),
      errorOption: none(),
      validating: false,
    );
  }

  InterestsEditState copyWith({
    Option<Either<CustomFailure, KtList<InterestCategoryData>>>?
        failureOrInterestListOption,
    KtList<InterestCategoryData>? selectedInterests,
    Option<String?>? errorOption,
    bool? validating,
  }) {
    return InterestsEditState(
      failureOrInterestListOption:
          failureOrInterestListOption ?? this.failureOrInterestListOption,
      selectedInterests: selectedInterests ?? this.selectedInterests,
      errorOption: errorOption ?? this.errorOption,
      validating: validating ?? this.validating,
    );
  }

  final Option<Either<CustomFailure, KtList<InterestCategoryData>>>
      failureOrInterestListOption;
  final KtList<InterestCategoryData> selectedInterests;
  final Option<String?> errorOption;
  final bool validating;

  bool get isFormValid => errorOption.fold(
        () {
          return false;
        },
        (errorMessage) {
          if (errorMessage == null) {
            return true;
          } else {
            return false;
          }
        },
      );

  KtList<InterestCategoryData> get eventCategoriesOrEmptyList {
    return failureOrInterestListOption.fold(
      emptyList,
      (failureOrInterestList) => failureOrInterestList.getOrElse(emptyList),
    );
  }

  @override
  List<Object?> get props => [
        failureOrInterestListOption,
        selectedInterests,
        errorOption,
        validating,
      ];
}
