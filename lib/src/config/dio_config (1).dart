// import 'dart:io';
// import 'package:captable/src/utils/app_exports.dart';
// import 'package:dio/dio.dart';
//
//
//
//
// DioConfig dioConfig = DioConfig();
//
//
// class DioConfig {
//   static final DioConfig _instance = DioConfig._();
//
//   factory DioConfig() => _instance;
//
//   DioConfig._();
//
//   // static final Dio dio = Dio();
//   static final Dio _dio = createDio();
//
//   /// CREATE DIO
//   static Dio createDio() {
//     Dio dio = Dio();
//     dio.options = BaseOptions(
//       baseUrl: AppUrl.baseURL,
//       connectTimeout: 300000,
//       receiveTimeout: 300000,
//       sendTimeout: 300000,
//     );
//     dio.interceptors.addAll({ApiInterceptor()});
//     return dio;
//   }
//
//   /// GET METHOD
//    Future<Response> get(String url, Map<String, dynamic> body) async {
//     // body.addAll({
//     //   'apikey': authRepo.apiKey,
//     //   'token': authRepo.tokenKey,
//     // });
//     // logger.d(
//     //     'Api :${_dio.options.baseUrl + url}\nHeader : ${_dio.options.headers}\nBody :$body',
//     //     'GET');
//     Response response = await _dio.get(url, queryParameters: body);
//     // logger.d(
//     //     'URL : ${_dio.options.baseUrl + url} \nRESPONSE : ${response.data}',
//     //     'GET');
//     return response;
//   }
//
//   /// POST METHOD
//    Future<Response> post(
//       String url,
//       Map<String, dynamic> body,
//       ) async {
//     // body.addAll({
//     //   'apikey': authRepo.apiKey,
//     //   'token': authRepo.tokenKey,
//     // });
//     // logger.d(
//     //     'Api :${_dio.options.baseUrl + url}\nHeader : ${_dio.options.headers}\nBody :$body',
//     //     'POST');
//     // _dio.interceptors
//     //     .add(RequestInterceptor(_dio, token: app.tokenKey, apiKey: app.apiKey));
//     Response response = await _dio.post(url, data: FormData.fromMap(body));
//     // logger.d(
//     //     'URL : ${_dio.options.baseUrl + url} \nRESPONSE : ${response.data}',
//     //     'POST');
//     return response;
//   }
// }
//
// Future<Map<String, dynamic>> addBytesImage({
//   required Uint8List image,
//   required String imageName,
// }) async {
//   Map<String, dynamic> addImage = {
//     imageName: MultipartFile.fromBytes(
//       image,
//       filename: "${DateTime.now()}$imageName",
//     ),
//   };
//   return addImage;
// }
//
// Future<Map<String, MultipartFile>> addFileImage(
//     File image, String fileName, String key) async {
//   return {
//     key: await MultipartFile.fromFile(image.path, filename: fileName),
//   };
// }
// /// INTERCEPTOR FOR THE DIO
// class ApiInterceptor extends Interceptor {
//   /// REQUEST
//   ///
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     // Map<String, dynamic> header = {};
//     try {
//       // if (app.tokenKey.isNotEmpty && app.apiKey.isNotEmpty ) {
//       //   options.headers.addAll({
//       //     'apiKey': app.apiKey,
//       //     'tokenKey': app.tokenKey,
//       //   });
//       // }
//       //   options.headers = {
//       // 'Content-Type':'multipart/form-data'
//       // };
//       // options.headers.addAll({
//       //   'Content-Type': 'application/x-www-form-urlencoded',
//       //   // 'Content-Type': 'application/json',
//       // });
//       return handler.next(options);
//     } catch (e) {
//       logger.e('error $e');
//     }
//   }
//
//   /// ERROR
//   @override
//   void onError(DioError err, ErrorInterceptorHandler handler) {
//     switch (err.type) {
//       case DioErrorType.connectTimeout:
//         message = 'Connection error';
//         break;
//       // case DioErrorType.connectionTimeout:
//       //   message = 'Connection timeout';
//       //   break;
//       // case DioErrorType.unknown:
//       //   message = 'Something went wrong :UNKNOWN';
//       //   break;
//       case DioErrorType.response:
//         ResponseBody body = error.response?.data;
//         // logger.d(body.statusMessage ?? "");
//         var resData = body.statusMessage ?? 'Something went wrong';
//         switch (error.response!.statusCode) {
//           case 400:
//             message = resData;
//             break;
//           case 401:
//             message = resData;
//             break;
//           case 500:
//             message = resData;
//             break;
//           case 404:
//             message = resData;
//             break;
//           case 503:
//             message = resData;
//             break;
//           case 406:
//             message = resData;
//             break;
//         }
//         break;
//       case DioErrorType.other:
//         message = 'No Internet error';
//         break;
//     }
//     return message;
//   }
//
//   static Future<bool> _isConnected() async {
//     try {
//       List<InternetAddress> list = await InternetAddress.lookup('google.com');
//       return list.isNotEmpty && list[0].rawAddress.isNotEmpty;
//     } catch (e) {
//       return false;
//     }
//   }
//
// }
//
// class ConnectionTimeOutException extends DioError {
//   ConnectionTimeOutException(RequestOptions r) : super(requestOptions: r);
//
//   @override
//   String toString() {
//     return 'connectionTimedOutPleaseTryAgain'.tr;
//   }
// }
//
// class SendTimeOutException extends DioError {
//   SendTimeOutException(RequestOptions r) : super(requestOptions: r);
//
//   @override
//   String toString() {
//     return 'sendTimedOutPleaseTryAgain'.tr;
//   }
// }
//
// class ReceiveTimeOutException extends DioError {
//   ReceiveTimeOutException(RequestOptions r,String message) : super(requestOptions: r,error: message);
//
//   @override
//   String toString() {
//     return message;
//   }
// }
//
// //**********-----STATUS CODE ERROR HANDLERS--------**********
//
// class BadRequestException extends DioError {
//   BadRequestException(RequestOptions r) : super(requestOptions: r);
//
//   @override
//   String toString() {
//     return 'invalidRequest'.tr;
//   }
// }
//
// class InternalServerErrorException extends DioError {
//   InternalServerErrorException(RequestOptions r) : super(requestOptions: r);
//
//   @override
//   String toString() {
//     return 'internalServerErrorOccurredPleaseTryAgainLater'.tr;
//   }
// }
//
// class ConflictException extends DioError {
//   ConflictException(RequestOptions r) : super(requestOptions: r);
//
//   @override
//   String toString() {
//     return 'conflictOccurred'.tr;
//   }
// }
//
// class UnauthorizedException extends DioError {
//   UnauthorizedException(RequestOptions r) : super(requestOptions: r);
//
//   @override
//   String toString() {
//     return 'accessDenied'.tr;
//   }
// }
//
// class NotFoundException extends DioError {
//   NotFoundException(RequestOptions r) : super(requestOptions: r);
//
//   @override
//   String toString() {
//     return 'theRequestedInformationCouldNotBeFound'.tr;
//   }
// }
//
// class NoInternetConnectionException extends DioError {
//   NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);
//
//   @override
//   String toString() {
//     return 'noInternet'.tr;
//   }
// }
