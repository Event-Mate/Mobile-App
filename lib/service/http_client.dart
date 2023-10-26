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
}
