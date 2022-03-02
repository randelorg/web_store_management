import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:web_store_management/Notification/Snack_notification.dart';
import 'package:web_store_management/Backend/Interfaces/ITextMessage.dart';

class TextMessage implements ITextMessage {
  //ignore: non_constant_identifier_names
  final String _apikey = "a9eca54684a3d81ace2d45da8472cc0f";
  final String _singleMessageUrl = "https://api.semaphore.co/api/v4/messages";

  ///api/v4/messages
  @override
  Future<bool> sendApprovedCredit(String name, String number) async {
    final String message =
        "Dear $name, \n\nYour credit has been approved. You can now visit the store. \n\nDellrain Store";

    var payload = json.encode({
      "apikey": _apikey,
      "number": number,
      "message": message,
      "sendername": "DELLRAINS"
    });

    try {
      final response = await http.post(
        Uri.parse("http://localhost:8090/api/sendmessage"),
        body: payload,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        print(response.body);
        return true;
      } else {
        print('wow response ' + response.statusCode.toString());
      }
    } catch (e) {
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
    final String message =
        "Dear $name, \n\nThe $product you requested is now at the store. \n\nThank you for using our service. Visit the store anytime within 8:00AM to 5:00PM.\n\nRegards,\n\nTeam Dellrain Repair";

    var payload = json.encode({
      "apikey": _apikey,
      "number": number,
      "message": message,
      "sendername": "DELLRAINS"
    });

    try {
      final response = await http.post(
        Uri.parse("http://localhost:8090/api/sendmessage"),
        body: payload,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
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

    var payload = json.encode({
      "apikey": _apikey,
      "number": number,
      "message": message,
      "sendername": "DELLRAINS"
    });

    try {
      final response = await http.post(
        Uri.parse("http://localhost:8090/api/sendmessage"),
        body: payload,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
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
  Future<int> getOtp(String number) async {
    final String message =
        "Your One Time Password is: {otp}. Please use it within 5 minutes.\n\nRegards,\n\nTeam Dellrain";

    var payload = json.encode({
      "apikey": _apikey,
      "number": number,
      "message": message,
      "sendername": "DELLRAINS"
    });

    Map<String, dynamic> otpCode;

    try {
      final response = await http.post(
        Uri.parse("http://localhost:8090/api/otp"),
        body: payload,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      );

      otpCode = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return otpCode["code"];
      }
    } catch (e, s) {
      print(s.toString());
      print(e.toString());
      //if there is an error in the method
      SnackNotification.notif(
        "Error",
        "Something went wrong while sending the message",
        Colors.red.shade600,
      );
      return 0;
    }

    return otpCode["code"];
  }
}
