import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:event_mate/core/mixins/api_header_mixin.dart';
import 'package:event_mate/environment.dart' as env;
import 'package:event_mate/failure/core/custom_failure.dart';
import 'package:event_mate/infrastructure/repository/social_repository/i_social_repository.dart';
import 'package:event_mate/model/event_data.dart';
import 'package:event_mate/model/post_data.dart';
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

      if (error != null) return left(error);

      final postList = result['data'] as List<dynamic>;

      final postListData = postList
          .map((e) => PostData.fromMap(e as Map<String, dynamic>))
          .toImmutableList();

      return right(postListData);
    } catch (e) {
      return left(UnknownCustomFailure("UnknownCustomFailure: $e"));
    }
  }

  @override
  Future<Either<CustomFailure, Unit>> createPost({
    required String content,
    required EventData eventData,
  }) async {
    try {
      final uri = Uri(
        scheme: env.HTTPS_SCHEME,
        host: env.AWS_HOST,
        path: '/api/post/create',
      );

      final response = await _client.post(
        uri,
        headers: tokenApiHeader,
        body: jsonEncode({
          'content': content,
          'event': eventData.toMap(),
        }),
      );

      final result = jsonDecode(response.body) as Map<String, dynamic>;

      final error = _handleNetworkErrors(response.statusCode, result);

      if (error != null) return left(error);

      return right(unit);
    } catch (e) {
      return left(UnknownCustomFailure("UnknownCustomFailure: $e"));
    }
  }

  CustomFailure? _handleNetworkErrors(
    int statusCode,
    Map<String, dynamic> result,
  ) {
    if (statusCode == 200) return null;

    final errorMap = result['error'];

    if (errorMap != null) {
      final error = errorMap as Map<String, dynamic>;
      final message = error['message'] as String;
      return UnknownCustomFailure('UnknownCustomFailure: $message');
    }

    return UnknownCustomFailure('UnknownCustomFailure: $result');
  }
}
