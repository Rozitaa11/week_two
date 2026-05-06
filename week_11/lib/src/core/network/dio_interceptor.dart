import 'package:dio/dio.dart';
import '../errors/exceptions.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.connectTimeout = const Duration(seconds: 10);
    options.receiveTimeout = const Duration(seconds: 10);
    print("REQUEST[${options.method}] => ${options.path}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
      "RESPONSE[${response.statusCode}] => ${response.requestOptions.path}",
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print("ERROR => ${err.message}");

    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          error: TimeoutException(),
        ),
      );
      return;
    }

    if (err.response != null) {
      handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          error: ServerException(
            err.response?.data.toString() ?? "Server error",
            err.response?.statusCode ?? 500,
          ),
        ),
      );
      return;
    }

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: NetworkException("No internet connection"),
      ),
    );
  }
}
