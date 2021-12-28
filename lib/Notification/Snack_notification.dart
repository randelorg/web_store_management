import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackNotification {
  static void notif(String title, String message, Color color) {
    Get.snackbar(
      title, //title of the snackbar
      message, //content of the snackbar
      backgroundColor: color,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      borderRadius: 20,
      margin: EdgeInsets.all(20),
      duration: Duration(seconds: 3),
    );
  }
}
