import 'package:dio/dio.dart';
import 'package:movie_ticket_app/pkg/server/base_url.dart';

class AuthRepository {
  final Dio _dio = Dio(
      BaseOptions(baseUrl: baseUrl, headers: {'Accept': 'application/json'}));

  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      final response = await _dio.post('/api/v1/login', data: {
        'email': email,
        'password': password,
      });
      if (response.statusCode == 200 && response.data['token'] != null) {
        return response.data['token'];
      } else {
        throw Exception(response.data['error'] ??
            'Incorrect email and password, or not found');
      }
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }

  Future<String?> signUp(
      {required String email,
      required String password,
      required String fullName,
      required String phoneNumber}) async {
    try {
      final response = await _dio.post('/api/v1/register', data: {
        'email': email,
        'password': password,
        'full_name': fullName,
        'phone_number': phoneNumber,
        'role': 'user',
      });
      if (response.statusCode == 201) {
        return response.data['message'];
      } else {
        throw Exception(response.data['error']);
      }
    } catch (e) {
      throw Exception("Register account failed: $e");
    }
  }

  Future<String?> signOut({required String token}) async {
    try {
      final response = await _dio.post('/api/v1/logout',
          options: Options(headers: {'Authorization': "Bearer $token"}));
      if (response.statusCode == 200) {
        return response.data['message'];
      } else {
        throw Exception(response.data['error']);
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
