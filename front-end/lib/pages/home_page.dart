import 'package:co2monitor/config/http_client.dart';
import 'package:co2monitor/domain/services/services.dart';
import 'package:co2monitor/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  late final InstitutionService institutionService;
  late final NodeService nodeService;
  late final ReportService reportService;

  HomePage({
    Key? key,
    required HttpClient httpClient,
  }) : super(key: key) {
    institutionService = InstitutionService(
      httpClient: httpClient,
    );
    nodeService = NodeService(
      httpClient: httpClient,
    );
    reportService = ReportService(
      httpClient: httpClient,
    );
  }

  @override
  Widget build(BuildContext context) {
    const institutionCnpj = "11402887000160";

    return Scaffold(
      appBar: AppBar(
        leading: Logo(),
      ),
      body: ReportList(
        institutionCnpj: institutionCnpj,
        institutionService: institutionService,
        nodeService: nodeService,
        reportService: reportService,
      ),
    );
  }
}
