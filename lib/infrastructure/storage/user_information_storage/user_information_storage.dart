import 'package:dartz/dartz.dart';
import 'package:event_mate/failure/storage/user_information_storage_failure.dart';
import 'package:event_mate/infrastructure/storage/user_information_storage/i_user_information_storage.dart';
import 'package:event_mate/model/user_information.dart';
import 'package:sembast/sembast.dart';

class UserInformationStorage implements IUserInformationStorage {
  UserInformationStorage(this._database, this._store);
  static const storeKey = 'user_information';
  final Database _database;
  final StoreRef<String, Map<String, Object?>> _store;

  // TODO(Furkan): Burada record içine verilen key'ler unique olmalı. Şimdilik hata vermesin diye storeKey verildi. UserId benzeri bir şey verilmeli
  @override
  Future<Either<UserInformationStorageFailure, UserInformation>> get() async {
    try {
      final userMap = await _store.record(storeKey).get(_database);

      if (userMap == null)
        return left(const UserInformationStorageNotFoundFailure());

      return right(UserInformation.fromMap(userMap));
    } catch (e) {
      return left(
        UserInformationStorageUnknownFailure(
            'UserInformationStorageUnknownFailure: $e'),
      );
    }
  }

  @override
  Future<Either<UserInformationStorageFailure, Unit>> put(
    UserInformation userInfo,
  ) async {
    try {
      final userInfoMap = userInfo.toMap();
      await _store.record(storeKey).put(_database, userInfoMap);

      return right(unit);
    } catch (e) {
      return left(
        UserInformationStorageUnknownFailure(
            'UserInformationStorageUnknownFailure: $e'),
      );
    }
  }
}
