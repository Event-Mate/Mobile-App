import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:event_mate/core/mixins/api_header_mixin.dart';
import 'package:event_mate/environment.dart' as env;
import 'package:event_mate/failure/core/custom_failure.dart';
import 'package:event_mate/infrastructure/repository/social_repository/i_social_repository.dart';
import 'package:event_mate/service/custom_http_client.dart';
import 'package:kt_dart/kt.dart';

class SocialRepository with ApiHeaderMixin implements ISocialRepository {
  SocialRepository(this._client);

  final CustomHttpClient _client;

  @override
  Future<Either<CustomFailure, KtList<PostData>>> getAll() async {
    try {
      final uri = Uri(
        scheme: env.HTTPS_SCHEME,
        host: env.AWS_HOST,
        path: '/api/post',
      );

      final response = await _client.get(
        uri,
        headers: tokenApiHeader,
      );

      final result = jsonDecode(response.body) as Map<String, dynamic>;

      final error = _handleNetworkErrors(response.statusCode, result);

      if (error != null) {
        return left(error);
      } else {
        final data = result['data'] as List<dynamic>;

        final posts = data.map((e) {
          final post = e as Map<String, dynamic>;
          return PostData.fromJson(post);
        }).toImmutableList();

        return right(posts);
      }
    } catch (e) {
      return left(const UnknownCustomFailure());
    }
  }
}
