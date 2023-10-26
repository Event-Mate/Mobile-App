import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:event_mate/environment_variables.env';
import 'package:event_mate/failure/repository/registration_repository_failure.dart';
import 'package:event_mate/infrastructure/repository/i_registration_repository.dart';
import 'package:event_mate/model/user_information.dart';
import 'package:event_mate/service/http_client.dart';

class RegistrationRepository implements IRegistrationRepository {
  const RegistrationRepository(this._client);
  final CustomHttpClient _client;

  @override
  Future<Either<RegistrationRepositoryFailure, Unit>> registerUser({
    required UserInformation userInfo,
  }) async {
    try {
      // TODO(Furkan): path update
      final uri = Uri(
        scheme: HTTPS_SCHEME,
        host: AWS_HOST,
        path: 'api/auth/register',
      );

      final response = await _client.post(
        uri,
        body: userInfo.toMap(),
      );

      final result = jsonDecode(response.body) as Map<String, dynamic>;
      final success = result['success'] as bool;

      if (success) {
        return right(unit);
      } else {
        // TODO(Furkan): Burası güncellenecek failure tiplerine göre. Şimdilik unknown failure döndürüyoruz
        return left(
            const RegistrationUnknownFailure('RegistartionUnknownFailure'));
      }
    } catch (e) {
      return left(RegistrationUnknownFailure('RegistartionUnknownFailure: $e'));
    }
  }
}
