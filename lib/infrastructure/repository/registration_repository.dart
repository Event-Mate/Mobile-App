import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:event_mate/environment_variables.env' as env;
import 'package:event_mate/failure/repository/registration_repository_failure.dart';
import 'package:event_mate/infrastructure/repository/i_registration_repository.dart';
import 'package:event_mate/model/user_data.dart';
import 'package:event_mate/service/custom_http_client.dart';

class RegistrationRepository implements IRegistrationRepository {
  const RegistrationRepository(this._client);
  final CustomHttpClient _client;

  @override
  Future<Either<RegistrationRepositoryFailure, Unit>> registerUser({
    required UserData userData,
  }) async {
    try {
      final uri = Uri(
        scheme: env.HTTPS_SCHEME,
        host: env.AWS_HOST,
        path: 'api/auth/register',
      );

      final response = await _client.post(
        uri,
        body: jsonEncode(userData.toMap()),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      final result = jsonDecode(response.body) as Map<String, dynamic>;
      final success = result['success'] as bool;

      if (success) {
        final user = result['data']['user'] as Map<String, dynamic>;
        log('User: $user');
        return right(unit);
      } else {
        // TODO(Furkan): Burası güncellenecek failure tiplerine göre. Şimdilik unknown failure döndürüyoruz
        return left(
          const RegistrationUnknownFailure('RegistartionUnknownFailure'),
        );
      }
    } catch (e) {
      return left(RegistrationUnknownFailure('RegistartionUnknownFailure: $e'));
    }
  }
}
