import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client _client = http.Client();

  Future<http.Response> get(Uri url) async {
    return await _client.get(url);
  }
}