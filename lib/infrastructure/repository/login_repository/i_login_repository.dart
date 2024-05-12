import 'package:dartz/dartz.dart';
import 'package:event_mate/failure/core/custom_failure.dart';
import 'package:event_mate/model/user_data.dart';

typedef UserDataWithToken = Tuple2<UserData, String>;

abstract class ILoginRepository {
  Future<Either<CustomFailure, UserDataWithToken>> loginUser({
    required String email,
    required String password,
  });
}
