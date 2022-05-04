import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:web_store_management/Models/ForgetPasswordModel.dart';
import 'package:web_store_management/Notification/BannerNotif.dart';
import 'package:web_store_management/Backend/Interfaces/ITextMessage.dart';
import 'package:web_store_management/environment/Environment.dart';
import 'Utility/Mapping.dart';
import 'dart:io';

class TextMessage implements ITextMessage {
  String message = "";

  ///api/v4/messages
  @override
  Future<bool> sendApprovedCredit(
      String name, String number, String status) async {
    if (status == "APPROVED") {
      message =
          "Dear $name,\n\nYour credit has been $status. You can now visit the store. \n\n- Team Dellrains Store";
    } else {
      message =
          "Dear $name,\n\nSorry your credit has been $status. \n\n- Team Dellrains Store";
    }

    var payload, response;
    payload = json.encode(
      {"number": number, "message": message, "sendername": "DELLRAINS"},
    );

    try {
      await Environment.methodPost(
              "${Environment.apiUrl}/api/sendmessage", payload)
          .then((value) {
        response = value;
      });

      if (response.statusCode == 200) {
        print(response.body);
        return true;
      }
    } catch (e) {
      //if there is an error in the method
      BannerNotif.notif(
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
    throw UnimplementedError();
  }

  @override
  Future<bool> sendRequestedProduct(
      String name, String number, String product, String status) async {
    if (status == "IN-STORE") {
      message =
          "Dear $name,\n\nThe $product you requested is now at the store.\nThank you for using our service. Visit the store anytime within 8:00AM to 5:00PM.\n\nRegards,\n- Team Dellrains Store";
    } else {
      message =
          "Dear $name,\n\nThe $product you requested is $status.\nThank you for using our service. \n\nRegards,\n- Team Dellrains Store";
    }

    var payload, response;
    payload = json.encode(
      {"number": number, "message": message, "sendername": "DELLRAINS"},
    );

    try {
      await Environment.methodPost(
              "${Environment.apiUrl}/api/sendmessage", payload)
          .then((value) {
        response = value;
      });

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print(e.toString());
      //if there is an error in the method
      BannerNotif.notif(
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
      String name, String number, String product, String status) async {
    if (status == "REPAIRED") {
      message =
          "Dear $name,\n\nYour $product has been $status.\nThank you for using our service. Visit the store anytime within 8:00AM to 5:00PM. \n\nRegards,\n- Team Dellrains Store";
    } else {
      message =
          "Dear $name,\n\nYour $product has been $status.\nThank you for using our service. Visit the store anytime within 8:00AM to 5:00PM. \n\nRegards,\n- Team Dellrains Store";
    }

    var payload, response;
    payload = json.encode(
      {"number": number, "message": message, "sendername": "DELLRAINS"},
    );

    try {
      await Environment.methodPost(
              "${Environment.apiUrl}/api/sendmessage", payload)
          .then((value) {
        response = value;
      });

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print(e.toString());
      //if there is an error in the method
      BannerNotif.notif(
        "Error",
        "Something went wrong while sending the message",
        Colors.red.shade600,
      );
      return false;
    }

    return true;
  }

  Future<int> checkNumberIfExisting(String mobile) async {
    int otp = 0;
    var response;
    try {
      await Environment.methodGet(
              "${Environment.apiUrl}/api/otpcheckpoint/$mobile")
          .then((value) {
        response = value;
      });

      if (response.statusCode == 404) {
        return 0;
      } else if (response.statusCode == 202) {
        Map<String, dynamic> details =
            jsonDecode(response.body) as Map<String, dynamic>;

        var detail = ForgetPasswordModel.fromJson(details);

        Mapping.forgetPassword.add(ForgetPasswordModel(
          detail.getPersonID,
          detail.getAdminID,
          detail.getMobilenumber,
          detail.getFirstname,
          detail.getLastname,
        ));

        await getOtp(Mapping.forgetPassword.last.getMobilenumber)
            .then((value) => otp = value);

        return otp;
      }
    } catch (e, s) {
      print(s.toString());
      print(e.toString());
      //if there is an error in the method
      BannerNotif.notif(
        "Error",
        "Something went wrong while finding the mobile number",
        Colors.red.shade600,
      );
      return 0;
    }

    return otp;
  }

  @override
  Future<int> getOtp(String number) async {
    final String message =
        "Your One Time Password is: {otp}. Please use it within 5 minutes.\n\nRegards,\n\n- Team Dellrains";

    var payload, response;
    payload = json.encode(
        {"number": number, "message": message, "sendername": "DELLRAINS"});

    Map<String, dynamic> otpCode;

    try {
      await Environment.methodPost("${Environment.apiUrl}/api/otp", payload)
          .then((value) {
        response = value;
      });

      otpCode = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return otpCode["code"];
      }
    } catch (e) {
      //if there is an error in the method
      BannerNotif.notif(
        "Error",
        "Something went wrong while sending the message",
        Colors.red.shade600,
      );
      return 0;
    }

    return otpCode["code"];
  }
}
