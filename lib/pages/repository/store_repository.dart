import 'package:design_task_1/models/country_code.dart';
import 'package:design_task_1/models/otp_model.dart';
import 'package:design_task_1/models/user_model.dart';
import 'package:design_task_1/services/store_service.dart';

class StoreRepository {
  final StoreService storeService;

  StoreRepository({required this.storeService});

  Future<List<CountryCode>> fetchCountryCodes() async {
    try {
      final response = await storeService.fetchCountryCodes();

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        final countryCodesJson = data["CountryCode"] as List<dynamic>;
        final countryCodes = countryCodesJson
            .map((e) => CountryCode.fromJson(e))
            .toList();
        return countryCodes;
      }

      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> postUserInfo(UserModel userInfo) async {
    try {
      final data = userInfo.toJson();
      final response = await storeService.postUserInfo(data);

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> verifyOtp(OtpModel otpInfo) async {
    try {
      final data = otpInfo.toJson();
      final response = await storeService.postUserInfo(data);

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      rethrow;
    }
  }
}
