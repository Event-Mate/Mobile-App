import 'package:dartz/dartz.dart';
import 'package:event_mate/failure/repository/registration_repository_failure.dart';
import 'package:event_mate/model/registration_data.dart';

abstract class IRegistrationRepository {
  Future<Either<RegistrationRepositoryFailure, Unit>> registerUser({
    required RegistrationData registrationData,
  });

  Future<Either<RegistrationUsernameAlreadyExistsFailure, Unit>>
      validateUsername({
    required String username,
  });
}
