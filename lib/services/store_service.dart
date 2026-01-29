import 'dart:developer';

import 'package:dio/dio.dart';

class SongService {
  late final Dio dio = Dio(
    BaseOptions(baseUrl: "", headers: {"Content-Type": "application/json"}),
  );

  Future<Response> getProducts() async {
    try {
      final response = await dio.get("");
      log(response.toString());
      return response;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
