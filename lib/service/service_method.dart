import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:zhx_demo/util/logs.dart';

/// 自定义枚举
enum Method { get, post }

class Net {
  // 工厂模式
  factory Net() => _getInstance()!;

  static Net? get instance => _getInstance();
  static Net? _instance;

  late Dio dio;

  Net._internal() {
    // 初始化
    dio = Dio(BaseOptions(
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 3),
    ));
  }

  // 单列模式
  static Net? _getInstance() {
    _instance ??= Net._internal();
    return _instance;
  }

  get(String url, Map<String, dynamic> params, {Function? success}) {
    _doRequest(url, params, Method.get, success);
  }

  post(String url, Map<String, dynamic> params, {Function? success}) {
    _doRequest(url, params, Method.post, success);
  }

  getBody(String url, Map<String, dynamic> params, {Function? success}) {
    _doRequestBody(url, params, success);
  }

  void _doRequest(String url, Map<String, dynamic> params, Method method,
      Function? successCallBack) async {
    //

    try {
      /// 添加header
      dio.options.headers.addAll({
        'Token': "ACCTOKEN"
      });
      Response response;
      switch (method) {
        case Method.get:
          if (params.isNotEmpty) {
            response = await dio.get(url, queryParameters: params);
          } else {
            response = await dio.get(url);
          }
          break;
        case Method.post:
          if (params.isNotEmpty) {
            response =
            await dio.post(url, data: params, queryParameters: params);
          } else {
            response = await dio.post(url);
          }
          break;
      }
      var result = json.decode(response.toString());
      if (successCallBack != null) {
        //返回请求数据
        successCallBack(result);
      }
    } catch (exception) {
      Logs.d("网络超时，请检查网络"+exception.toString());
      if (successCallBack != null) {
        //返回请求数据
        successCallBack("");
      }
    }
  }

  void _doRequestBody(String url, Map<String, dynamic> params,
      Function? successCallBack) async {
    try {
      /// 可以添加header
      dio.options.headers.addAll({
        'Token': "ACCTOKEN"
      });
      Response response;
      response = await dio.request(url,
          data: params,
          options: Options(method: "GET", contentType: "application/json"));
      var result = json.decode(response.toString());
      if (successCallBack != null) {
        //返回请求数据
        successCallBack(result);
      }
    } catch (exception) {
      Logs.d("网络超时，请检查网络" + exception.toString());
      if (successCallBack != null) {
        //返回请求数据
        successCallBack("");
      }
    }
  }
}

