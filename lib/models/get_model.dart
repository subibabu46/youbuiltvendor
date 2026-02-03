class GetModel {
  final int value;
  final String label;

  GetModel({required this.value, required this.label});

  factory GetModel.fromJson(Map<String, dynamic> json) {
    return GetModel(value: json['value'], label: json['label']);
  }
}
