part of 'my_profile_bloc.dart';

class MyProfileState extends Equatable {
  const MyProfileState({required this.userInformationOption});

  factory MyProfileState.initial() {
    return MyProfileState(userInformationOption: none());
  }

  final Option<Either<UserInformationStorageFailure, UserInformation>>
      userInformationOption;

  MyProfileState copyWith({
    Option<Either<UserInformationStorageFailure, UserInformation>>?
        userInformationOption,
  }) {
    return MyProfileState(
      userInformationOption:
          userInformationOption ?? this.userInformationOption,
    );
  }

  UserInformation? get userInformationOrNull => userInformationOption.fold(
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
