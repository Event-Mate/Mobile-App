import 'package:dartz/dartz.dart';
import 'package:event_mate/failure/storage/user_data_storage_failure.dart';
import 'package:event_mate/model/user_data.dart';

abstract class IUserDataStorage {
  Future<Either<UserDataStorageFailure, Unit>> put({
    required String uniqueId,
    required UserData userData,
  });

  Future<Either<UserDataStorageFailure, UserData>> get({
    required String uniqueId,
  });

  Future<Either<UserDataStorageFailure, Unit>> delete({
    required String uniqueId,
  });
}
