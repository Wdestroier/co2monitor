import 'dart:convert';

import 'package:co2monitor/config/http_client.dart';
import 'package:co2monitor/models/models.dart';

final HttpClient httpClient = HttpClient();

const String institutionCnpj = "11402887000160";

const devEnv = false;

Future<Institution> fetchInstitution(String cnpj) async {
  if (devEnv) {
    return Institution.fromJson({
      "id": "60b6db625803bc66c8312e34",
      "creationDate": "2021-06-02T01:14:09.923Z",
      "name": "Instituto Federal de Santa Catarina",
      "cnpj": {"value": "11.402.887/0001-60"}
    });
  }

  final response = await httpClient.get('v1/institutions/cnpj/$cnpj');

  final statusCode = response.statusCode;

  if (statusCode == 200) {
    final body = Response.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

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

Future<List<Node>> fetchInstitutionNodes(String institutionId) async {
  if (devEnv) {
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

  final response = await httpClient.get('v1/nodes/institution/$institutionId');

  final statusCode = response.statusCode;

  if (statusCode == 200) {
    final body = Response.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

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

Future<Report> fetchLastNodeReport(String nodeMac) async {
  if (devEnv) {
    return Report.fromJson({
      "id": "60b6ece392c31f2052580e54",
      "creationDate": "2021-06-03T02:28:51.905Z",
      "nodeMac": "88562AF9E423",
      "ppm": 40000
    });
  }

  final response = await httpClient.get('v1/report/nodeMac/$nodeMac');

  final statusCode = response.statusCode;

  if (statusCode == 200) {
    final body = Response.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

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
