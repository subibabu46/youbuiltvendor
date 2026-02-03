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

  Future<Response> fetchStates() async {
    try {
      final response = await dio.get("/api/users/statesDropDown");

      return response;
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ?? e.message ?? 'Something went wrong';

      throw message;
    } catch (e) {
      throw 'Unexpected error occurred';
    }
  }

  Future<Response> fetchDistricts() async {
    try {
      final response = await dio.get("/api/users/districtDropDown");

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

  Future<Response> registerStep2(Map<String, dynamic> data) async {
    try {
      final response = await dio.post(
        "/api/users/registrationStep2/82",
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
}
