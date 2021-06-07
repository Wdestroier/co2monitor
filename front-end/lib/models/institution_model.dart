import 'dart:ui';

import 'cnpj_model.dart';

class Institution {
  String? id;
  DateTime? creationDate;
  String? name;
  Cnpj? cnpj;

  Institution({
    this.id,
    this.creationDate,
    this.name,
    this.cnpj,
  });

  @override
  String toString() {
    return 'Institution(id: $id, creationDate: $creationDate, name: $name, cnpj: $cnpj)';
  }

  Institution.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creationDate = json['creationDate'] == null
        ? null
        : DateTime.tryParse(json['creationDate']);
    name = json['name'];
    cnpj = json['cnpj'] == null ? null : Cnpj.fromJson(json['cnpj']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creationDate': creationDate?.toIso8601String(),
      'name': name,
      'cnpj': cnpj?.toJson(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Institution &&
        other.id == id &&
        other.creationDate == creationDate &&
        other.name == name &&
        other.cnpj == cnpj;
  }

  @override
  int get hashCode => hashValues(id, creationDate, name, cnpj);
}
