import 'package:dio/dio.dart';
import 'package:movie_ticket_app/home/models/movie_schedule_coming_response.dart';
import 'package:movie_ticket_app/home/models/movie_schedule_response.dart';
import 'package:movie_ticket_app/pkg/server/base_url.dart';
import 'package:movie_ticket_app/pkg/storage/secure_storage.dart';

class MovieScheduleRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {'Accept': 'application/json'},
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<MovieScheduleResponse> fetchMovie() async {
    try {
      final token = await SecureStorage.findToken();

      if (token == null) {
        throw Exception("Silakan login terlebih dahulu");
      }

      final response = await _dio.get(
        '/api/v1/schedule',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        return MovieScheduleResponse.fromJson(response.data);
      } else {
        throw Exception(
            response.data['error'] ?? "Gagal mengambil data jadwal film");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception("Koneksi timeout, silakan coba lagi");
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception("Tidak ada koneksi internet");
      } else if (e.response?.statusCode == 401) {
        throw Exception("Session expired, silakan login kembali");
      } else if (e.response?.statusCode == 403) {
        throw Exception("Akses tidak diizinkan");
      } else {
        throw Exception(
            e.response?.data['error'] ?? "Gagal mengambil data jadwal film");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<MovieScheduleComingResponse> fetchMovieComingSoon() async {
    try {
      final token = await SecureStorage.findToken();

      if (token == null) {
        throw Exception("Silakan login terlebih dahulu");
      }

      final response = await _dio.get('/api/v1/movie',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200) {
        return MovieScheduleComingResponse.fromJson(response.data);
      } else {
        throw Exception(
            response.data['error'] ?? "Gagal mengambil data jadwal film");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception("Koneksi timeout, silakan coba lagi");
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception("Tidak ada koneksi internet");
      } else if (e.response?.statusCode == 401) {
        throw Exception("Session expired, silakan login kembali");
      } else if (e.response?.statusCode == 403) {
        throw Exception("Akses tidak diizinkan");
      } else {
        throw Exception(
            e.response?.data['error'] ?? "Gagal mengambil data jadwal film");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
