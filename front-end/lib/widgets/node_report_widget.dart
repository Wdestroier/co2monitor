import 'package:co2monitor/config/palette.dart';
import 'package:co2monitor/domain/models/models.dart';
import 'package:flutter/material.dart';

class NodeReport extends StatelessWidget {
  final Node node;
  final Report report;
  final DateTime currentTime;

  const NodeReport({
    Key? key,
    required this.node,
    required this.report,
    required this.currentTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 100,
      decoration: BoxDecoration(
        color: getSeverityColor(report.ppm!),
        borderRadius: BorderRadius.circular(12.0),
      ),
      clipBehavior: Clip.hardEdge,
      child: Row(
        children: [
          SizedBox(
            width: 116,
            height: 100,
            child: Image.network(
              node.imageUrl!,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    node.name!,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Palette.swatchColor[900],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${report.ppm!} ppm',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Palette.swatchColor[900],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Atualizado há ${getFormattedCreationDate(currentTime, report.creationDate!)}',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Palette.swatchColor[900],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getFormattedCreationDate(DateTime currentTime, DateTime creationDate) {
    final diff = currentTime.difference(creationDate);

    String formattedDate;

    if (diff.inMinutes < 60) {
      formattedDate = '${diff.inMinutes}min';
    } else if (diff.inHours < 60) {
      formattedDate = '${diff.inHours}h';
    } else if (diff.inDays < 30) {
      formattedDate = '${diff.inDays}d';
    } else if (diff.inDays < 365) {
      formattedDate = '${(diff.inDays / 30).ceil()}m';
    } else {
      formattedDate = '${(diff.inDays / 365).ceil()}y';
    }

    return formattedDate;
  }

  MaterialAccentColor getSeverityColor(int ppm) {
    MaterialAccentColor severityColor;

    if (ppm < 600) {
      severityColor = Colors.greenAccent;
    } else if (ppm < 1000) {
      severityColor = Colors.yellowAccent;
    } else {
      severityColor = Colors.redAccent;
    }

    return severityColor;
  }
}
