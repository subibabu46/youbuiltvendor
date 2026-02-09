class ResponseModel {
  final bool status;
  final String message;
  final dynamic data;

  ResponseModel({required this.status, required this.message, this.data});

  factory ResponseModel.success(Map<String, dynamic> json, {String? label}) {
    return ResponseModel(
      status: true,
      message: json['message'] ?? 'Success',
      data:
          (label != null &&
              json.containsKey(label) &&
              json[label] != null &&
              json[label] is List &&
              json[label] is List)
          ? (json[label] as List).map((e) => GetModel.fromJson(e)).toList()
          : json['data'] ?? {},
    );
  }

  factory ResponseModel.error(Map<String, dynamic> json, {String? label}) {
    return ResponseModel(
      status: false,
      message: json['message'] ?? 'Error',
      data: (label != null && json[label] is List)
          ? (json[label] as List).map((e) => GetModel.fromJson(e)).toList()
          : json['data'] ?? {},
    );
  }
}

class GetModel {
  final int value;
  final String label;

  GetModel({required this.value, required this.label});

  factory GetModel.fromJson(Map<String, dynamic> json) {
    return GetModel(value: json['value'], label: json['label']);
  }
  factory GetModel.empty() => GetModel(value: 0, label: 'empty');
}
