import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jie_app_flutter/common/app_config.dart';
import 'package:jie_app_flutter/utils/utils.dart';
import 'requestInterceptor.dart';

// ignore: prefer-match-file-name
class Http {
  static final Http _instance = Http._internal();
  factory Http() => _instance;

  static late final Dio dio;

  List<CancelToken?> pendingRequest = [];

  Http._internal() {
    BaseOptions options = BaseOptions();

    dio = Dio(options);
    dio.options.baseUrl = AppConfig.baseUrl;
    dio.options.connectTimeout = AppConfig.connectTimeout;
    dio.options.receiveTimeout = AppConfig.receiveTimeout;
    // 添加request拦截器
    dio.interceptors.add(RequestInterceptor());
  }

  Future request(
    String path, {
    String method = "GET",
    Map<String, dynamic>? params,
    data,
    Options? options,
    CancelToken? cancelToken,
    bool refresh = false,
    bool noCache = true,
    String? cacheKey,
    bool cacheDisk = false,
    bool isLoading = false,
  }) async {
    if (isLoading) {
      SVProgressHUD.show();
    }

    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.copyWith(
      method: method,
      extra: {
        "refresh": refresh,
        "noCache": noCache,
        "cacheKey": cacheKey,
        "cacheDisk": cacheDisk,
      },
    );

    Response response;
    CancelToken dioCancelToken = createDioCancelToken(cancelToken);
    response = await dio
        .request(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
      cancelToken: dioCancelToken,
    )
        .whenComplete(() {
      if (isLoading) {
        SVProgressHUD.dismiss();
      }
    });
    pendingRequest.remove(dioCancelToken);

    ApiResponse result;

    if (response.data != null) {
      if (response.data is Map) {
        result = ApiResponse.fromJson(response.data);
      } else {
        return response.data;
      }
    } else {
      return response.data;
    }

    if (result.code == 1) {
      return result.data;
    }
    if (result.code == 401) {
      // ignore: todo
      // TODO 401
      throw "";
    }
    if (result.code != null) {
      Fluttertoast.showToast(
        msg: result.message ?? "服务器繁忙",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Utils.color("#ccc"),
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return Future.error(() {});
    }

    return response.data;
  }

  Future get(
    String path, {
    Map<String, dynamic>? params,
    bool isLoading = false,
  }) async {
    return request(
      path,
      params: params,
      isLoading: isLoading,
    );
  }

  Future post(
    String path, {
    Map<String, dynamic>? params,
    data,
    bool isLoading = false,
  }) async {
    return request(
      path,
      method: "POST",
      params: params,
      data: data,
      isLoading: isLoading,
    );
  }

  // 获取cancelToken , 根据传入的参数查看使用者是否有动态传入cancel，没有就生成一个
  CancelToken createDioCancelToken(CancelToken? cancelToken) {
    CancelToken token = cancelToken ?? CancelToken();
    pendingRequest.add(token);
    return token;
  }

  _convertRequestData(data) {
    if (data != null) {
      data = jsonDecode(jsonEncode(data));
    }

    return data;
  }
}

class ApiResponse {
  int? code;
  dynamic data;
  String? message;

  ApiResponse({
    this.code,
    this.data,
    this.message,
  });

  ApiResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['code'] = code;
    data['data'] = this.data;
    data['message'] = message;

    return data;
  }
}

Future get(
  String path, {
  Map<String, dynamic>? params,
  bool isLoading = false,
}) {
  return Http().get(
    path,
    params: params,
    isLoading: isLoading,
  );
}

Future post(
  String path, {
  Map<String, dynamic>? data,
  bool isLoading = false,
}) {
  return Http().post(
    path,
    data: data,
    isLoading: isLoading,
  );
}
