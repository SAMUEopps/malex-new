// core/network/dio_client.dart
import 'package:dio/dio.dart';

class DioClient {
  static final Dio instance = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  ));

  // Add interceptors for error handling if needed
}