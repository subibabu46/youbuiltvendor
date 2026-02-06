class ResponseModel {
  final bool status;
  final String message;
  final Map<String, dynamic>? data;

  ResponseModel({required this.status, required this.message, this.data});

  factory ResponseModel.success(Map<String, dynamic> json) {
    return ResponseModel(
      status: true,
      message: json['message'] ?? 'Success',
      data: json['data'],
    );
  }

  factory ResponseModel.error(Map<String, dynamic> json) {
    return ResponseModel(
      status: false,
      message: json['message'] ?? 'Success',
      data: json['data'],
    );
  }
}
