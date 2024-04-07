part of 'email_login_bloc.dart';

final class EmailLoginState extends Equatable {
  const EmailLoginState({
    required this.failureOrUnitOption,
    required this.submitting,
  });

  factory EmailLoginState.initial() {
    return EmailLoginState(
      failureOrUnitOption: none(),
      submitting: false,
    );
  }

  final Option<Either<CustomFailure, Unit>> failureOrUnitOption;
  final bool submitting;

  @override
  List<Object> get props => [failureOrUnitOption, submitting];

  EmailLoginState copyWith({
    Option<Either<CustomFailure, Unit>>? failureOrUnitOption,
    bool? submitting,
  }) {
    return EmailLoginState(
      failureOrUnitOption: failureOrUnitOption ?? this.failureOrUnitOption,
      submitting: submitting ?? this.submitting,
    );
  }
}
