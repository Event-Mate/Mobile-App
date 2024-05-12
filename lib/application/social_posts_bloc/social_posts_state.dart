part of 'social_posts_bloc.dart';

final class SocialPostsState extends Equatable {
  const SocialPostsState({
    required this.failureOrPostListOption,
    required this.failureOrUnitOption,
  });

  factory SocialPostsState.initial() {
    return SocialPostsState(
      failureOrPostListOption: none(),
      failureOrUnitOption: none(),
    );
  }

  final Option<Either<CustomFailure, KtList<PostData>>> failureOrPostListOption;
  final Option<Either<CustomFailure, Unit>> failureOrUnitOption;

  SocialPostsState copyWith({
    Option<Either<CustomFailure, KtList<PostData>>>? failureOrPostListOption,
    Option<Either<CustomFailure, Unit>>? failureOrUnitOption,
  }) {
    return SocialPostsState(
      failureOrPostListOption:
          failureOrPostListOption ?? this.failureOrPostListOption,
      failureOrUnitOption: failureOrUnitOption ?? this.failureOrUnitOption,
    );
  }

  KtList<PostData> get postListOrEmpty => failureOrPostListOption.fold(
        KtList.empty,
        (failureOrPostList) => failureOrPostList.fold(
          (failure) => emptyList(),
          id,
        ),
      );

  @override
  List<Object> get props => [
        failureOrPostListOption,
        failureOrUnitOption,
      ];
}
