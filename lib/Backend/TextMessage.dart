import 'dart:convert';
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
        "Good day $name, \n\nYour credit has been approved. You can now visit the store. \n\nDellrain Store";

    try {
      var response = await http
          .post(Uri.parse(_singleMessageUrl).replace(queryParameters: {
        "apikey": _apikey,
        "number": number,
        "message": message,
        "sendername": "DELLRAINS"
      }));

      if (response.statusCode == 200) {
        print(response.body);
        return true;
      } else {
        print('wow response ' + response.statusCode.toString());
      }
    } catch (e, s) {
      print('amazing $e');
      print('amazing $s');
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
  Future<bool> sendRepairedProduct(
      String name, String number, String product) async {
    try {
      var payload = json.encode(
        {
          "apikey": _apikey,
          "number": number,
          "message":
              "Dear $name,\n\nYour $product has been repaired.\n\nThank you for using our service.\n\nRegards,\n\nTeam Dellrain Repair",
          "sendername": "SEMAPHORE"
        },
      );

      final response = await http.post(
        Uri.parse(_singleMessageUrl),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
        body: payload,
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
  Future<bool> sendRequestedProduct(
      String name, String number, String product) async {
    try {
      var payload = json.encode(
        {
          "apikey": _apikey,
          "number": number,
          "message":
              "Good day $name, \n\nYour requested product which is $product is now at the store. Visit the store and get your requested product and for further arrangements. \n\nDellrain Store",
          "sendername": "SEMAPHORE"
        },
      );

      final response = await http.post(
        Uri.parse(_singleMessageUrl),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: payload,
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
