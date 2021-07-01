import 'package:dio/dio.dart';

import 'http_manager.dart';

class ServiceException implements Exception {
  static ServiceException DATA_NOT_FOUND = ServiceException(
      code: StatusCode.RESPONSE_DATA_IS_NULL, message: "DATA_NOT_FOUND");
  static ServiceException NETWORK_DISCONNECTED = ServiceException(
      code: StatusCode.NETWORK_ERROR, message: "NETWORK_DISCONNECTED");
  static ServiceException EXCEPTION =ServiceException(
      code: StatusCode.EXCEPTION, message: "EXCEPTION");

  ServiceException(
      {this.message = "", required this.code, this.errorCode = ""});

  String message;
  String errorCode;
  int? code;
}
