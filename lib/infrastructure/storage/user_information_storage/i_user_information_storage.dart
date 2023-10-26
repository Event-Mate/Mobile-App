import 'package:dartz/dartz.dart';
import 'package:event_mate/failure/storage/user_information_storage_failure.dart';
import 'package:event_mate/model/user_information.dart';

abstract class IUserInformationStorage {
  Future<Either<UserInformationStorageFailure, Unit>> put(
    UserInformation userInfo,
  );

  Future<Either<UserInformationStorageFailure, UserInformation>> get();
}
