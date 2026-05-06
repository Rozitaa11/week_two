import 'package:dio/dio.dart';
import '../../core/network/dio_interceptor.dart';

class ApiClient {
  final Dio dio;

  ApiClient._internal(this.dio);

  factory ApiClient() {
    final dio = Dio(
      BaseOptions(
        baseUrl: "https://fakestoreapi.com", // replace with your API
      ),
    );

    dio.interceptors.add(DioInterceptor());

    return ApiClient._internal(dio);
  }

  Future<Response> get(String path, {Map<String, dynamic>? query}) {
    return dio.get(path, queryParameters: query);
  }

  Future<Response> post(String path, {dynamic data}) {
    return dio.post(path, data: data);
  }
}
