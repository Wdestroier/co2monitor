import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class HttpClient {
  static final String baseUrl = dotenv.env['baseUrl']!;

  Future<http.Response> get(String uri, {Map<String, String>? headers}) {
    return http.get(Uri.parse(baseUrl + uri), headers: headers);
  }
}
