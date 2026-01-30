class UserModel {
  final String name;
  final String code;
  final String type;
  final String phoneNumber;

  UserModel({
    required this.phoneNumber,
    required this.name,
    required this.code,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      "phoneNumber": phoneNumber,
      "code": code,
      "type": type,
      "name": name,
    };
  }
}
