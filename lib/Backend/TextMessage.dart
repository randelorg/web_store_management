import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:web_store_management/Notification/Snack_notification.dart';
import 'package:web_store_management/Backend/Interfaces/ITextMessage.dart';

class TextMessage implements ITextMessage {
  //ignore: non_constant_identifier_names
  final String _APIKEY = "a9eca54684a3d81ace2d45da8472cc0f";

  @override
  Future<bool> sendApprovedCredit(String name, String number) async {
    try {
      var payload = json.encode({
        "apikey": _APIKEY,
        "number": number,
        "message":
            "Good day $name , \n\nYour credit has been approved. You can now visit the store. \n\nDellrain Store",
        "sendername": "SEMAPHORE"
      });

      final response = await http.post(
        Uri.parse("https://api.semaphore.co/api/v4/messages"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Access-Control-Allow-Headers": "*"
        },
        body: payload,
      );

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print('amazing ' + e.toString());
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
          "apikey": _APIKEY,
          "number": number,
          "message":
              "Dear $name,\n\nYour $product has been repaired.\n\nThank you for using our service.\n\nRegards,\n\nTeam Dellrain Repair",
          "sendername": "SEMAPHORE"
        },
      );

      final response = await http.post(
        Uri.parse("https://api.semaphore.co/api/v4/messages"),
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
          "apikey": _APIKEY,
          "number": number,
          "message":
              "Good day $name, \n\nYour requested product which is $product is now at the store. Visit the store and get your requested product and for further arrangements. \n\nDellrain Store",
          "sendername": "SEMAPHORE"
        },
      );

      final response = await http.post(
        Uri.parse("https://api.semaphore.co/api/v4/messages"),
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
