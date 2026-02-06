import 'dart:developer';
import 'package:design_task_1/models/get_model.dart';
import 'package:design_task_1/models/otp_model.dart';
import 'package:design_task_1/models/register_step_1_model.dart';
import 'package:design_task_1/models/register_step_2_model.dart';
import 'package:design_task_1/models/register_step_3_model.dart';
import 'package:design_task_1/models/response_model.dart';
import 'package:design_task_1/models/user_model.dart';
import 'package:design_task_1/services/store_service.dart';

class StoreRepository {
  final StoreService storeService;

  StoreRepository({required this.storeService});

  Future<List<GetModel>> fetchCountryCodes() async {
    try {
      final response = await storeService.fetchCountryCodes();
      log('fetchCountryCode: ${response.data}');
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        final countryCodesJson = data["CountryCode"] as List<dynamic>;
        final countryCodes = countryCodesJson
            .map((e) => GetModel.fromJson(e))
            .toList();
        return countryCodes;
      }

      return [];
    } catch (e) {
      log('fetchCountryCodes: $e');
      rethrow;
    }
  }

  Future<List<GetModel>> fetchBusinessTypes() async {
    try {
      final response = await storeService.fetchBusinessTypes();
      log('fetchBusinessTypes: ${response.data}');
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        final businessTypesJson = data["BusinessTypeDropDown"] as List<dynamic>;
        final businessTypes = businessTypesJson
            .map((e) => GetModel.fromJson(e))
            .toList();
        return businessTypes;
      }

      return [];
    } catch (e) {
      log('fetchBusinessTypes: $e');
      rethrow;
    }
  }

  Future<List<GetModel>> fetchCountries() async {
    try {
      final response = await storeService.fetchCountries();
      log('fetchCountries: ${response.data}');
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        final countriesJson = data["CountryDropDown"] as List<dynamic>;
        final countries = countriesJson
            .map((e) => GetModel.fromJson(e))
            .toList();
        return countries;
      }

      return [];
    } catch (e) {
      log('fetchCountries: $e');
      rethrow;
    }
  }

  Future<List<GetModel>> fetchStates(String pinCode) async {
    try {
      final response = await storeService.fetchStates(pinCode);
      log('fetchStates: ${response.data}');
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        final statesJson = data["StatesDropDown"] as List<dynamic>;
        final states = statesJson.map((e) => GetModel.fromJson(e)).toList();
        return states;
      }

      return [];
    } catch (e) {
      log('fetchStates: $e');
      rethrow;
    }
  }

  Future<List<GetModel>> fetchDistricts(String pinCode) async {
    try {
      final response = await storeService.fetchDistricts(pinCode);
      log('fetchDistricts: ${response.data}');
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        final districtsJson = data["DistrictDropDown"] as List<dynamic>;
        final districts = districtsJson
            .map((e) => GetModel.fromJson(e))
            .toList();
        return districts;
      }

      return [];
    } catch (e) {
      log('fetchDistricts: $e');
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

  Future<ResponseModel> registerStep2(
    RegisterStep2Model registerStep2Info,
    stepId,
  ) async {
    try {
      final data = registerStep2Info.toJson();
      final response = await storeService.registerStep2(data, stepId);
      log('registerStep2: ${response.data}');

      if (response.statusCode == 200) {
        return ResponseModel.fromJson(response.data);
      }

      return ResponseModel.fromJson(response.data);
    } catch (e) {
      log('registerStep2: $e');
      rethrow;
    }
  }

  Future<ResponseModel> registerStep3(
    RegisterStep3Model registerStep3Info,
    stepId,
  ) async {
    try {
      final data = registerStep3Info.toJson();
      final response = await storeService.registerStep3(data, stepId);
      log('registerStep3: ${response.data}');

      if (response.statusCode == 200) {
        return ResponseModel.fromJson(response.data);
      }

      return ResponseModel.fromJson(response.data);
    } catch (e) {
      log('registerStep3: $e');
      rethrow;
    }
  }
}
