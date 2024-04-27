import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:dio/dio.dart';

import '../state/auth_state.dart';

final dio = Dio();

class NativeApiService {
  static bool appDev = kDebugMode;

  static String serverDev = "127.0.0.1";

  static String getHost() {
    if (appDev) {
      return "http://$serverDev:24101";
    } else {
      return "https://$serverDev:24101";
    }
  }

  static Map<String, String> getHeaders() {
    return {
      'Content-Type': 'application/json;charset=UTF-8',
      'Accept': 'application/json',
      'Charset': 'utf-8',
    };
  }

  static String getApi() {
    String apiHost = getHost();
    return "$apiHost/api/";
  }

  static get(String url) async {
    final AuthState authController = Get.put(AuthState());
    Map<String, String> headers = getHeaders();

    if (authController.isAuthenticated()) {
      headers['Authorization'] = 'Bearer ${authController.user.value.token}';
    }

    try {
      final response =
          await dio.get(getApi() + url, options: Options(headers: headers));
      print(response.data);
      if (response.statusCode == 401) {
        await authController.remove();
      }
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        return e.response;
      } else {
        print(e.requestOptions);
        print(e.message);
        print(e.response);
        return e.response;
      }
    }
  }

  static post(String url, Map data) async {
    final AuthState authController = Get.put(AuthState());
    Map<String, String> headers = getHeaders();

    if (authController.isAuthenticated()) {
      headers['Authorization'] = 'Bearer ${authController.user.value.token}';
    }

    try {
      final response = await dio.post(getApi() + url,
          data: data, options: Options(headers: headers));
      print(response.data);
      if (response.statusCode == 401) {
        await authController.remove();
      }
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        return e.response;
      } else {
        print(e.requestOptions);
        print(e.message);
        print(e.response);
        return e.response;
      }
    }
  }

  static put(String url, Map data) async {
    final AuthState authController = Get.put(AuthState());
    Map<String, String> headers = getHeaders();

    if (authController.isAuthenticated()) {
      headers['Authorization'] = 'Bearer ${authController.user.value.token}';
    }

    try {
      final response = await dio.put(getApi() + url,
          data: data, options: Options(headers: headers));
      print(response.data);
      if (response.statusCode == 401) {
        await authController.remove();
      }
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        return e.response;
      } else {
        print(e.requestOptions);
        print(e.message);
        print(e.response);
        return e.response;
      }
    }
  }

  static patch(String url, Map data) async {
    final AuthState authController = Get.put(AuthState());
    Map<String, String> headers = getHeaders();

    if (authController.isAuthenticated()) {
      headers['Authorization'] = 'Bearer ${authController.user.value.token}';
    }

    try {
      final response = await dio.patch(getApi() + url,
          data: data, options: Options(headers: headers));
      print(response.data);
      if (response.statusCode == 401) {
        await authController.remove();
      }
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        return e.response;
      } else {
        print(e.requestOptions);
        print(e.message);
        print(e.response);
        return e.response;
      }
    }
  }

  static delete(String url) async {
    final AuthState authController = Get.put(AuthState());
    Map<String, String> headers = getHeaders();

    if (authController.isAuthenticated()) {
      headers['Authorization'] = 'Bearer ${authController.user.value.token}';
    }

    try {
      final response =
          await dio.delete(getApi() + url, options: Options(headers: headers));
      print(response.data);
      if (response.statusCode == 401) {
        await authController.remove();
      }
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        return e.response;
      } else {
        print(e.requestOptions);
        print(e.message);
        print(e.response);
        return e.response;
      }
    }
  }
}
