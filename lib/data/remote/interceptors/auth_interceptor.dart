import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter_clean_architecture/domain/repositories/auth_repository.dart';

class AuthInterceptor extends QueuedInterceptorsWrapper {
  final Dio _dio;
  final AuthRepository _authRepository;

  AuthInterceptor(this._dio, this._authRepository);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _authRepository.cacheAccessToken;
    if (token != null) {
      options.headers[HttpHeaders.authorizationHeader] = token;
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    try {
      if (err.response?.statusCode == 401) {
        // final refreshTokenDio = Dio(_dio.options);
        _dio.httpClientAdapter = _dio.httpClientAdapter;
        final requestOptions = err.requestOptions;
        final currentAuthInterceptor = _dio.interceptors
            .firstWhereOrNull((element) => element is AuthInterceptor);
        _dio.interceptors.removeWhere((element) => element is AuthInterceptor);
        final newToken = await _authRepository.refreshToken();
        if (newToken != null) {
          requestOptions.headers[HttpHeaders.authorizationHeader] = newToken;
          final response = await _dio.fetch(requestOptions);
          if (currentAuthInterceptor != null) {
            _dio.interceptors.insert(0, currentAuthInterceptor);
          }
          return handler.resolve(response);
        } else {
          if (currentAuthInterceptor != null) {
            _dio.interceptors.insert(0, currentAuthInterceptor);
          }
          super.onError(err, handler);
        }
      } else {
        super.onError(err, handler);
      }
    } catch (e) {
      if (e is DioException) {
        super.onError(e, handler);
      } else {
        super.onError(err.copyWith(error: e), handler);
      }
    }
  }
}
