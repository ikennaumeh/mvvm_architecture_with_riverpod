import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_riverpod/services/error_handling.dart';
import 'package:mvvm_riverpod/ui/enums/request.dart';
import 'package:mvvm_riverpod/ui/extensions/request_extension.dart';

final networkServiceProvider = Provider<NetworkService>((ref) => NetworkService());

class NetworkService with ErrorHandling{
  late final Dio _dio;

  NetworkService([Dio? dio]) {
    _dio =
        dio ??
        Dio(
          BaseOptions(baseUrl: "https://dog.ceo/api", connectTimeout: const Duration(minutes: 3)),
        );

    if (kDebugMode) {
      _dio.interceptors.addAll([
        LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: true,
          responseHeader: false,
          request: false,
          requestBody: true,
        ),
      ]);
    }
  }

  Future request(
    String path, {
    required Request request,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response = await _dio.request(
        path,
        data: jsonEncode(data),
        queryParameters: queryParameters,
        options: Options(method: request.method),
      );

      return response.data;
    } on DioException catch (e) {
       handleError(e);
    } catch (e, s) {
      debugPrint('Could not make a request to this path: $path $e $s',);
    }
  }
}


