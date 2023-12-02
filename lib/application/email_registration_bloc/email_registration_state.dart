part of 'email_registration_bloc.dart';

final class EmailRegistrationState extends Equatable {
  const EmailRegistrationState({
    required this.currentStepIndex,
    required this.processFailureOrUnitOption,
    required this.registrationData,
    required this.completing,
  });

  factory EmailRegistrationState.initial() {
    return EmailRegistrationState(
      currentStepIndex: 0,
      processFailureOrUnitOption: none(),
      registrationData: RegistrationData.empty(),
      completing: false,
    );
  }

  final int currentStepIndex;
  final Option<Either<RegistrationRepositoryFailure, Unit>>
      processFailureOrUnitOption;
  final RegistrationData registrationData;
  final bool completing;

  EmailRegistrationState copyWith({
    Option<Either<RegistrationRepositoryFailure, Unit>>?
        processFailureOrUnitOption,
    int? currentStepIndex,
    RegistrationData? registrationData,
    bool? completing,
  }) {
    return EmailRegistrationState(
      currentStepIndex: currentStepIndex ?? this.currentStepIndex,
      processFailureOrUnitOption:
          processFailureOrUnitOption ?? this.processFailureOrUnitOption,
      registrationData: registrationData ?? this.registrationData,
      completing: completing ?? this.completing,
    );
  }

  RegistrationStepType get currentStepType {
    return RegistrationSteps.stepsMap.keys.elementAt(currentStepIndex);
  }

  @override
  List<Object> get props => [
        currentStepIndex,
        processFailureOrUnitOption,
        registrationData,
        completing,
      ];
}
