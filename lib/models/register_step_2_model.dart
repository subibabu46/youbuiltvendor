class RegisterStep2Model {
  final String address1;
  final String address2;
  final String location;
  final int countryId;
  final String pinCode;
  final int stateId;
  final int districtId;

  RegisterStep2Model({
    required this.address1,
    required this.address2,
    required this.location,
    required this.countryId,
    required this.pinCode,
    required this.stateId,
    required this.districtId,
  });
  Map<String, dynamic> toJson() {
    return {
      'address1': address1,
      'address2': address2,
      'location': location,
      'countryId': countryId,
      'zipCode': pinCode,
      'stateId': stateId,
      'districtId': districtId,
    };
  }
}
