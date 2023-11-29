import 'dart:io';

import 'package:http/http.dart';

class CustomHttpClient extends BaseClient {
  final Client _inner = Client();
  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    StreamedResponse response;
    try {
      response = await _inner.send(request);
    } catch (e) {
      rethrow;
    }

    return response;
  }

  Future<Response> postWithFiles(
    Uri uri,
    List<File> files, {
    Map<String, String>? headers,
    Map<String, String>? body,
  }) async {
    final multiPartFiles = await _convertToMultiPartList(files);

    final mpRequest = MultipartRequest('POST', uri)
      ..headers.addAll(headers ?? {})
      ..fields.addAll(body ?? {})
      ..files.addAll(multiPartFiles);

    final streamedResponse = await mpRequest.send();

    return Response.fromStream(streamedResponse);
  }

  Future<Response> patchWithFiles(
    Uri uri,
    List<File> files, {
    Map<String, String>? headers,
    Map<String, String>? body,
  }) async {
    final multiPartFiles = await _convertToMultiPartList(files);

    final mpRequest = MultipartRequest('PATCH', uri)
      ..headers.addAll(headers ?? {})
      ..fields.addAll(body ?? {})
      ..files.addAll(multiPartFiles);

    final streamedResponse = await mpRequest.send();

    return Response.fromStream(streamedResponse);
  }

  Future<List<MultipartFile>> _convertToMultiPartList(List<File> files) async {
    final multipartFiles = <MultipartFile>[];

    for (final file in files) {
      final multipartFile = await MultipartFile.fromPath(
        // TODO(Furkan): double check and take param here if needed
        'files',
        file.path,
      );
      multipartFiles.add(multipartFile);
    }

    return multipartFiles;
  }
}
