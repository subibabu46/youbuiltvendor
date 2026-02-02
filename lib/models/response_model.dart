class ResponseModel {
  final bool status;
  final String message;

  ResponseModel({required this.status, required this.message});
  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(status: json['status'], message: json['message']);
  }
}
