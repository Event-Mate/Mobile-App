import 'dart:io';

import 'package:event_mate/infrastructure/controller/cache_controller/cache_key.dart';
import 'package:event_mate/infrastructure/controller/cache_controller/i_cache_controller.dart';
import 'package:event_mate/injection.dart';

mixin ApiHeaderMixin {
  Map<String, String> get noTokenApiHeader => {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      };

  Map<String, String> get tokenApiHeader {
    final token = _getAccessToken();
    return {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
  }

  String? _getAccessToken() {
    final iCacheController = getIt<ICacheController>();
    final token = iCacheController.readString(key: CacheKey.ACCESS_TOKEN);
    if (token == null) {
      throw Exception('Token is null');
    }

    return token;
  }
}
