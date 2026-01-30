import 'dart:developer';

import 'package:dio/dio.dart';

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
      log(response.toString());
      return response;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Response> postUserInfo(Map<String, dynamic> data) async {
    try {
      final response = await dio.put("/api/users/sendOtp", data: data);
      log(response.toString());
      return response;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
