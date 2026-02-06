import 'dart:developer';
import 'package:design_task_1/models/get_model.dart';
import 'package:design_task_1/models/otp_model.dart';
import 'package:design_task_1/models/register_step_1_model.dart';
import 'package:design_task_1/models/register_step_2_model.dart';
import 'package:design_task_1/models/register_step_3_model.dart';
import 'package:design_task_1/models/response_model.dart';
import 'package:design_task_1/models/user_model.dart';
import 'package:design_task_1/services/store_service.dart';
import 'package:dio/dio.dart';

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
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ResponseModel.success(response.data);
      } else if (response.statusCode == 400 || response.statusCode == 404) {
        return ResponseModel.error(response.data);
      } else {
        return ResponseModel.error(response.data);
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
        return ResponseModel.success(response.data);
      }

      return ResponseModel.error(response.data);
    } catch (e) {
      log('verifyOtp: $e');
      rethrow;
    }
  }

  Future<ResponseModel> registerStep1(
    RegisterStep1Model registerStep1Info,
  ) async {
    final data = registerStep1Info.toJson();

    return _apiCallHelper(
      'registerStep1',
      data,
      () => storeService.registerStep1(data),
    );
  }

  Future<ResponseModel> registerStep2(
    RegisterStep2Model registerStep2Info,
    stepId,
  ) {
    final data = registerStep2Info.toJson();
    return _apiCallHelper(
      'registerStep2',

      data,
      () => storeService.registerStep2(data, stepId),
      id: stepId,
    );
  }

  Future<ResponseModel> registerStep3(
    RegisterStep3Model registerStep3Info,
    int stepId,
  ) {
    final data = registerStep3Info.toJson();
    return _apiCallHelper(
      'registerStep3',

      data,
      () => storeService.registerStep3(data, stepId),
      id: stepId,
    );
  }

  Future<ResponseModel> _apiCallHelper(
    String name,

    dynamic inputData,
    Future<Response> Function() apiCall, {
    int? id,
  }) async {
    try {
      log('=== Starting $name ===');
      log('Step ID: $id');
      log('Data: $inputData');

      final response = await apiCall();

      log('API call completed. Status code: ${response.statusCode}');
      log('Response data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('$name successful');
        return ResponseModel.success(response.data);
      } else if (response.statusCode == 400 || response.statusCode == 404) {
        log('$name returned client error');
        return ResponseModel.error(response.data);
      }

      log('$name unexpected status code: ${response.statusCode}');
      throw 'Unexpected status code: ${response.statusCode}';
    } on DioException catch (e) {
      log('DioException occurred in $name');
      log('Status code: ${e.response?.statusCode}');
      log('Response data: ${e.response?.data}');
      log('Error type: ${e.type}');

      final statusCode = e.response?.statusCode;
      final responseData = e.response?.data;

      if (statusCode == 500) {
        final error = responseData?['error'];
        if (error is Map && error['name'] != null) {
          log('Server validation error: ${error['name']}');
          throw 'Server validation error: ${error['name']}';
        }
        log('Server error occurred. Please try again later.');
        throw 'Server error occurred. Please try again later.';
      }

      final message =
          responseData?['message'] ??
          responseData?['error'] ??
          'Something went wrong';
      log('Error message: $message');
      throw message;
    } catch (e) {
      log('Unexpected exception in $name: $e');
      throw e.toString();
    }
  }
}
