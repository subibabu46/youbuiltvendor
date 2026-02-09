import 'dart:developer';
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

  Future<ResponseModel> fetchCountryCodes() async {
    return _apiCallHelper(
      'fetchCountryCodes',
      () => storeService.fetchCountryCodes(),
      label: 'CountryCode',
    );
  }

  Future<ResponseModel> fetchBusinessTypes() async {
    return _apiCallHelper(
      'fetchBusinessTypes',
      () => storeService.fetchBusinessTypes(),
      label: 'BusinessTypeDropDown',
    );
  }

  Future<ResponseModel> fetchCountries() async {
    return _apiCallHelper(
      'fetchCountries',
      () => storeService.fetchCountries(),
      label: 'CountryDropDown',
    );
  }

  Future<ResponseModel> fetchStates(String pinCode) async {
    return _apiCallHelper(
      'fetchStates',
      () => storeService.fetchStates(pinCode),
      label: 'StatesDropDown',
    );
  }

  Future<ResponseModel> fetchDistricts(String pinCode) async {
    return _apiCallHelper(
      'fetchDistricts',
      () => storeService.fetchDistricts(pinCode),
      label: 'DistrictDropDown',
    );
  }

  Future<ResponseModel> sendOtp(UserModel userInfo) async {
    final data = userInfo.toJson();
    return _apiCallHelper(
      'sendOtp',

      putData: data,
      () => storeService.sendOtp(data),
    );
  }

  Future<ResponseModel> verifyOtp(OtpModel otpInfo) async {
    final data = otpInfo.toJson();
    return _apiCallHelper(
      'sendOtp',

      putData: data,
      () => storeService.verifyOtp(data),
    );
  }

  Future<ResponseModel> registerStep1(
    RegisterStep1Model registerStep1Info,
  ) async {
    final data = registerStep1Info.toJson();

    return _apiCallHelper(
      'registerStep1',
      putData: data,
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

      putData: data,
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

      putData: data,
      () => storeService.registerStep3(data, stepId),
      id: stepId,
    );
  }

  Future<ResponseModel> _apiCallHelper(
    String name,

    Future<Response> Function() apiCall, {
    String? label,
    int? id,
    dynamic putData,
  }) async {
    try {
      log('=== Starting $name ===');
      if (id != null) log('Step ID: $id');
      if (putData != null) log('Data: $putData');

      final response = await apiCall();

      log('API call completed. Status code: ${response.statusCode}');
      log('Response data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('$name successful');
        return ResponseModel.success(response.data, label: label);
      } else if (response.statusCode == 400 || response.statusCode == 404) {
        log('$name returned client error');
        return ResponseModel.error(response.data, label: label);
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
