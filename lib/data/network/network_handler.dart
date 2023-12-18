import 'package:advance_flutter/data/network/failure.dart';
import 'package:advance_flutter/presentation/resources/strings_manager.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error){
      if(error is DioError){
        // dio error mean the response coming from the API or form dio
        failure = _handlerError(error)!;
      }else{
        // default error
        failure = DataSource.DEFAULT.getFailure();
      }
  }
}
Failure? _handlerError(DioError error) {
  switch(error.type){
    case DioErrorType.connectionTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioErrorType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();
    case DioErrorType.receiveTimeout:
      return DataSource.RECIVE_TIMEOUT.getFailure();
    case DioErrorType.badResponse:
      if(error.response != null && error.response?.statusCode != null && error.response?.statusMessage != null){
        return Failure(error.response?.statusCode ?? 0, error.response?.statusMessage ?? "");
      }else {
        return DataSource.DEFAULT.getFailure();
      }
    case DioErrorType.cancel:
      return DataSource.CANCLE.getFailure();
    case DioErrorType.unknown:
      return DataSource.DEFAULT.getFailure();
    case DioExceptionType.badCertificate:
      // TODO: Handle this case.
      break;
    case DioExceptionType.connectionError:
      // TODO: Handle this case.
      break;
  }
  return null;
}

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHERISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCLE,
  RECIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCESS, ResponseMessage.SUCESS.tr());
        break;
      case DataSource.NO_CONTENT:
        return Failure(ResponseCode.NO_CONTENT, ResponseMessage.NO_CONTENT.tr());

        break;
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST.tr());

        break;
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN.tr());

        break;
      case DataSource.UNAUTHERISED:
        return Failure(ResponseCode.UNAUTHERISED, ResponseMessage.UNAUTHERISED.tr());

        break;
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOTFOUND, ResponseMessage.NOTFOUND.tr());
        break;
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR.tr());

        break;
      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT.tr());

        break;
      case DataSource.CANCLE:
        return Failure(ResponseCode.CANCLE, ResponseMessage.CANCLE.tr());
        break;

      case DataSource.RECIVE_TIMEOUT:
        return Failure(
            ResponseCode.RECIVE_TIMEOUT, ResponseMessage.RECIVE_TIMEOUT.tr());

        break;
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT.tr());

        break;
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR.tr());

        break;
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION.tr());

        break;
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT,
            ResponseMessage.DEFAULT.tr());
        break;

    }
  }
}

class ResponseCode {
  static const int SUCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success without data (no content)
  static const int BAD_REQUEST = 400; // failure, API rejected request
  static const int UNAUTHERISED = 401; // failure, API user is not authorized
  static const int FORBIDDEN = 403; // failure, API rejected request
  static const int NOTFOUND = 404; // failure, API rejected request
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side

  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCLE = -2;
  static const int RECIVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;

}

class ResponseMessage {
  static const String SUCESS = AppStrings.success; // success with data
  static const String NO_CONTENT =
      AppStrings.success; // success without data (no content)
  static const String BAD_REQUEST =
      AppStrings.badRequestError; // failure, API rejected request
  static const String UNAUTHERISED =
      AppStrings.unauthorizedError; // failure, API user is not authorized
  static const String FORBIDDEN =
      AppStrings.forbiddenError; // failure, API rejected request
  static const String NOTFOUND =
      AppStrings.notFoundError; // failure, API rejected request
  static const String INTERNAL_SERVER_ERROR =
      AppStrings.internalServerError; // failure, crash in server side

  // local status code
  static const String CONNECT_TIMEOUT = AppStrings.timeoutError;
  static const String CANCLE = AppStrings.defaultError;
  static const String RECIVE_TIMEOUT = AppStrings.timeoutError;
  static const String SEND_TIMEOUT = AppStrings.timeoutError;
  static const String CACHE_ERROR = AppStrings.cacheError;
  static const String NO_INTERNET_CONNECTION =
      AppStrings.noInternetError;
  static const String DEFAULT = AppStrings.defaultError;
}
class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE  = 1;
}