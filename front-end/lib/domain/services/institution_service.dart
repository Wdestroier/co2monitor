import 'dart:convert';

import 'package:co2monitor/config/http_client.dart';
import 'package:co2monitor/domain/models/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class InstitutionService {
  static final bool _mockBackend = dotenv.env['mockBackend'] == 'true';

  final HttpClient _httpClient;

  InstitutionService({
    required HttpClient httpClient,
  }) : _httpClient = httpClient;

  Future<Institution> findOneByCnpj(String cnpj) async {
    if (_mockBackend) {
      return Institution.fromJson({
        "id": "60b6db625803bc66c8312e34",
        "creationDate": "2021-06-02T01:14:09.923Z",
        "name": "Instituto Federal de Santa Catarina",
        "cnpj": {"value": "11.402.887/0001-60"}
      });
    }

    final response = await _httpClient.get('v1/institutions/cnpj/$cnpj');

    final statusCode = response.statusCode;

    if (statusCode == 200) {
      final body =
          Response.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

      if (body.status == ResponseStatus.success) {
        return Institution.fromJson(body.data!);
      } else {
        throw Exception(body.message);
      }
    } else {
      throw Exception(
          'Could not fetch the institution by CNPJ! The server returned status code $statusCode.');
    }
  }
}
