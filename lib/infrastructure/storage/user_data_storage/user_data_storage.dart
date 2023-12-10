import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:event_mate/configuration/sembast_configuration.dart';
import 'package:event_mate/failure/storage/user_data_storage_failure.dart';
import 'package:event_mate/infrastructure/storage/user_data_storage/i_user_data_storage.dart';
import 'package:event_mate/model/user_data.dart';
import 'package:rxdart/subjects.dart';
import 'package:sembast/sembast.dart';

class UserDataStorage implements IUserDataStorage {
  UserDataStorage(this._store, this._database);
  static const storeKey = 'user_data';

  final StringMapStoreRef _store;
  final Database _database;

  final BehaviorSubject<int> subject = BehaviorSubject();

  @override
  Future<Either<UserDataStorageFailure, UserData>> get({
    required String uniqueId,
  }) async {
    try {
      final userMap = await _store.record(uniqueId).get(_database);
      log('userMap: $userMap');

      if (userMap == null) {
        return left(const UserDataStorageNotFoundFailure());
      }
      final userData = UserData.fromMap(userMap);
      log('userData: $userData');
      return right(userData);
    } catch (e) {
      return left(
        UserDataStorageUnknownFailure('UserDataStorageUnknownFailure: $e'),
      );
    }
  }

  @override
  Future<Either<UserDataStorageFailure, Unit>> put({
    required String uniqueId,
    required UserData userData,
  }) async {
    try {
      final userDataMap = userData.toMap();
      await _store.record(uniqueId).put(_database, userDataMap, merge: true);

      subject.add(0);

      return right(unit);
    } catch (e) {
      return left(
        UserDataStorageUnknownFailure('UserDataStorageUnknownFailure: $e'),
      );
    }
  }
}
