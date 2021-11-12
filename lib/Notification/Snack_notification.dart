import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snack.dart';

class SnackNotification {
  static void notif(String title, String message) {
    Get.snackbar(
      title, //title of the snackbar
      message, //content of the snackbar
      backgroundColor: Colors.redAccent.shade200,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 20,
      margin: EdgeInsets.all(20),
      duration: Duration(seconds: 3),
    );
  }
}
