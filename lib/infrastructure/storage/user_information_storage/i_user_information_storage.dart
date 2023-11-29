import 'package:dartz/dartz.dart';
import 'package:event_mate/failure/storage/user_information_storage_failure.dart';
import 'package:event_mate/model/user_data.dart';

abstract class IUserInformationStorage {
  Future<Either<UserInformationStorageFailure, Unit>> put(
    UserData userInfo,
  );

  Future<Either<UserInformationStorageFailure, UserData>> get();
}
