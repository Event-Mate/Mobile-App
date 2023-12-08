import 'dart:io';

mixin ApiHeaderMixin {
  Map<String, String> get nonSessionApiHeader => {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      };
}
