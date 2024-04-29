import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dio/dio.dart';

import '../state/auth_state.dart';

final dio = Dio();

class NativeApiService {
  static bool appDev = kDebugMode;

  static String serverDev = "localhost";

  static String getHost() {
    if (appDev) {
      return "http://$serverDev:8080";
    } else {
      return "https://$serverDev:8080";
    }
  }

  static Map<String, String> getHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Charset': 'utf-8',
    };
  }

  static String getApi() {
    String apiHost = getHost();
    return "$apiHost/";
  }

  static get(String url) async {
    final AuthState authController = Get.put(AuthState());
    Map<String, String> headers = getHeaders();

    if (authController.isAuthenticated()) {
      headers['Authorization'] = 'Bearer ${authController.user.value.token}';
    }

    try {
      final response =
          await dio.get(getApi() + url, options: Options(
            contentType: Headers.jsonContentType,
            headers: headers
          ));
      print(response.data);
      if (response.statusCode == 401) {
        await authController.remove();
      }
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        print(
            '${e.requestOptions.method} ${e.requestOptions.path} ${e.requestOptions.data}');
        print('(${e.response!.statusCode}) ${e.response!.data}');
        return e.response;
      } else {
        print(
            '${e.requestOptions.method} ${e.requestOptions.path} ${e.requestOptions.data}');
        print('(${e.response!.statusCode}) ${e.response!.data}');
        return e.response;
      }
    }
  }

  static post(String url, Object data, {bool formEncoded = false, bool multipart = false}) async {
    final AuthState authController = Get.put(AuthState());
    Map<String, String> headers = getHeaders();

    if (authController.isAuthenticated()) {
      headers['Authorization'] = 'Bearer ${authController.user.value.token}';
    }

    try {
      final response = await dio.post(getApi() + url,
          data: data,
          options: Options(
            contentType: formEncoded ? Headers.formUrlEncodedContentType : (multipart ? Headers.multipartFormDataContentType : Headers.jsonContentType),
            headers: headers,
          ),
        );
      print('Payload: ${response.data}');
      if (response.statusCode == 401) {
        await authController.remove();
      }
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        print('Empty response');
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        throw e;
      } else {
        print('Exception');
        print(
            '${e.requestOptions.method} ${e.requestOptions.path} ${e.requestOptions.data}');
        print(e.message);
        print(e.response);
        throw e;
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

  static alert(
    BuildContext context, {
    required String content,
    required String title,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Ok'))
        ],
      ),
    );
  }
}
