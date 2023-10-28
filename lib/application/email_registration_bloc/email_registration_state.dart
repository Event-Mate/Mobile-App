part of 'email_registration_bloc.dart';

final class EmailRegistrationState extends Equatable {
  const EmailRegistrationState({
    required this.nameOption,
    required this.currentStepIndex,
    required this.processFailureOrUnitOption,
  });

  factory EmailRegistrationState.initial() {
    return EmailRegistrationState(
      nameOption: none(),
      currentStepIndex: 0,
      processFailureOrUnitOption: none(),
    );
  }

  final Option<String> nameOption;
  final int currentStepIndex;
  final Option<Either<RegistrationRepositoryFailure, Unit>>
      processFailureOrUnitOption;

  EmailRegistrationState copyWith({
    Option<String>? nameOption,
    Option<Either<RegistrationRepositoryFailure, Unit>>?
        processFailureOrUnitOption,
    int? currentStepIndex,
  }) {
    return EmailRegistrationState(
      nameOption: nameOption ?? this.nameOption,
      currentStepIndex: currentStepIndex ?? this.currentStepIndex,
      processFailureOrUnitOption:
          processFailureOrUnitOption ?? this.processFailureOrUnitOption,
    );
  }

  String get nameOrEmptyStr => nameOption.getOrElse(() => '');
  bool get isNameValid =>
      nameOption.isSome() && nameOrEmptyStr.trim().isNotEmpty;

  @override
  List<Object> get props => [
        nameOption,
        currentStepIndex,
        processFailureOrUnitOption,
        isNameValid,
      ];
}
