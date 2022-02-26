import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:web_store_management/Notification/Snack_notification.dart';
import 'package:web_store_management/Backend/Interfaces/ITextMessage.dart';

class TextMessage implements ITextMessage {
  //ignore: non_constant_identifier_names
  final String _apikey = "a9eca54684a3d81ace2d45da8472cc0f";
  final String _singleMessageUrl = "https://api.semaphore.co/api/v4/messages/";

  ///api/v4/messages
  @override
  Future<bool> sendApprovedCredit(String name, String number) async {
    final String message =
        "Dear $name, \n\nYour credit has been approved. You can now visit the store. \n\nDellrain Store";

    try {
      var response = await http.post(
        Uri.parse(_singleMessageUrl).replace(queryParameters: {
          "apikey": _apikey,
          "number": number,
          "message": message,
          "sendername": "DELLRAINS"
        }),
      );

      if (response.statusCode == 200) {
        print(response.body);
        return true;
      } else {
        print('wow response ' + response.statusCode.toString());
      }
    } catch (e) {
      print('amazing $e');
      //if there is an error in the method
      SnackNotification.notif(
        "Error",
        "Something went wrong while sending the message",
        Colors.red.shade600,
      );
      return false;
    }

    return true;
  }

  @override
  Future<bool> sendPromotions() {
    // TODO: implement sendPromotions
    throw UnimplementedError();
  }

  @override
  Future<bool> sendRequestedProduct(
      String name, String number, String product) async {
    try {
      final String message =
          "Dear $name, \n\nThe $product you requested is now at the store. \n\nThank you for using our service. Visit the store anytime within 8:00AM to 5:00PM.\n\nRegards,\n\nTeam Dellrain Repair";

      var response = await http.post(
        Uri.parse(_singleMessageUrl).replace(queryParameters: {
          "apikey": _apikey,
          "number": number,
          "message": message,
          "sendername": "DELLRAINS"
        }),
      );

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print(e.toString());
      //if there is an error in the method
      SnackNotification.notif(
        "Error",
        "Something went wrong while sending the message",
        Colors.red.shade600,
      );
      return false;
    }

    return true;
  }

  @override
  Future<bool> sendRepairedProduct(
      String name, String number, String product) async {
    final String message =
        "Dear $name,\n\nYour $product has been repaired.\n\nThank you for using our service. Visit the store anytime within 8:00AM to 5:00PM \n\nRegards,\n\nTeam Dellrain Repair";

    try {
      var response = await http.post(
        Uri.parse(_singleMessageUrl).replace(queryParameters: {
          "apikey": _apikey,
          "number": number,
          "message": message,
          "sendername": "DELLRAINS"
        }),
      );

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print(e.toString());
      //if there is an error in the method
      SnackNotification.notif(
        "Error",
        "Something went wrong while sending the message",
        Colors.red.shade600,
      );
      return false;
    }

    return true;
  }

  @override
  Future<bool> getOtp(String number) {
    // TODO: implement getOtp
    throw UnimplementedError();
  }
}
