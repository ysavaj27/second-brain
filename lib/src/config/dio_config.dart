import 'dart:io';
import 'package:dio/dio.dart';
import '../utils/app_exports.dart';

DioConfig dioConfig = DioConfig();

class DioConfig {
  static final DioConfig _instance = DioConfig._internal();
  late final Dio dio;

  factory DioConfig() {
    return _instance;
  }

  DioConfig._internal() : dio = Dio() {
    // init();
  }

  void init() {
    dio.interceptors.add(ApiInterceptor());
  }

  // // static final DioConfig _instance = DioConfig._();
  //
  // // DioConfig._internal() : dio = Dio() {
  //   // init();
  // // }
  //
  // // factory DioConfig() => _instance;
  //
  // // DioConfig._();
  //
  // late final Dio dio;
  //
  // // static final Dio _dio = createDio();
  //
  // /// CREATE DIO
  // void init() {
  //   dio = Dio(
  //       BaseOptions(
  //         baseUrl: AppUrl.baseURL,
  //         connectTimeout: const Duration(milliseconds: 300000),
  //         receiveTimeout: const Duration(milliseconds: 300000),
  //         sendTimeout: const Duration(milliseconds: 300000),
  //       ),
  //   );
  //   dio.interceptors.add(ApiInterceptor());
  // }

  Future<Response> get(String url, Map<String, dynamic> params) async {
    _printRequestDetails(url, params);
    Response response = await dio.get(url, queryParameters: params);
    _printResponseDetails(url, response);
    return response;
  }

  Future<Response> post(String url, Map<String, dynamic> body) async {
    _printRequestDetails(url, body);
    Response response = await dio.post(url, data: FormData.fromMap(body));
    _printResponseDetails(url, response);
    return response;
  }

  void _printRequestDetails(String url, dynamic data) {
    logger.d(
        'URL: ${dio.options.baseUrl + url}\nREQUEST: $data\nHEADERS: ${dio.options.headers}');
  }

  void _printResponseDetails(String url, Response response) {
    logger.d('URL : ${dio.options.baseUrl + url}\nRESPONSE : ${response.data}');
  }
}

Future<Map<String, dynamic>> addBytesImage({
  required Uint8List image,
  required String imageName,
  required String key,
}) async {
  Map<String, dynamic> addImage = {
    key: MultipartFile.fromBytes(
      image,
      filename: "${DateTime.now()}$imageName",
    ),
  };
  return addImage;
}

Future<Map<String, MultipartFile>> addFileImage(
    File image, String fileName, String key) async {
  return {
    key: await MultipartFile.fromFile(image.path, filename: fileName),
  };
}

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.baseUrl = AppUrl.baseURL;
    options.headers.addAll({
      'Content-Type': 'application/x-www-form-urlencoded',
      'Api-Key': AppKey.appKey,
    });
    if (app.isUserLogin) {
      options.headers.addAll({
        'Authorization': 'Bearer ${app.userModel().token}',
      });
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    String message = '';
    if (!(await _isConnected())) {
      message = 'No internet connection.';
    } else {
      message = _handleError(err);
    }
    if (message.isNotEmpty) {
      // throw ArgumentError(message);
      logger.d(message);
      throw DioApiError(message);
      throw DioException(requestOptions: err.requestOptions, message: message);
      // throw ThrowException(err.requestOptions, message);
    } else {
      return handler.next(err);
    }
  }

  static String _handleError(DioException error) {
    String message = '';
    logger.e("status code ${error.response?.statusCode}",
        error: '${error.response}\n${error.type}');

    switch (error.type) {
      case DioExceptionType.cancel:
        message = 'Request was cancelled';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Request timed out while waiting for the server\'s response';
        break;
      case DioExceptionType.sendTimeout:
        message = 'Request timed out while sending data to the server';
        break;
      case DioExceptionType.badCertificate:
        message = 'Bad certificate';
        break;

      /// NO INTERNET CONNECTION ERROR GOES HERE
      case DioExceptionType.connectionError:
        message = 'Connection error';
        break;
      case DioExceptionType.connectionTimeout:
        message = 'Connection timeout';
        break;
      case DioExceptionType.unknown:
        message = 'Something went wrong :UNKNOWN';
        break;
      case DioExceptionType.badResponse:
        if (error.response?.data is ResponseBody) {
          ResponseBody body = error.response?.data;
          var resData = body.statusMessage ?? 'Something went wrong';
          switch (error.response!.statusCode) {
            case 400:
              message = resData;
              break;
            case 401:
              message = resData;
              break;
            case 500:
              message = resData;
              break;
            case 404:
              message = resData;
              break;
            case 503:
              message = resData;
              break;
            case 406:
              message = resData;
              break;
          }
          break;
        } else {
          message = "Something went wrong";
        }
    }
    return message;
  }

  static Future<bool> _isConnected() async {
    try {
      List<InternetAddress> list = await InternetAddress.lookup('google.com');
      return list.isNotEmpty && list[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}

class DioApiError implements Exception {
  final String message;

  DioApiError(this.message);

  @override
  String toString() => 'DioApiError: $message';
}
