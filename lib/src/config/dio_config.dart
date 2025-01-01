import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../utils/app_exports.dart';

DioConfig dioConfig = DioConfig();

class DioConfig {
  static final DioConfig _instance = DioConfig._internal();
  late final Dio dio;

  factory DioConfig() {
    return _instance;
  }

  DioConfig._internal() {
    init();
  }

  void init() {
    try {
      dio = Dio(
        BaseOptions(
          baseUrl: AppUrl.baseURL,
          connectTimeout: const Duration(seconds: 90),
          receiveTimeout: const Duration(seconds: 90),
          sendTimeout: const Duration(seconds: 90),
        ),
      );
      dio.interceptors.add(ApiInterceptor());
    } catch (e) {
      logger.e("Dio Initialization Error: $e");
    }
  }

  Future<Response> get(String url, [Map<String, dynamic>? params]) async {
    _logRequestDetails("GET", url, params);
    final response = await dio.get(url, queryParameters: params);
    _logResponseDetails(url, response);
    return response;
  }

  Future<Response> post(String url, Map<String, dynamic> body,
      [bool isRawData = true]) async {
    _logRequestDetails("POST", url, body);
    final response = await dio.post(
      url,
      data: isRawData ? body : FormData.fromMap(body),
    );
    _logResponseDetails(url, response);
    return response;
  }

  void _logRequestDetails(String method, String url, dynamic data) {
    logger.d(
      "$method Request\nURL: ${dio.options.baseUrl + url}\nData: $data\nHeaders: ${dio.options.headers}",
    );
  }

  void _logResponseDetails(String url, Response response) {
    logger.d(
        "Response\nURL: ${dio.options.baseUrl + url}\nData: ${response.data}");
  }

  Future<Map<String, dynamic>> createBytesImage({
    required Uint8List image,
    required String imageName,
    required String key,
  }) async {
    return {
      key: MultipartFile.fromBytes(
        image,
        filename: "${DateTime.now()}_$imageName",
      ),
    };
  }

  Future<Map<String, MultipartFile>> createFileImage(
      String imagePath, String fileName, String key) async {
    return {
      key: await MultipartFile.fromFile(imagePath, filename: fileName),
    };
  }
}

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // logger.d(_buildHeaders());
    options.headers.addAll(_buildHeaders());
    handler.next(options);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    final errorMessage = _getErrorMessage(err);
    logger.e(
        "Error Type: ${err.type}, \nMessage: $errorMessage\n Status Code :${err.response?.statusCode}");

    // Handle token expiration (401 or invalid token scenarios)
    if (err.type == DioExceptionType.badResponse) {
      logger.d('LogOut Called');
      await _handleTokenExpiration();
    }

    handler.reject(DioApiError(err.requestOptions, errorMessage));
  }

  Map<String, dynamic> _buildHeaders() {
    final headers = {
      'Content-Type': 'application/json',
    };

    // if (app.isUserLogin && app.token.isNotEmpty) {
    //   headers['Authorization'] = 'Bearer ${app.token}';
    // }

    return headers;
  }

  String _getErrorMessage(DioException err) {
    logger.d("err.response?.data ${err.response?.data}");
    switch (err.type) {
      case DioExceptionType.cancel:
        return "Request was cancelled";
      case DioExceptionType.connectionTimeout:
        return "Connection timeout";
      case DioExceptionType.receiveTimeout:
        return "Request timed out while waiting for the server's response";
      case DioExceptionType.sendTimeout:
        return "Request timed out while sending data to the server";
      case DioExceptionType.badCertificate:
        return "Bad certificate";
      case DioExceptionType.connectionError:
        return "No Internet Connection";
      case DioExceptionType.badResponse:
        return "Unauthenticated";
      case DioExceptionType.unknown:
        final responseBody = err.response?.data;
        if (responseBody is Map<String, dynamic>) {
          return responseBody['message'] ?? "Unknown error occurred";
        } else if (responseBody is String) {
          return responseBody;
        }
        return "Unknown error occurred";
    }
  }

  Future<void> _handleTokenExpiration() async {
    logger.w("Token expired. Logging out the user.");
    // await Get.offAllNamed('/signIn');
    // await app.setUser(prefUser: UserModel.fromJson({}));
  }
}

class DioApiError extends DioException {
  final String message;

  DioApiError(RequestOptions requestOptions, this.message)
      : super(requestOptions: requestOptions);

  @override
  String toString() => message;
}
