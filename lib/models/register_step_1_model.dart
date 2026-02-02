class RegisterStep1Model {
  final String businessName;
  final String ownerName;
  final String businessEmail;
  final String ownerEmail;
  final String companyOfficialNumber;
  final String companyOfficialNumberCode;
  final String phoneNumber;
  final String code;
  final String companyPANNumber;
  final String ownerPanNumber;
  final String gstNumber;
  final String ownerIdNumber;
  final String type;
  final String businessType;

  RegisterStep1Model({
    required this.businessName,
    required this.ownerName,
    required this.businessEmail,
    required this.ownerEmail,
    required this.companyOfficialNumber,
    required this.phoneNumber,
    required this.code,
    required this.companyPANNumber,
    required this.ownerPanNumber,
    required this.gstNumber,
    required this.ownerIdNumber,
    required this.type,
    required this.companyOfficialNumberCode,
    required this.businessType,
  });
  Map<String, dynamic> toJson() {
    return {
      'businessName': businessName,
      'name': ownerName,
      'businessEmail': businessEmail,
      'email': ownerEmail,
      'phoneNumber': phoneNumber,
      'code': code,
      'OfficialNumber': companyOfficialNumber,
      'OfficialNumbercode': companyOfficialNumberCode,
      'companyPanNumber': companyPANNumber,
      'panNumber': ownerPanNumber,
      'gst': gstNumber,
      'ownerId': ownerIdNumber,
      'type': type,
      'businessType': businessType,
    };
  }
}
