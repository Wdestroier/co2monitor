import 'dart:ui';

import 'mac_model.dart';

class Node {
  String? id;
  DateTime? creationDate;
  String? name;
  Mac? mac;
  String? institutionId;
  String? imageUrl;

  Node({
    this.id,
    this.creationDate,
    this.name,
    this.mac,
    this.institutionId,
    this.imageUrl,
  });

  @override
  String toString() {
    return 'Node(id: $id, creationDate: $creationDate, name: $name, mac: $mac, institutionId: $institutionId, imageUrl: $imageUrl)';
  }

  Node.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creationDate = json['creationDate'] == null
        ? null
        : DateTime.tryParse(json['creationDate']);
    name = json['name'];
    mac = json['mac'] == null ? null : Mac.fromJson(json['mac']);
    institutionId = json['institutionId'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creationDate': creationDate?.toIso8601String(),
      'name': name,
      'mac': mac?.toJson(),
      'institutionId': institutionId,
      'imageUrl': imageUrl,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Node &&
        other.id == id &&
        other.creationDate == creationDate &&
        other.name == name &&
        other.mac == mac &&
        other.institutionId == institutionId &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return hashValues(
      id,
      creationDate,
      name,
      mac,
      institutionId,
      imageUrl,
    );
  }
}
