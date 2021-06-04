import 'dart:io';
import 'package:dio/dio.dart';

import 'package:movie_db_app/data/service/api_config.dart';

class BaseApi {
  static final baseUrl = "http://api.themoviedb.org/3/";

  Dio getDio() {
    var dio = Dio(BaseOptions(
      connectTimeout: 120000,
      receiveTimeout: 120000,
      headers: ApiConfig.header,
      contentType: ContentType.json.toString(),
      responseType: ResponseType.plain,
    ));

    // dio.interceptors.add(LogInterceptor(requestBody: true));
    return dio;
  }

  String handleError(DioError error) {
    String errorDescription = "";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.cancel:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.connectTimeout:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.response:
          errorDescription =
              "Received invalid status code: ${error.response?.statusCode}";
          break;
        case DioErrorType.sendTimeout:
          break;
        case DioErrorType.other:
          errorDescription =
              "Connection to API server failed due to internet connection";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }
}

final BaseApi baseApi = BaseApi();
