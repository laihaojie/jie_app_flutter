import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' hide Response;

import '../common/app_config.dart';
import '../routers/app_pages.dart';
import 'requestInterceptor.dart';
import 'sp_util.dart';
import 'utils.dart';

// ignore: prefer-match-file-name
class Http {
  factory Http() => _instance;
  Http._internal() {
    final BaseOptions options = BaseOptions();

    dio = Dio(options);
    dio.options.baseUrl = AppConfig.baseUrl;
    dio.options.connectTimeout = AppConfig.connectTimeout;
    dio.options.receiveTimeout = AppConfig.receiveTimeout;
    // 添加request拦截器
    dio.interceptors.add(RequestInterceptor());
  }
  static final Http _instance = Http._internal();

  static late final Dio dio;

  List<CancelToken?> pendingRequest = [];

  Future request(
    String path, {
    String method = 'GET',
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
        'refresh': refresh,
        'noCache': noCache,
        'cacheKey': cacheKey,
        'cacheDisk': cacheDisk,
      },
    );

    Response response;
    final CancelToken dioCancelToken = createDioCancelToken(cancelToken);
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
      Utils.toast('登录失效，请重新登录');
      SpUtil().remove('user_info');
      SpUtil().remove('token');
      Get.toNamed(AppRouters.login);

      // cancel future request
      return Future.error('登录失效，请重新登录');
    }
    if (result.code != null) {
      Fluttertoast.showToast(
        msg: result.message ?? '服务器繁忙',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Utils.color('#ccc'),
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // ignore: no-empty-block
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
      method: 'POST',
      params: params,
      data: data,
      isLoading: isLoading,
    );
  }

  // 获取cancelToken , 根据传入的参数查看使用者是否有动态传入cancel，没有就生成一个
  CancelToken createDioCancelToken(CancelToken? cancelToken) {
    final CancelToken token = cancelToken ?? CancelToken();
    pendingRequest.add(token);

    return token;
  }

  // ignore: unused_element
  _convertRequestData(data) {
    if (data != null) {
      data = jsonDecode(jsonEncode(data));
    }

    return data;
  }
}

class ApiResponse {
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
  int? code;
  // ignore: avoid-dynamic
  dynamic data;
  String? message;

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
