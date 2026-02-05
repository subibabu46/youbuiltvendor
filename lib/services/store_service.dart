import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

class StoreService {
  late final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://youbuilt-jrqd6.ondigitalocean.app",
      headers: {"Content-Type": "application/json"},
    ),
  );

  Future<Response> fetchCountryCodes() async {
    try {
      final response = await dio.get("/api/stores/countryCodeDropDown");

      return response;
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ?? e.message ?? 'Something went wrong';

      throw message;
    } catch (e) {
      throw 'Unexpected error occurred';
    }
  }

  Future<Response> fetchBusinessTypes() async {
    try {
      final response = await dio.get("/api/users/businessTypeDropDown");

      return response;
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ?? e.message ?? 'Something went wrong';

      throw message;
    } catch (e) {
      throw 'Unexpected error occurred';
    }
  }

  Future<Response> fetchCountries() async {
    try {
      final response = await dio.get("/api/users/countryDropDown");

      return response;
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ?? e.message ?? 'Something went wrong';

      throw message;
    } catch (e) {
      throw 'Unexpected error occurred';
    }
  }

  Future<Response> fetchStates(String pinCode) async {
    try {
      final response = await dio.get(
        "/api/users/statesDropDown?pinCode=$pinCode",
      );

      return response;
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ?? e.message ?? 'Something went wrong';

      throw message;
    } catch (e) {
      throw 'Unexpected error occurred';
    }
  }

  Future<Response> fetchDistricts(String pinCode) async {
    try {
      final response = await dio.get(
        "/api/users/districtDropDown?pinCode=$pinCode",
      );

      return response;
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ?? e.message ?? 'Something went wrong';

      throw message;
    } catch (e) {
      throw 'Unexpected error occurred';
    }
  }

  Future<Response> sendOtp(Map<String, dynamic> data) async {
    try {
      final response = await dio.post("/api/users/sendOtp", data: data);

      return response;
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ?? e.message ?? 'Something went wrong';

      throw message;
    } catch (e) {
      throw 'Unexpected error occurred';
    }
  }

  Future<Response> verifyOtp(Map<String, dynamic> data) async {
    try {
      final response = await dio.post("/api/users/verifyOtp", data: data);

      return response;
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ?? e.message ?? 'Something went wrong';

      throw message;
    } catch (e) {
      throw 'Unexpected error occurred';
    }
  }

  Future<Response> registerStep1(Map<String, dynamic> data) async {
    try {
      final response = await dio.post(
        "/api/users/registrationStep1",
        data: data,
      );

      return response;
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ?? e.message ?? 'Something went wrong';

      throw message;
    } catch (e) {
      throw 'Unexpected error occurred';
    }
  }

  Future<Response> registerStep2(Map<String, dynamic> data, int stepId) async {
    try {
      final response = await dio.patch(
        "/api/users/registrationStep2/$stepId",
        data: data,
      );

      return response;
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ?? e.message ?? 'Something went wrong';

      throw message;
    } catch (e) {
      throw 'Unexpected error occurred';
    }
  }

  // Future<Object> registerStep3(Map<String, dynamic> data, int stepId) async {
  //   try {
  //     final uri = Uri.parse(
  //       'https://youbuilt-jrqd6.ondigitalocean.app//api/users/registrationStep3/$stepId',
  //     );
  //     final request = http.MultipartRequest('PATCH', uri);
  //    // request.headers['Authorization'] = "Bearer ${accessToken ?? ""}";

  //     for (var entry in data.entries) {
  //       final File? file = entry.value;

  //       if (file != null && await file.exists()) {
  //         final fileName = path.basename(file.path);
  //         final ext = fileName.split('.').last.toLowerCase();
  //         MediaType mediaType;
  //         if (ext == 'png') {
  //           mediaType = MediaType('image', 'png');
  //         } else if (ext == 'jpg' || ext == 'jpeg') {
  //           mediaType = MediaType('image', 'jpeg');
  //         } else if (ext == 'pdf') {
  //           mediaType = MediaType('application', 'pdf');
  //         } else {
  //           mediaType = MediaType('application', 'octet-stream');
  //         }
  //         request.files.add(
  //           await http.MultipartFile.fromPath(
  //             'file', //
  //             file.path,
  //             filename: fileName,
  //             contentType: mediaType,
  //           ),
  //         );
  //       }
  //       final streamedResponse = await request.send();
  //       final response = await http.Response.fromStream(streamedResponse);
  //       return response;
  //     }

  //     final formData = FormData();

  //     for (var entry in data.entries) {
  //       final value = entry.value;

  //       if (value == null) continue;

  //       if (value is File) {
  //         formData.files.add(
  //           MapEntry(
  //             entry.key,
  //             await MultipartFile.fromFile(
  //               value.path,
  //               filename: path.basename(value.path),
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
  //       options: Options(contentType: 'multipart/form-data'),
  //     );

  //     return response;
  //   } on DioException catch (e) {
  //     final message =
  //         e.response?.data['message'] ?? e.message ?? 'Something went wrong';

  //     throw message;
  //   } catch (e) {
  //     throw 'Unexpected error occurred';
  //   }
  //   }  Future<Response> registerStep3(Map<String, dynamic> data, int stepId) async {
  //     try {
  //       final formData = FormData();

  //       for (var entry in data.entries) {
  //         final value = entry.value;

  //         if (value == null) continue;

  //         if (value is File) {
  //           formData.files.add(
  //             MapEntry(
  //               entry.key,
  //               await MultipartFile.fromFile(
  //                 value.path,
  //                 filename: path.basename(value.path),
  //               ),
  //             ),
  //           );
  //         } else {
  //           formData.fields.add(MapEntry(entry.key, value.toString()));
  //         }
  //       }

  //       final response = await dio.patch(
  //         "/api/users/registrationStep3/$stepId",
  //         data: formData,
  //         options: Options(contentType: 'multipart/form-data'),
  //       );

  //       return response;
  //     } on DioException catch (e) {
  //       final message =
  //           e.response?.data['message'] ?? e.message ?? 'Something went wrong';

  //       throw message;
  //     } catch (e) {
  //       throw 'Unexpected error occurred';
  //     }
  // }
  Future<http.Response> registerStep3(
    Map<String, dynamic> data,
    int stepId,
  ) async {
    log(data.values.toString());
    final files = {
      'businessLogo': data['businessLogo'],
      'companyPan': data['companyPan'],
      'ownerPan': data['ownerPan'],
      'ownerId': data['ownerId'],
      'gstCertificate': data['gstCertificate'],
    };
    try {
      final uri = Uri.parse(
        "https://youbuilt-jrqd6.ondigitalocean.app/api/users/registrationStep3/$stepId",
      );

      final request = http.MultipartRequest('PATCH', uri);

      request.headers.addAll({
        'Accept': 'application/json',
        // 'Authorization': 'Bearer ${accessToken ?? ""}',
      });
      for (var entry in files.entries) {
        final value = entry.value;

        if (value is File && await value.exists()) {
          final fileName = path.basename(value.path);
          final ext = fileName.split('.').last.toLowerCase();

          MediaType mediaType;
          if (ext == 'png') {
            mediaType = MediaType('image', 'png');
          } else if (ext == 'jpg' || ext == 'jpeg') {
            mediaType = MediaType('image', 'jpeg');
          } else if (ext == 'pdf') {
            mediaType = MediaType('application', 'pdf');
          } else {
            mediaType = MediaType('application', 'octet-stream');
          }

          request.files.add(
            await http.MultipartFile.fromPath(
              entry.key,
              value.path,
              filename: fileName,
              contentType: mediaType,
            ),
          );
        } else {
          request.fields['businessLogo'] = value.toString();
        }
      }
      debugPrint("URL: $uri");
      debugPrint("HEADERS: ${request.headers}");
      request.fields.forEach((k, v) => debugPrint("FIELD $k: $v"));
      for (final f in request.files) {
        debugPrint(
          "FILE field=${f.field}, filename=${f.filename}, type=${f.contentType}",
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response;
      } else {
        final decoded = jsonDecode(response.body);
        throw decoded
            .toString(); //decoded['message'] ?? 'Something went wrong';
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
