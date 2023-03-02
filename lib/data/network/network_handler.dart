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
  NO_INTERNET_CONNECTION

}


class ResponseCode {

  static const int SUCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success without data (no content)
  static const int BAD_REQUEST = 400; // failure, API rejected request
  static const int UNAUTHERISED = 401; // failure, API user is not authorized
  static const int FORBIDDEN = 403; // failure, API rejected request
  static const int INTERNAL_SERVER_ERROR = 500;  // failure, crash in server side

  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCLE = -2;
  static const int RECIVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int UNKNOWN = -7;
}

class ResponseMessage {

  static const String SUCESS = "Success"; // success with data
  static const String NO_CONTENT = "Success"; // success without data (no content)
  static const String BAD_REQUEST = "Bad request try again later"; // failure, API rejected request
  static const String UNAUTHERISED = "User is authorized, Try again later"; // failure, API user is not authorized
  static const String FORBIDDEN = "Forbidden request, Try again later"; // failure, API rejected request
  static const String INTERNAL_SERVER_ERROR = "something went wrong,Try again later";  // failure, crash in server side

  // local status code
  static const String CONNECT_TIMEOUT = "Timeout error, Try again later";
  static const String CANCLE = "Request was canceled, Try again later";
  static const String RECIVE_TIMEOUT = "Timeout error, Try again later";
  static const String SEND_TIMEOUT = "Timeout error, Try again later";
  static const String CACHE_ERROR = "Cache error, Try again later";
  static const String NO_INTERNET_CONNECTION = "Please check your intent connection";
  static const String UNKNOWN = "something went wrong,Try again later";
}