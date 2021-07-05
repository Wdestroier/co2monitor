import 'dart:convert';

import 'package:co2monitor/config/http_client.dart';
import 'package:co2monitor/domain/models/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ReportService {
  static final bool _mockBackend = dotenv.env['mockBackend'] == 'true';

  final HttpClient _httpClient;

  ReportService({
    required HttpClient httpClient,
  }) : _httpClient = httpClient;

  Future<Report> findAllByNodeMac(String nodeMac) async {
    if (_mockBackend) {
      return Report.fromJson({
        "id": "60b6ece392c31f2052580e54",
        "creationDate": "2021-06-03T02:28:51.905Z",
        "nodeMac": "88562AF9E423",
        "ppm": 40000
      });
    }

    final response = await _httpClient.get('v1/report/nodeMac/$nodeMac');

    final statusCode = response.statusCode;

    if (statusCode == 200) {
      final body =
          Response.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

      if (body.status == ResponseStatus.success) {
        return Report.fromJson(body.data);
      } else {
        throw Exception(body.message);
      }
    } else {
      throw Exception(
          'Could not fetch the nodes by institution id! The server returned status code $statusCode.');
    }
  }
}
