import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_app/controllers/auth_controller.dart';
import 'package:flutter_app/utils/snackbar_handler.dart';
import 'package:get/instance_manager.dart';

class NetworkClient {
  static String apiURL = 'http://13.52.150.132/api';

  static Map<String, String> getHeaders() {
    final AuthController authController = Get.find(tag: 'auth_controller');
    return ({
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      ...(authController.token.value != null
          ? {"Authorization": "Bearer ${authController.token.value}"}
          : {})
    });
  }

  static Future<Response> get(String url) {
    return Dio().get(
      apiURL + url,
      options: Options(headers: getHeaders()),
    );
  }

  static Future<Response> post(String url, Object object) {
    return Dio().post(
      apiURL + url,
      options: Options(headers: getHeaders()),
      data: jsonEncode(object),
    );
  }

  static Future<Response> upload(String url, Object object) {
    return Dio().post(
      apiURL + url,
      options: Options(headers: getHeaders()),
      data: object,
    );
  }

  static Future<Response> delete(String url, Object object) {
    return Dio().delete(
      apiURL + url,
      options: Options(headers: getHeaders()),
      data: jsonEncode(object),
    );
  }

  static Future<Response> put(String url, Object object) {
    return Dio().put(
      apiURL + url,
      options: Options(headers: getHeaders()),
      data: jsonEncode(object),
    );
  }

  static successHandler(Response<dynamic> response) {
    String message = response.data['message'];
    if (message != null) {
      SnackbarHandler.successToast(message, "");
    }
  }

  static errorHandler(DioError e) {
    print(e.response.data);
    if (e.response != null) {
      String message = e.response.data['message'];
      if (message != null) {
        SnackbarHandler.errorToast(message, "");
      }
    } else {
      SnackbarHandler.errorToast("Failed to connect to server", "");
    }
  }
}
