import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:event_mate/core/mixins/api_header_mixin.dart';
import 'package:event_mate/environment.dart' as env;
import 'package:event_mate/failure/repository/registration_repository_failure.dart';
import 'package:event_mate/infrastructure/repository/registration_repository/i_registration_repository.dart';

import 'package:event_mate/model/registration_data.dart';
import 'package:event_mate/model/user_data.dart';
import 'package:event_mate/service/custom_http_client.dart';

class RegistrationRepository
    with ApiHeaderMixin
    implements IRegistrationRepository {
  const RegistrationRepository(this._client);
  final CustomHttpClient _client;

  @override
  Future<Either<RegistrationRepositoryFailure, UserDataWithToken>>
      registerUser({
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
        headers: noTokenApiHeader,
      );

      final result = jsonDecode(response.body) as Map<String, dynamic>;

      final error = _handleNetworkErrors(response.statusCode, result);

      if (error != null) {
        return left(error);
      } else {
        final data = result['data'] as Map<String, dynamic>;
        final accessToken = result['accessToken'] as String;
        return right(Tuple2(UserData.fromMap(data), accessToken));
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
      headers: noTokenApiHeader,
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
      headers: noTokenApiHeader,
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

RegistrationRepositoryFailure? _handleNetworkErrors(
  int statusCode,
  Map<String, dynamic> result,
) {
  if (statusCode == 200) return null;

  return RegistrationUnknownFailure(
    "RegistrationUnknownFailure: ${result['error']}",
  );
}
