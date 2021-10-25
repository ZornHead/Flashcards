import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/network_client.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ContactController extends GetxController {
  RxBool loading = false.obs;

  contactUs(
      {@required String name,
      @required String subject,
      @required String message,
      Function onSuccess}) async {
    try {
      loading.value = true;
      final response = await NetworkClient.post('/contactUs', {
        "name": name,
        "subject": subject,
        "message": message,
      });
      if (response.statusCode == 200) {
        // NetworkClient.successHandler(response);
        onSuccess();
      }
    } on DioError catch (e) {
      NetworkClient.errorHandler(e);
    } finally {
      loading.value = false;
    }
  }
}
