import 'package:data/service_exceptions.dart';
import 'package:dio/dio.dart';

class BaseDataSource {
  ServiceException handlerError(Response<dynamic> response) {
    return ServiceException(
        message: response.statusMessage ?? "", code: response.statusCode);
  }
}
