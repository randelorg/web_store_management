import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../Backend/Admin_operation.dart';
import '../../Notification/Snack_notification.dart';

// ignore: must_be_immutable
class ConfirmAccount extends StatefulWidget {
  String? firstname, lastname, mobileNumber, homeAddress, username, password;
  Uint8List? image;
  //constructor
  ConfirmAccount({
    this.firstname,
    this.lastname,
    this.mobileNumber,
    this.homeAddress,
    this.username,
    this.password,
    this.image,
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
      actionsPadding: EdgeInsets.all(20),
      title: Text(
        'Verification',
        softWrap: true,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 35,
          color: Colors.blue,
          overflow: TextOverflow.fade,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actions: <Widget>[
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text('Enter your password to verify'),
                ),
              ),
            ),
            Divider(
              thickness: 3,
            ),
            Container(
              width: 300,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
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
                  padding: const EdgeInsets.only(top: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.blue,
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
                              SnackNotification.notif('Try again',
                                  'Wrong Password', Colors.red.shade600);
                            }
                          },
                          child: const Text('VERIFY'),
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
