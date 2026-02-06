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
    // Validate files exist before creating map
    if (!businessLogo.existsSync()) throw 'Business logo file not found';
    if (!companyPanCard.existsSync()) throw 'Company PAN card file not found';
    if (!ownerPanCard.existsSync()) throw 'Owner PAN card file not found';
    if (!ownerIdCard.existsSync()) throw 'Owner ID card file not found';
    if (!gstCertificate.existsSync()) throw 'GST certificate file not found';

    return {
      'businessLogo': businessLogo,
      'companyPan': companyPanCard,
      'ownerPan': ownerPanCard,
      'ownerId': ownerIdCard,
      'gstCertificate': gstCertificate,
    };
  }
}
