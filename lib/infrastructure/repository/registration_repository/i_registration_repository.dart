import 'package:dartz/dartz.dart';
import 'package:event_mate/failure/core/custom_failure.dart';
import 'package:event_mate/model/registration_data.dart';
import 'package:event_mate/model/user_data.dart';

typedef UserDataWithToken = Tuple2<UserData, String>;

abstract class IRegistrationRepository {
  Future<Either<CustomFailure, UserDataWithToken>> registerUser({
    required RegistrationData registrationData,
  });

  Future<Either<ConflictCustomFailure, Unit>> validateUsername({
    required String username,
  });

  Future<Either<ConflictCustomFailure, Unit>> validateEmail({
    required String email,
  });
}
