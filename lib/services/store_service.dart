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

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> postUserInfo(Map<String, dynamic> data) async {
    try {
      final response = await dio.post("/api/users/sendOtp", data: data);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> verifyOtp(Map<String, dynamic> data) async {
    try {
      final response = await dio.post("/api/users/verifyOtp", data: data);

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
