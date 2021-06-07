import 'package:co2monitor/config/palette.dart';
import 'package:co2monitor/models/models.dart';
import 'package:co2monitor/widgets/responsive_widget.dart';
import 'package:co2monitor/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'home_page_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Wrap(
          direction: Axis.vertical,
          children: <Widget>[
            Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 3.0, 10.0, 3.0),
                  child: AspectRatio(
                    aspectRatio: 937 / 227,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: FutureBuilder<Institution>(
        future: fetchInstitution(institutionCnpj),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final institution = snapshot.data!;

            return FutureBuilder<List<Node>>(
                future: fetchInstitutionNodes(institution.id!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return NotFound(
                        imageName: 'assets/images/sorry_emoji.png',
                        textMessage:
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
                          /*return Container(
                            color: Color((math.Random().nextDouble() * 0xFFFFFF)
                                    .toInt())
                                .withOpacity(1.0),
                            constraints:
                                BoxConstraints(maxHeight: 100, maxWidth: 116),
                          );*/
                          final node = nodes[index];

                          return FutureBuilder<Report>(
                            future: fetchLastNodeReport(node.mac!.value!),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasError) {
                                  return SizedBox.shrink();
                                }

                                final report = snapshot.data!;

                                return ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxHeight: 100,
                                      maxWidth: 280,
                                      minHeight: 100,
                                      minWidth: 280),
                                  child: NodeReport(
                                    node: node,
                                    report: report,
                                    currentTime: DateTime.now(),
                                  ),
                                );
                              }

                              return SizedBox.fromSize(
                                size: Size(280, 100),
                                child: Container(
                                  color: Palette.swatchColor[50],
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  }

                  return Container(
                    color: Palette.swatchColor[50],
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return NotFound(
              imageName: 'assets/images/sorry_emoji.png',
              textMessage:
                  'Não foi possível estabelecer uma conexão com o servidor',
            );
          } else {
            return Container(
              color: Palette.swatchColor[50],
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
