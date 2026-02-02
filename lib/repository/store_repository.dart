import 'dart:developer';

import 'package:design_task_1/models/country_code.dart';
import 'package:design_task_1/models/otp_model.dart';
import 'package:design_task_1/models/register_step_1_model.dart';
import 'package:design_task_1/models/response_model.dart';
import 'package:design_task_1/models/user_model.dart';
import 'package:design_task_1/services/store_service.dart';

class StoreRepository {
  final StoreService storeService;

  StoreRepository({required this.storeService});

  Future<List<CountryCode>> fetchCountryCodes() async {
    try {
      final response = await storeService.fetchCountryCodes();
      log('fetchCountryCode: ${response.data}');
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
      log('fetchCountryCode: $e');
      rethrow;
    }
  }

  Future<ResponseModel> sendOtp(UserModel userInfo) async {
    try {
      final data = userInfo.toJson();
      final response = await storeService.sendOtp(data);
      log('sendOtp: ${response.data}');
      if (response.statusCode == 200) {
        return ResponseModel.fromJson(response.data);
      } else {
        return ResponseModel.fromJson(response.data);
      }
    } catch (e) {
      log('sendOtp: $e');
      rethrow;
    }
  }

  Future<ResponseModel> verifyOtp(OtpModel otpInfo) async {
    try {
      final data = otpInfo.toJson();
      final response = await storeService.verifyOtp(data);
      log('verifyOtp: ${response.data}');

      if (response.statusCode == 200) {
        return ResponseModel.fromJson(response.data);
      }

      return ResponseModel.fromJson(response.data);
    } catch (e) {
      log('verifyOtp: $e');
      rethrow;
    }
  }

  Future<ResponseModel> registerStep1(
    RegisterStep1Model registerStep1Info,
  ) async {
    try {
      final data = registerStep1Info.toJson();
      final response = await storeService.registerStep1(data);
      log('registerStep1: ${response.data}');

      if (response.statusCode == 200) {
        return ResponseModel.fromJson(response.data);
      }

      return ResponseModel.fromJson(response.data);
    } catch (e) {
      log('registerStep1: $e');
      rethrow;
    }
  }
}
