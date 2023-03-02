class Failure {
  int code; // 200, 201, 400, 500 etc
  int message; // error, success
  Failure(this.code, this.message);
}