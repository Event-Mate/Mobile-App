import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:event_mate/core/mixins/api_header_mixin.dart';
import 'package:event_mate/environment.dart' as env;
import 'package:event_mate/failure/repository/event_repository_failure.dart';
import 'package:event_mate/infrastructure/repository/event_repository/i_event_repository.dart';
import 'package:event_mate/model/event_data.dart';
import 'package:event_mate/service/custom_http_client.dart';
import 'package:kt_dart/kt.dart';

class EventRepository with ApiHeaderMixin implements IEventRepository {
  EventRepository(this._client);

  final CustomHttpClient _client;

  @override
  Future<Either<EventRepositoryFailure, KtList<String>>> getCategories() async {
    try {
      final uri = Uri(
        scheme: env.HTTPS_SCHEME,
        host: env.AWS_HOST,
        path: '/api/category',
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

        final categories = data.map((e) {
          final category = e as Map<String, dynamic>;
          return category['name'] as String;
        }).toImmutableList();

        return right(categories);
      }
    } catch (e) {
      return left(EventUnknownFailure('EventUnknownFailure: $e'));
    }
  }

  @override
  Future<Either<EventRepositoryFailure, KtList<EventData>>>
      getAllEvents() async {
    try {
      final uri = Uri(
        scheme: env.HTTPS_SCHEME,
        host: env.AWS_HOST,
        path: '/api/event',
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

        final events = data
            .map((e) => EventData.fromMap(e as Map<String, dynamic>))
            .toImmutableList();

        return right(events);
      }
    } catch (e) {
      return left(EventUnknownFailure('EventUnknownFailure: $e'));
    }
  }

  EventRepositoryFailure? _handleNetworkErrors(
    int statusCode,
    Map<String, dynamic> result,
  ) {
    if (statusCode == 200) return null;

    return EventUnknownFailure('EventUnknownFailure: $result');
  }
}
