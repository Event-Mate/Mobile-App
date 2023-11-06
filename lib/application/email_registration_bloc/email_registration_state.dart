part of 'email_registration_bloc.dart';

final class EmailRegistrationState extends Equatable {
  const EmailRegistrationState({
    required this.currentStepIndex,
    required this.processFailureOrUnitOption,
  });

  factory EmailRegistrationState.initial() {
    return EmailRegistrationState(
      currentStepIndex: 0,
      processFailureOrUnitOption: none(),
    );
  }

  final int currentStepIndex;
  final Option<Either<RegistrationRepositoryFailure, Unit>>
      processFailureOrUnitOption;

  EmailRegistrationState copyWith({
    Option<Either<RegistrationRepositoryFailure, Unit>>?
        processFailureOrUnitOption,
    int? currentStepIndex,
  }) {
    return EmailRegistrationState(
      currentStepIndex: currentStepIndex ?? this.currentStepIndex,
      processFailureOrUnitOption:
          processFailureOrUnitOption ?? this.processFailureOrUnitOption,
    );
  }

  RegistrationStepType get currentStepType {
    return RegistrationSteps.stepsMap.keys.elementAt(currentStepIndex);
  }

  @override
  List<Object> get props => [
        currentStepIndex,
        processFailureOrUnitOption,
      ];
}
