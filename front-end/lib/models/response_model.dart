import 'dart:ui';

class Response {
  dynamic data;
  String? status;
  String? message;

  Response({
    this.data,
    this.status,
    this.message,
  });

  @override
  String toString() {
    return 'Response(data: $data, status: $status, message: $message)';
  }

  Response.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'status': status,
      'message': message,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Response &&
        other.data == data &&
        other.status == status &&
        other.message == message;
  }

  @override
  int get hashCode => hashValues(data, status, message);
}

class ResponseStatus {
  static const String success = 'SUCCESS', error = 'ERROR';
}
