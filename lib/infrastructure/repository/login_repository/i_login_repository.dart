import 'package:dartz/dartz.dart';
import 'package:event_mate/failure/repository/login_repository_failure.dart';
import 'package:event_mate/model/user_data.dart';

typedef UserDataWithToken = Tuple2<UserData, String>;

abstract class ILoginRepository {
  Future<Either<LoginRepositoryFailure, UserDataWithToken>> loginUser({
    required String email,
    required String password,
  });
}
