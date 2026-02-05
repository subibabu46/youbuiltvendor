import 'dart:io';

class RegisterStep3Model {
  final File businessLogo;
  final File companyPanCard;
  final File ownerPanCard;
  final File ownerIdCard;
  final File gstCertificate;

  RegisterStep3Model({
    required this.businessLogo,
    required this.companyPanCard,
    required this.ownerPanCard,
    required this.ownerIdCard,
    required this.gstCertificate,
  });
  Map<String, dynamic> toJson() {
    return {
      'businessLogo': businessLogo,
      'companyPan': companyPanCard,
      'ownerPan': ownerPanCard,
      'ownerId': ownerIdCard,
      'gstCertificate': gstCertificate,
    };
  }
}
