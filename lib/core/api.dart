import 'package:cargo_linker/logic/services/authPersistence.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Api {
  // final String baseUrl = "https://cargo-linker-backend.cyclic.cloud/api";
  final String baseUrl = "http://192.168.222.222:5000/api";
  final Map<String, dynamic> defaultHeaders = {
    "Content-Type": "application/json",
  };
  final Dio _dio = Dio();

  Api() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.headers = defaultHeaders;
    _dio.interceptors.add(PrettyDioLogger(
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await AuthPersistance.getToken();
        if (token != null) {
          options.headers["Cookie"] = "token=$token";
        }
        return handler.next(options);
      },
      onResponse: (e, handler) async {
        List<String>? setCookie = e.headers["Set-cookie"];
        if (setCookie != null) {
          String cookie = setCookie[0].toString();
          String token = cookie.split(";")[0].split("=")[1];
          await AuthPersistance.setToken(token);
        }
        return handler.next(e);
      },
      onError: (e, handler) {
        return handler.next(e);
      },
    ));
  }

  Dio get request => _dio;
}

class ApiResponse {
  bool success;
  String? message;
  dynamic data;

  ApiResponse({required this.success, this.message, this.data});

  factory ApiResponse.fromResponse(Response response) {
    try {
      final res = response.data as Map<String, dynamic>;
      return ApiResponse(
        success: res["success"],
        message: res["message"] ?? (res["success"] ? "Success" : "Error"),
        data: res["data"],
      );
    } catch (e) {
      return ApiResponse(success: false, message: "Internal Server Error");
    }
  }

  factory ApiResponse.fromException(DioException exception) {
    try {
      return ApiResponse.fromResponse(exception.response ??
          Response(
              data: {"success": false, "message": exception.error.toString()},
              requestOptions: RequestOptions()));
    } catch (e) {
      return ApiResponse(success: false, message: "Internal Server Error");
    }
  }

  static Future<ApiResponse> handleRequest(Future<Response> request) async {
    try {
      Response response = await request;
      return ApiResponse.fromResponse(response);
    } on DioException catch (exception) {
      return ApiResponse.fromResponse(exception.response ??
          Response(
              data: {"success": false, "message": exception.error.toString()},
              requestOptions: RequestOptions()));
    } catch (exception) {
      return ApiResponse(success: false, message: "Internal Server Error");
    }
  }
}
