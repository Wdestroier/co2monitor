import 'package:http/http.dart' as http;

class HttpClient {
  static const String baseUrl = 'http://localhost:8080/api/';

  Future<http.Response> get(String uri, {Map<String, String>? headers}) {
    return http.get(Uri.parse(baseUrl + uri), headers: headers);
  }
}
