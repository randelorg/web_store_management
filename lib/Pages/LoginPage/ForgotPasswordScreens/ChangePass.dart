import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Backend/AdminOperation.dart';
import 'package:web_store_management/Notification/Snack_notification.dart';

import '../../../Backend/Utility/Mapping.dart';

class ChangePass extends StatefulWidget {
  @override
  _ChangePass createState() => _ChangePass();
}

class _ChangePass extends State<ChangePass> {
  var admin = AdminOperation();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();
  String error = '';
  String? name;
  @override
  void initState() {
    setState(() {
      name = Mapping.forgetPassword.last.toString();
    });
    super.initState();
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
              'Change Password',
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: HexColor("#155293"),
                fontFamily: 'Cairo_Bold',
                fontSize: 30,
              ),
            ),

            Text(      
              'Hello $name! you will be changing your password',
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(        
                fontSize: 12,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 20, left: 7),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'New Password',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: TextField(
                controller: newPassword,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'New Password',
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
              padding: EdgeInsets.only(left: 7),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Confirm Password',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 0),
              child: TextField(
                controller: confirmPassword,
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    if (value.length > 0) {
                      if (value == newPassword.text) {
                        error = 'Password match';
                      } else {
                        error = 'Password did not match';
                      }
                    }
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
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
            Text(
              error,
              style: TextStyle(fontSize: 10),
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
                      child: const Text('CONFIRM'),
                      onPressed: () {
                        if (newPassword.text.isEmpty || confirmPassword.text.isEmpty) {
                          SnackNotification.notif(
                            "Error",
                            "Please fill all the fields",
                            Colors.red.shade600);
                        } else if (newPassword.text != confirmPassword.text){
                          SnackNotification.notif(
                            "Error",
                            "Password did not match",
                            Colors.red.shade600);                   
                        } else {
                          admin
                              .changePassword(
                                  Mapping.forgetPassword.last.getAdminID,
                                  newPassword.text)
                              .then((value) {
                            if (value) {
                              Navigator.pop(context);
                              SnackNotification.notif(
                                'Success',
                                'Password changed, please now log in',
                                Colors.green.shade900,
                              );
                            }
                          });
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
