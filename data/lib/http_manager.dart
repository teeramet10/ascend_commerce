import 'dart:collection';
import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:io' show Platform;

class HttpManager {
  static String get_product_list = "products";
  static String get_product_detail = "products/";

  Dio _dio = new Dio();

  String baseUrl = "";

  HttpManager({this.baseUrl = "https://ecommerce-product-app.herokuapp.com/"});

  Options _getOption() {
    return Options(
      sendTimeout: 15000,
      receiveTimeout: 15000,
      contentType: ContentType.json.toString(),
      responseType: ResponseType.json,
    );
  }

  Future<Response> sendGetRequest(url, params,
      {Map<String, dynamic> header = const {}}) async {
    Options baseOptions = _getOption();
    baseOptions.method = "GET";
    return await request(baseUrl + url, params, header, baseOptions);
  }

  Future<Response> sendPostRequest(url, params,
      {Map<String, dynamic> header = const {}}) async {
    Options baseOptions = _getOption();
    baseOptions.method = "POST";
    return await request(baseUrl + url, params, header, baseOptions);
  }

  Future<Response> sendPatchRequest(url, params,
      {Map<String, dynamic> header = const {}}) async {
    Options baseOptions = _getOption();
    baseOptions.method = "PATCH";
    return await request(baseUrl + url, params, header, baseOptions);
  }

  Future<Response> sendPutRequest(url, params,
      {Map<String, dynamic> header = const {}}) async {
    Options baseOptions = _getOption();
    baseOptions.method = "PUT";
    return await request(baseUrl + url, params, header, baseOptions);
  }

  Future<Response> request(url, params, Map<String, dynamic> header,
      Options option) async {
    Map<String, dynamic> headers = new HashMap();

    var platform = "";
    if (Platform.isAndroid) {
      platform = "Android";
    } else if (Platform.isIOS) {
      platform = "iOS";
    }
    headers["x-platform"] = platform;
    if (header != null) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
    } else {
      option = new Options(method: "GET");
      option.headers = headers;
    }

    Response response;
    try {
      response = await _dio.request(url, data: params, options: option);
    } on DioError catch (e) {
      return _resultError(e);
    }
    if (response.data is DioError) {
      return _resultError(response.data);
    }
    return response;
  }

  _resultError(DioError e) {
    Response errorResponse;
    if (e.response != null) {
      errorResponse = e.response!;
    } else {
      errorResponse =
      new Response(statusCode: 666, requestOptions: e.requestOptions);
    }
    if (e.type == DioErrorType.connectTimeout ||
        e.type == DioErrorType.receiveTimeout) {
      errorResponse.statusCode = StatusCode.NETWORK_TIME_OUT;
    }
    return errorResponse;
  }
}

class StatusCode {
  static const NETWORK_ERROR = -1;

  static const NETWORK_TIME_OUT = -2;

  static const NETWORK_JSON_EXCEPTION = -3;

  static const SUCCESS = 200;

  static const RESPONSE_DATA_IS_NULL = -4;

  static const EXCEPTION = -5;

}