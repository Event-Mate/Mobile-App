part of 'email_login_bloc.dart';

final class EmailLoginState extends Equatable {
  const EmailLoginState({
    required this.failureOrUserDataWToken,
    required this.submitting,
  });

  factory EmailLoginState.initial() {
    return EmailLoginState(
      failureOrUserDataWToken: none(),
      submitting: false,
    );
  }

  final Option<Either<LoginRepositoryFailure, UserDataWithToken>>
      failureOrUserDataWToken;
  final bool submitting;

  @override
  List<Object> get props => [failureOrUserDataWToken, submitting];

  EmailLoginState copyWith({
    Option<Either<LoginRepositoryFailure, UserDataWithToken>>?
        failureOrUserDataWToken,
    bool? submitting,
  }) {
    return EmailLoginState(
      failureOrUserDataWToken:
          failureOrUserDataWToken ?? this.failureOrUserDataWToken,
      submitting: submitting ?? this.submitting,
    );
  }
}
