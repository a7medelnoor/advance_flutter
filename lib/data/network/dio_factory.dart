import 'package:advance_flutter/app/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  static const String APPLICATION_JSON = "application/json";
  static const String CONTENT_TYPE = "content-type";
  static const String ACCEPT = "accept";
  static const String AUTHORIZATION = "authorization";
  static const String DEFAULT_LANGUAGE = "language";

  Future<Dio> getDio() async {
    Dio dio = Dio();
    int _timeOut = 60 * 1000;
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: "SEND TOKEN HERE",
      DEFAULT_LANGUAGE: "en" //TODO: get lang from app preference
    };
    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      headers: headers,
      receiveTimeout: _timeOut as Duration,
      sendTimeout: _timeOut as Duration
    );
    if(!kReleaseMode){ // if we are in debug mode print the app logs
        dio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true
        ));
    }
    return dio;
  }
}
