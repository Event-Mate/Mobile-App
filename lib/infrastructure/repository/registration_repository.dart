import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:event_mate/core/mixins/api_header_mixin.dart';
import 'package:event_mate/environment_variables.env' as env;
import 'package:event_mate/failure/repository/registration_repository_failure.dart';
import 'package:event_mate/infrastructure/repository/i_registration_repository.dart';
import 'package:event_mate/model/registration_data.dart';
import 'package:event_mate/model/user_data.dart';
import 'package:event_mate/service/custom_http_client.dart';

class RegistrationRepository
    with ApiHeaderMixin
    implements IRegistrationRepository {
  const RegistrationRepository(this._client);
  final CustomHttpClient _client;

  @override
  Future<Either<RegistrationRepositoryFailure, UserData>> registerUser({
    required RegistrationData registrationData,
  }) async {
    try {
      final uri = Uri(
        scheme: env.HTTPS_SCHEME,
        host: env.AWS_HOST,
        path: 'api/auth/register',
      );

      final files = registrationData.avatarFile != null
          ? [registrationData.avatarFile!]
          : List<File>.empty();

      final response = await _client.postWithFiles(
        uri,
        files,
        body: registrationData.toMap(),
        headers: nonSessionApiHeader,
      );

      final result = jsonDecode(response.body) as Map<String, dynamic>;
      final success = result['success'] as bool;

      final data = result['data'] as Map<String, dynamic>;

      if (success) {
        return right(UserData.fromMap(data));
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

  @override
  Future<Either<RegistrationUsernameAlreadyExistsFailure, Unit>>
      validateUsername({required String username}) async {
    final uri = Uri(
      scheme: env.HTTPS_SCHEME,
      host: env.AWS_HOST,
      path: 'api/auth/verify-username/$username',
    );

    final response = await _client.post(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    final result = jsonDecode(response.body) as Map<String, dynamic>;

    final error = result['error'];

    if (error == null) {
      return right(unit);
    } else {
      return left(
        RegistrationUsernameAlreadyExistsFailure(
          "RegistrationUsernameAlreadyExistsFailure: $error",
        ),
      );
    }
  }

  @override
  Future<Either<RegistrationEmailAlreadyExistsFailure, Unit>> validateEmail({
    required String email,
  }) async {
    final uri = Uri(
      scheme: env.HTTPS_SCHEME,
      host: env.AWS_HOST,
      path: 'api/auth/verify-email/$email',
    );

    final response = await _client.post(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    final result = jsonDecode(response.body) as Map<String, dynamic>;

    final error = result['error'];

    if (error == null) {
      return right(unit);
    } else {
      return left(
        RegistrationEmailAlreadyExistsFailure(
          "RegistrationEmailAlreadyExistsFailure: $error",
        ),
      );
    }
  }
}
