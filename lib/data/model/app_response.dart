class AppResponse {
  dynamic data;
  int? statusCode;
  bool isSuccess;
  String errorMessage;

  AppResponse({
    this.data,
    this.statusCode,
    this.isSuccess = false,
    this.errorMessage = '',
  });
}
