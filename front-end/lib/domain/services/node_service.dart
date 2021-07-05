import 'dart:convert';

import 'package:co2monitor/config/http_client.dart';
import 'package:co2monitor/domain/models/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NodeService {
  static final bool _mockBackend = dotenv.env['mockBackend'] == 'true';

  final HttpClient _httpClient;

  NodeService({
    required HttpClient httpClient,
  }) : _httpClient = httpClient;

  Future<List<Node>> findAllByInstitutionId(String institutionId) async {
    if (_mockBackend) {
      return [
        Node.fromJson({
          "id": "60b6e7085800d825c0176cb8",
          "creationDate": "2021-06-02T02:03:52.916Z",
          "name": "Laboratório de máquinas operatrizes",
          "mac": {"value": "5FC7FB523F1C"},
          "institutionId": "60b6db625803bc66c8312e34",
          "imageUrl": "https://i.imgur.com/DFOtTGM.png"
        })
      ];
    }

    final response =
        await _httpClient.get('v1/nodes/institution/$institutionId');

    final statusCode = response.statusCode;

    if (statusCode == 200) {
      final body =
          Response.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

      if (body.status == ResponseStatus.success) {
        return (body.data as List).map((e) => Node.fromJson(e)).toList();
      } else {
        throw Exception(body.message);
      }
    } else {
      throw Exception(
          'Could not fetch the nodes by institution id! The server returned status code $statusCode.');
    }
  }
}
