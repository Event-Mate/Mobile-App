import 'package:dartz/dartz.dart';
import 'package:event_mate/failure/core/custom_failure.dart';

import 'package:event_mate/model/user_data.dart';

abstract class IUserDataStorage {
  Future<Either<CustomFailure, Unit>> put({
    required String uniqueId,
    required UserData userData,
  });

  Future<Either<CustomFailure, UserData>> get({
    required String uniqueId,
  });

  Future<Either<CustomFailure, Unit>> delete({
    required String uniqueId,
  });
}
