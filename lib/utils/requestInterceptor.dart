// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'sp_util.dart';

class RequestInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // options.copyWith(
    //   headers: {
    //     "Content-Type": "application/json",
    //     "token": SpUtil().localGet("token")
    //   },
    // );
    options.headers['Content-Type'] = 'application/json';
    options.headers['token'] = SpUtil().localGet('token');

    return super.onRequest(options, handler);
  }
}
