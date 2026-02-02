class ResponseModel {
  final bool status;
  final String message;

  ResponseModel({required this.status, required this.message});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    final status = json['status'];
    bool statusBool;
    if (status == 200) {
      statusBool = true;
    } else if (status is bool) {
      statusBool = status;
    } else {
      statusBool = false;
    }

    return ResponseModel(status: statusBool, message: json['message'] ?? '');
  }
}
