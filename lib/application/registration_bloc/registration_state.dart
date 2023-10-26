part of 'registration_bloc.dart';

class RegistrationState extends Equatable {
  const RegistrationState({required this.processFailureOrUnitOption});

  factory RegistrationState.initial() {
    return RegistrationState(processFailureOrUnitOption: none());
  }

  final Option<Either<RegistrationRepositoryFailure, Unit>>
      processFailureOrUnitOption;

  RegistrationState copyWith({
    Option<Either<RegistrationRepositoryFailure, Unit>>?
        processFailureOrUnitOption,
  }) {
    return RegistrationState(
      processFailureOrUnitOption:
          processFailureOrUnitOption ?? this.processFailureOrUnitOption,
    );
  }

  @override
  List<Object> get props => [processFailureOrUnitOption];
}
