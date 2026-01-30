class CountryCode {
  final int value;
  final String label;

  CountryCode({required this.value, required this.label});

  factory CountryCode.fromJson(Map<String, dynamic> json) {
    return CountryCode(value: json['value'], label: json['label']);
  }
}
