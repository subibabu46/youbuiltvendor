class OtpModel {
  final String otp;
  final String code;
  final String type;
  final String phoneNumber;

  OtpModel({
    required this.phoneNumber,
    required this.otp,
    required this.code,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {"phoneNumber": phoneNumber, "code": code, "type": type, "otp": otp};
  }
}
