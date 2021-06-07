class Mac {
  String? value;

  Mac({this.value});

  @override
  String toString() => 'Mac(value: $value)';

  Mac.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Mac && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
