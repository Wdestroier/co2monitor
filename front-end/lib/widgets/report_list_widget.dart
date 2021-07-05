import 'package:co2monitor/domain/models/models.dart';
import 'package:co2monitor/domain/services/services.dart';
import 'package:co2monitor/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'responsive_widget.dart';

class ReportList extends StatelessWidget {
  final String institutionCnpj;
  final InstitutionService institutionService;
  final NodeService nodeService;
  final ReportService reportService;

  const ReportList({
    Key? key,
    required this.institutionCnpj,
    required this.institutionService,
    required this.nodeService,
    required this.reportService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Institution>(
      future: institutionService.findOneByCnpj(institutionCnpj),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final institution = snapshot.data!;

          return FutureBuilder<List<Node>>(
              future: nodeService.findAllByInstitutionId(institution.id!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return NotFound(
                      message:
                          'Não foi possível estabelecer uma conexão com o servidor',
                    );
                  }

                  final nodes = snapshot.data!;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      itemCount: nodes.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isMobile(context)
                            ? 1
                            : isDesktop(context)
                                ? 3
                                : 2,
                        mainAxisExtent: 100,
                        mainAxisSpacing: 20.0,
                        crossAxisSpacing: 20.0,
                      ),
                      itemBuilder: (context, index) {
                        final node = nodes[index];

                        return FutureBuilder<Report>(
                          future:
                              reportService.findAllByNodeMac(node.mac!.value!),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasError) {
                                return SizedBox.shrink();
                              }

                              final report = snapshot.data!;

                              return NodeReport(
                                node: node,
                                report: report,
                                currentTime: DateTime.now(),
                              );
                            }

                            return SizedBox.fromSize(
                              size: Size(280, 100),
                              child: Loading(),
                            );
                          },
                        );
                      },
                    ),
                  );
                }

                return Loading();
              });
        } else if (snapshot.hasError) {
          return NotFound(
            message: 'Não foi possível estabelecer uma conexão com o servidor',
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
