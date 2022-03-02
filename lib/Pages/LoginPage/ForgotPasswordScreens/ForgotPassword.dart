import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Backend/TextMessage.dart';
import 'package:web_store_management/Notification/Snack_notification.dart';
import 'package:web_store_management/Pages/LoginPage/ForgotPasswordScreens/OTPVerification.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPassword createState() => _ForgotPassword();
}

class _ForgotPassword extends State<ForgotPassword> {
  final mobileNumber = TextEditingController();
  var message = TextMessage();
  var otpCode;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.only(bottom: 5, left: 5, right: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actions: <Widget>[
        Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(
                  Icons.cancel,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Text(
              'Forgot Password',
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: HexColor("#155293"),
                fontFamily: 'Cairo_Bold',
                fontSize: 30,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 25, left: 7),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Enter Last 4 Digits Of Your Mobile Number',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: TextField(
                controller: mobileNumber,
                maxLength: 12,
                decoration: InputDecoration(
                  counterText: '',
                  hintText: 'Mobile Number',
                  filled: true,
                  fillColor: Colors.blueGrey[50],
                  labelStyle: TextStyle(fontSize: 10),
                  contentPadding: EdgeInsets.only(left: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey.shade50),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey.shade50),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(color: HexColor("#155293")),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 15, bottom: 15),
                        primary: Colors.white,
                        textStyle: TextStyle(
                            fontFamily: 'Cairo_SemiBold',
                            fontSize: 14,
                            color: Colors.white),
                      ),
                      child: const Text('GET OTP'),
                      onPressed: () {
                        message
                            .checkNumberIfExisting(mobileNumber.text)
                            .then((value) {
                          if (value == 0) {
                            SnackNotification.notif('Not found',
                                'Number does not exit', Colors.red.shade600);
                          } else {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return OTPVerification(code: value);
                              },
                            );
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
