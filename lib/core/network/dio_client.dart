import 'package:dio/dio.dart';

class DioClient {
  DioClient._internal();

  static final Dio instance = Dio(
    BaseOptions(
      baseUrl: 'https://your-api-base-url.com',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );
}
