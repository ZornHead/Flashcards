import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarHandler {
  static errorToast(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  static normalToast(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.black,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  static warningToast(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.yellowAccent,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  static successToast(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
