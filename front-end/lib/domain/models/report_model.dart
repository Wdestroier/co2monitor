import 'dart:ui';

class Report {
  String? id;
  DateTime? creationDate;
  String? nodeMac;
  int? ppm;

  Report({
    this.id,
    this.creationDate,
    this.nodeMac,
    this.ppm,
  });

  Report.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creationDate = json['creationDate'] == null
        ? null
        : DateTime.tryParse(json['creationDate']);
    nodeMac = json['nodeMac'];
    ppm = json['ppm'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creationDate': creationDate?.toIso8601String(),
      'nodeMac': nodeMac,
      'ppm': ppm,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Report &&
        other.id == id &&
        other.creationDate == creationDate &&
        other.nodeMac == nodeMac &&
        other.ppm == ppm;
  }

  @override
  String toString() {
    return 'Report(id: $id, creationDate: $creationDate, nodeMac: $nodeMac, ppm: $ppm)';
  }

  @override
  int get hashCode => hashValues(id, creationDate, nodeMac, ppm);
}
