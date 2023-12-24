part of 'my_profile_bloc.dart';

final class MyProfileState extends Equatable {
  const MyProfileState({required this.userDataOption});

  factory MyProfileState.initial() {
    return MyProfileState(userDataOption: none());
  }

  final Option<Either<UserDataStorageFailure, UserData>> userDataOption;

  MyProfileState copyWith({
    Option<Either<UserDataStorageFailure, UserData>>? userDataOption,
  }) {
    return MyProfileState(
      userDataOption: userDataOption ?? this.userDataOption,
    );
  }

  UserData? get userDataOrNull => userDataOption.fold(
        () => null,
        (failureOrUserData) => failureOrUserData.fold(
          (failure) => null,
          (userData) => userData,
        ),
      );

  bool get processFailed => userDataOption.fold(
        () => false,
        (failureOrUserData) => failureOrUserData.isLeft(),
      );

  @override
  List<Object?> get props => [userDataOption];
}
