import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:event_mate/core/mixins/api_header_mixin.dart';
import 'package:event_mate/environment.dart' as env;
import 'package:event_mate/failure/repository/login_repository_failure.dart';
import 'package:event_mate/infrastructure/repository/login_repository/i_login_repository.dart';
import 'package:event_mate/model/user_data.dart';
import 'package:event_mate/service/custom_http_client.dart';

class LoginRepository with ApiHeaderMixin implements ILoginRepository {
  const LoginRepository(this._client);

  final CustomHttpClient _client;

  @override
  Future<Either<LoginRepositoryFailure, UserDataWithToken>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final uri = Uri(
        scheme: env.HTTPS_SCHEME,
        host: env.AWS_HOST,
        path: 'api/auth/login',
      );

      final body = {
        "email": email,
        "password": password,
      };

      final response = await _client.post(
        uri,
        headers: noTokenApiHeader,
        body: json.encode(body),
      );

      final result = jsonDecode(response.body) as Map<String, dynamic>;
      final error = _handleNetworkErrors(response.statusCode, result);

      if (error != null) {
        return left(error);
      } else {
        final data = result['data'] as Map<String, dynamic>;
        final token = result['accessToken'] as String;

        return right(Tuple2(UserData.fromMap(data), token));
      }
    } catch (e) {
      return left(LoginUnknownFailure('LoginUnknownFailure: $e'));
    }
  }

  LoginRepositoryFailure? _handleNetworkErrors(
    int statusCode,
    Map<String, dynamic> result,
  ) {
    if (statusCode == 200) return null;

    final errorMap = result['error'];

    if (statusCode == 400) {
      return LoginInvalidCredentialsFailure(
        "LoginInvalidCredentialsFailure: $errorMap",
      );
    } else if (statusCode == 404) {
      return LoginUserNotExistFailure(
        "LoginUserNotExistFailure: $errorMap",
      );
    } else {
      return LoginUnknownFailure(
        "LoginUnknownFailure: $errorMap",
      );
    }
  }
}
