import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import 'dio_app_interceptors.dart';
import 'dio_net_interceptors.dart';

class Network {
  static Dio? _dio;

  static BaseOptions getOptions() {
    return _options;
  }

  static final BaseOptions _options = new BaseOptions(
      connectTimeout: 15000, receiveTimeout: 15000, sendTimeout: 15000, contentType: "application/json");

  static Future get(String url,
      {Map<String, dynamic>? params, bool showPrint = false, bool showLoading = false}) async {
    params = await AppInterceptor.requestExecute(params, showLoading: showLoading);
    var response = await _dio!.get(url, queryParameters: params);
    printNetwork(url, params, response.data);
    return response.data;
  }

  static Future post(String url,
      {Map<String, dynamic>? params, bool showPrint = false, bool showLoading = false}) async {
    params = await AppInterceptor.requestExecute(params, showLoading: showLoading);
    url = await AppInterceptor.supplementGenericDataPost(url);
    Response response = await _dio!.post(url, data: params);
    printNetwork(url, params, response.data);
    return response.data;
  }

  static Future put(String url,
      {Map<String, dynamic>? params, bool showPrint = false, bool showLoading = false}) async {
    params =
    await AppInterceptor.requestExecute(params, showLoading: showLoading);
    var response = await _dio!.put(url, queryParameters: params);
    printNetwork(url, params, response.data);
    return response.data;
  }


  static printNetwork(url, Map<String, dynamic>? params, dynamic data, {bool showPrint = false}) {
    if (showPrint) {
      log("url：" + url);
      log("parameters：${json.encode(params)}");
      log("result：${json.encode(data)}");
    }
  }


  static Future<Dio> buildDio() async {
    if (_dio == null) {
      var dio = Dio(_options);
      dio.interceptors.add(NetInterceptor.dioInterceptors());

      _dio = dio;
      // setProxy();
    }
    return _dio!;
  }

  static Dio get dio {
    return _dio!;
  }

  static void setProxy() {
    (_dio!.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      client.findProxy = (uri) {
        return "PROXY xxx:8888";
      };
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    };
  }
}
