class LoginModel {
  final String phoneNumber;
  final String password;

  LoginModel({required this.phoneNumber, required this.password});

  Map<String, dynamic> toJson() {
    return {'phoneNumber': phoneNumber, 'password': password};
  }
}
