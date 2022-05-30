import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../Backend/AdminOperation.dart';
import '../../Notification/BannerNotif.dart';

// ignore: must_be_immutable
class ConfirmAccount extends StatefulWidget {
  String firstname, lastname, mobileNumber, homeAddress, username, password;
  Uint8List image;
  //constructor
  ConfirmAccount({
    required this.firstname,
    required this.lastname,
    required this.mobileNumber,
    required this.homeAddress,
    required this.username,
    required this.password,
    required this.image,
  });

  @override
  _ConfirmAccount createState() => _ConfirmAccount();
}

class _ConfirmAccount extends State<ConfirmAccount> {
  final password = TextEditingController();
  var admin = AdminOperation();

  void clearText() {
    password.clear();
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
              'Verification',
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: HexColor("#155293"),
                fontFamily: 'Cairo_Bold',
                fontSize: 30,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 2),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Enter your Admin Password to Verify',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Container(
              width: 320,
              child: Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Admin Password',
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: HexColor("#155293"),
                            ),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 15, bottom: 15),
                            primary: Colors.white,
                            textStyle: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            if (password.text.isEmpty) {
                              BannerNotif.notif(
                                  "Error",
                                  "Please fill the password field",
                                  Colors.red.shade600);
                            } else {
                              bool status = admin.verifyAdmin(password.text);
                              if (status) {
                                admin.createAdminAccount(
                                  widget.firstname,
                                  widget.lastname,
                                  widget.mobileNumber,
                                  widget.homeAddress,
                                  widget.username,
                                  widget.password,
                                  widget.image,
                                );
                                Navigator.pop(context);
                              } else {
                                BannerNotif.notif('Try again', 'Wrong Password',
                                    Colors.red.shade600);
                              }
                            }
                          },
                          child: Text(
                            'VERIFY',
                            style: TextStyle(
                                fontFamily: 'Cairo_SemiBold',
                                fontSize: 14,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
