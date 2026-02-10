import 'dart:io';

import 'package:design_task_1/constants/api_key.dart';
import 'package:dio/dio.dart';

import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class StoreService {
  late final Dio dio = Dio(
    BaseOptions(
      baseUrl: Api.key,
      headers: {"Content-Type": "application/json"},
    ),
  );

  Future<Response> fetchCountryCodes() async {
    try {
      final response = await dio.get(Api.countryCode);

      return response;
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ??
          e.response?.data['error'] ??
          'Something went wrong';

      throw message;
    } catch (e) {
      throw 'Unexpected error occurred';
    }
  }

  Future<Response> fetchBusinessTypes() async {
    try {
      final response = await dio.get(Api.businessType);

      return response;
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ??
          e.response?.data['error'] ??
          'Something went wrong';

      throw message;
    } catch (e) {
      throw 'Unexpected error occurred';
    }
  }

  Future<Response> fetchCountries() async {
    try {
      final response = await dio.get(Api.countries);

      return response;
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ??
          e.response?.data['error'] ??
          'Something went wrong';

      throw message;
    } catch (e) {
      throw 'Unexpected error occurred';
    }
  }

  Future<Response> fetchStates(String pinCode) async {
    try {
      final response = await dio.get("${Api.states}$pinCode");

      return response;
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ??
          e.response?.data['error'] ??
          'Something went wrong';

      throw message;
    } catch (e) {
      throw 'Unexpected error occurred';
    }
  }

  Future<Response> fetchDistricts(String pinCode) async {
    try {
      final response = await dio.get("${Api.districts}$pinCode");

      return response;
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ??
          e.response?.data['error'] ??
          'Something went wrong';

      throw message;
    } catch (e) {
      throw 'Unexpected error occurred';
    }
  }

  Future<Response> sendOtp(Map<String, dynamic> data) async {
    try {
      final response = await dio.post(Api.sendOtp, data: data);

      return response;
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ??
          e.response?.data['error'] ??
          'Something went wrong';

      throw message;
    } catch (e) {
      throw 'Unexpected error occurred';
    }
  }

  Future<Response> resendOtp(Map<String, dynamic> data) async {
    try {
      final response = await dio.post(Api.resendOtp, data: data);

      return response;
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ??
          e.response?.data['error'] ??
          'Something went wrong';

      throw message;
    } catch (e) {
      throw 'Unexpected error occurred';
    }
  }

  Future<Response> verifyOtp(Map<String, dynamic> data) async {
    try {
      final response = await dio.post(Api.verifyOtp, data: data);

      return response;
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ??
          e.response?.data['error'] ??
          'Something went wrong';

      throw message;
    } catch (e) {
      throw 'Unexpected error occurred';
    }
  }

  Future<Response> login(Map<String, dynamic> data) async {
    try {
      final response = await dio.post(Api.login, data: data);

      return response;
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ??
          e.response?.data['error'] ??
          'Something went wrong';

      throw message;
    } catch (e) {
      throw 'Unexpected error occurred';
    }
  }

  Future<Response> registerStep1(Map<String, dynamic> data) async {
    try {
      final response = await dio.post(Api.registerStep1, data: data);

      return response;
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ??
          e.response?.data['error'] ??
          'Something went wrong';

      throw message;
    } catch (e) {
      throw 'Unexpected error occurred';
    }
  }

  Future<Response> registerStep2(Map<String, dynamic> data, int stepId) async {
    try {
      final response = await dio.patch(
        "${Api.registerStep2}$stepId",
        data: data,
      );

      return response;
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ??
          e.response?.data['error'] ??
          'Something went wrong';

      throw message;
    } catch (e) {
      throw 'Unexpected error occurred';
    }
  }

  // Future<Response> registerStep3(Map<String, dynamic> data, int stepId) async {
  //   try {
  //     final formData = FormData();

  //     print('=== Starting registerStep3 ===');
  //     print('Step ID: $stepId');

  //     for (var entry in data.entries) {
  //       final value = entry.value;
  //       if (value == null) continue;

  //       if (value is File) {
  //         final mimeType =
  //             lookupMimeType(value.path) ?? 'application/octet-stream';
  //         final parts = mimeType.split('/');

  //         formData.files.add(
  //           MapEntry(
  //             entry.key,
  //             await MultipartFile.fromFile(
  //               value.path,
  //               filename: value.path.split('/').last,
  //               contentType: MediaType(parts[0], parts[1]),
  //             ),
  //           ),
  //         );
  //       } else {
  //         formData.fields.add(MapEntry(entry.key, value.toString()));
  //       }
  //     }

  //     final response = await dio.patch(
  //       "/api/users/registrationStep3/$stepId",
  //       data: formData,
  //       options: Options(headers: {'Content-Type': 'multipart/form-data'}),
  //     );

  //     return response;
  //   } on DioException catch (e) {
  //     print('DioException details:');
  //     print('Status code: ${e.response?.statusCode}');
  //     print('Response data: ${e.response?.data}');
  //     print('Error type: ${e.type}');

  //     // Extract more specific error message
  //     if (e.response?.statusCode == 500) {
  //       final errorData = e.response?.data;
  //       if (errorData is Map && errorData.containsKey('error')) {
  //         final error = errorData['error'];
  //         if (error is Map && error.containsKey('name')) {
  //           throw 'Server validation error: ${error['name']}. Please contact support.';
  //         }
  //       }
  //       throw 'Server error occurred. Please try again later.';
  //     }

  //     final message =
  //         e.response?.data['message'] ??
  //         e.response?.data['error'] ??
  //         'Something went wrong';
  //     throw message;
  //   } catch (e) {
  //     print('Unexpected error: $e');
  //     throw 'Unexpected error occurred';
  //   }
  // }
  Future<Response> registerStep3(Map<String, dynamic> data, int stepId) async {
    final formData = FormData();

    for (var entry in data.entries) {
      final value = entry.value;
      if (value == null) continue;

      if (value is File) {
        final mimeType =
            lookupMimeType(value.path) ?? 'application/octet-stream';
        final parts = mimeType.split('/');

        formData.files.add(
          MapEntry(
            entry.key,
            await MultipartFile.fromFile(
              value.path,
              filename: value.path.split('/').last,
              contentType: MediaType(parts[0], parts[1]),
            ),
          ),
        );
      } else {
        formData.fields.add(MapEntry(entry.key, value.toString()));
      }
    }

    return dio.patch(
      "${Api.registerStep3}$stepId",
      data: formData,
      options: Options(headers: {'Content-Type': 'multipart/form-data'}),
    );
  }
}
