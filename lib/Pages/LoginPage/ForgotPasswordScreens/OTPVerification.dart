import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Pages/LoginPage/ForgotPasswordScreens/ChangePass.dart';

import '../../../Notification/Snack_notification.dart';

class OTPVerification extends StatefulWidget {
  final int? code;
  OTPVerification({required this.code});
  @override
  _OTPVerification createState() => _OTPVerification();
}

class _OTPVerification extends State<OTPVerification> {
  final verifyOTP = TextEditingController();
  String continueTimer = "Continue";
  int counter = 0;

  bool checkOtp(int code) {
    if (code == widget.code)
      return true;
    else
      return false;
  }

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
              'OTP Verification',
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
                  'Enter OTP',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: TextField(
                controller: verifyOTP,
                maxLength: 6,
                decoration: InputDecoration(
                  counterText: '',
                  hintText: 'Enter OTP',
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
              padding: const EdgeInsets.only(top: 10),
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
                      child: Text(continueTimer),
                      onPressed: () {
                        if (verifyOTP.text.isEmpty) {
                          SnackNotification.notif(
                            "Error",
                            "Please fill the OTP field",
                            Colors.red.shade600,
                          );
                        } else {
                          if (checkOtp(int.parse(verifyOTP.text))) {
                            Navigator.of(context).pop();
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ChangePass();
                              },
                            );
                          } else {
                            setState(() {
                              counter++;
                            });

                            if (counter >= 3) {
                              Navigator.pop(context);
                              //attempted to enter wrong OTP 3 times
                              SnackNotification.notif(
                                'WRONG OTP',
                                'You enter wrong OTP for 3 times, try again in few minutes or contact your IT administrator',
                                Colors.red.shade600,
                              );
                            }
                            //show snackbar that the otp is wrong
                            SnackNotification.notif(
                              'Try again',
                              'Wrong OTP',
                              Colors.red.shade600,
                            );
                          }
                        }
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
