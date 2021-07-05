class Cnpj {
  String? value;

  Cnpj({this.value});

  @override
  String toString() => 'Cnpj(value: $value)';

  Cnpj.fromJson(Map<String, dynamic> json) {
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
    return other is Cnpj && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
