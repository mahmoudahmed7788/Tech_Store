import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  // ================= REGISTER =================

  Future<Response> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final response = await dio.post(
        'https://accessories-eshop.runasp.net/api/auth/register',
        data: {
          'email': email.trim(),
          'password': password,
          'firstName': firstName.trim(),
          'lastName': lastName.trim(),
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      print('========== REGISTER SUCCESS ==========');
      print('STATUS: ${response.statusCode}');
      print('DATA: ${response.data}');
      print('URL: ${response.requestOptions.uri}');
      print('REQUEST DATA: ${response.requestOptions.data}');
      print('======================================');

      return response;
    } on DioException catch (e) {
      print('========== REGISTER ERROR ==========');
      print('STATUS: ${e.response?.statusCode}');
      print('DATA: ${e.response?.data}');
      print('URL: ${e.requestOptions.uri}');
      print('REQUEST DATA: ${e.requestOptions.data}');
      print('HEADERS: ${e.requestOptions.headers}');
      print('MESSAGE: ${e.message}');
      print('====================================');

      rethrow;
    }
  }

  // ================= VERIFY EMAIL =================

  Future<Response> verifyEmail({
    required String email,
    required String code,
  }) async {
    try {
      final response = await dio.post(
        'https://accessories-eshop.runasp.net/api/auth/verify-email',
        data: {
          'email': email.trim(),
          'code': code.trim(),
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      print('========== VERIFY SUCCESS ==========');
      print('STATUS: ${response.statusCode}');
      print('DATA: ${response.data}');
      print('URL: ${response.requestOptions.uri}');
      print('REQUEST DATA: ${response.requestOptions.data}');
      print('====================================');

      return response;
    } on DioException catch (e) {
      print('========== VERIFY ERROR ==========');
      print('STATUS: ${e.response?.statusCode}');
      print('DATA: ${e.response?.data}');
      print('URL: ${e.requestOptions.uri}');
      print('REQUEST DATA: ${e.requestOptions.data}');
      print('HEADERS: ${e.requestOptions.headers}');
      print('MESSAGE: ${e.message}');
      print('==================================');

      rethrow;
    }
  }
}
