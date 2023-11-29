part of 'my_profile_bloc.dart';

final class MyProfileState extends Equatable {
  const MyProfileState({required this.userInformationOption});

  factory MyProfileState.initial() {
    return MyProfileState(userInformationOption: none());
  }

  final Option<Either<UserInformationStorageFailure, UserData>>
      userInformationOption;

  MyProfileState copyWith({
    Option<Either<UserInformationStorageFailure, UserData>>?
        userInformationOption,
  }) {
    return MyProfileState(
      userInformationOption:
          userInformationOption ?? this.userInformationOption,
    );
  }

  UserData? get userInformationOrNull => userInformationOption.fold(
        () => null,
        (failureOrUserInfo) => failureOrUserInfo.fold(
          (failure) => null,
          (userInfo) => userInfo,
        ),
      );

  bool get processFailed => userInformationOption.fold(
        () => false,
        (failureOrUserInfo) => failureOrUserInfo.isLeft(),
      );

  @override
  List<Object?> get props => [userInformationOption];
}
