class RegisterStep2Model {
  final String address1;
  final String address2;
  final String location;
  final String country;
  final String pinCode;
  final String state;
  final String district;

  RegisterStep2Model({
    required this.address1,
    required this.address2,
    required this.location,
    required this.country,
    required this.pinCode,
    required this.state,
    required this.district,
  });
  Map<String, dynamic> toJson() {
    return {
      'address1': address1,
      'address2': address2,
      'location': location,
      'countryId': country,
      'zipCode': pinCode,
      'stateId': state,
      'districtId': district,
    };
  }
}
