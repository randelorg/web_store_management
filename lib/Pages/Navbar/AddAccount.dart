import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Notification/BannerNotif.dart';
import '../../Helpers/HashingHelper.dart';
import 'ConfirmNewAccount.dart';
import '../../Helpers/FilePickerHelper.dart';

class AddAccount extends StatefulWidget {
  @override
  _AddAccount createState() => _AddAccount();
}

class _AddAccount extends State<AddAccount> {
  //classes
  var pick = Picker();
  var hash = Hashing();
  //dipslay the image name
  String fileName = 'Select account image';
  String error = '';
  //getting the text in the field
  final username = TextEditingController();
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final mobileNumber = TextEditingController();
  final homeAddress = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

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
              'New Manager Account',
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Cairo_Bold',
                fontSize: 27,
                color: HexColor("#155293"),
                overflow: TextOverflow.fade,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 2),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Username',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Container(
              width: 320,
              child: Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: TextField(
                  controller: username,
                  decoration: InputDecoration(
                    hintText: 'Username',
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
            Padding(
              padding: EdgeInsets.only(left: 2),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Fullname',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      width: 155,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: TextField(
                          controller: firstname,
                          decoration: InputDecoration(
                            hintText: 'Firstname',
                            filled: true,
                            fillColor: Colors.blueGrey[50],
                            labelStyle: TextStyle(fontSize: 10),
                            contentPadding: EdgeInsets.only(left: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueGrey.shade50),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueGrey.shade50),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      width: 155,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: TextField(
                          controller: lastname,
                          decoration: InputDecoration(
                            hintText: 'Lastname',
                            filled: true,
                            fillColor: Colors.blueGrey[50],
                            labelStyle: TextStyle(fontSize: 10),
                            contentPadding: EdgeInsets.only(left: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueGrey.shade50),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueGrey.shade50),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 2),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Mobile Number',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
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
              padding: EdgeInsets.only(left: 2),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Home Address',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: TextField(
                controller: homeAddress,
                decoration: InputDecoration(
                  hintText: 'Home Address',
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
              padding: EdgeInsets.only(left: 2),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Password',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
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
            Padding(
              padding: EdgeInsets.only(left: 2),
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
                      if (value == password.text) {
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
            Container(
              alignment: Alignment.topLeft,
              child: TextButton.icon(
                onPressed: () {
                  pick.pickFile().then((value) {
                    setState(() {
                      fileName = value;
                    });
                  });
                },
                icon: Icon(Icons.file_upload, color: HexColor("#155293")),
                label: Text(
                  fileName,
                  style: TextStyle(color: HexColor("#155293")),
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
                            if (username.text.isEmpty ||
                                firstname.text.isEmpty ||
                                lastname.text.isEmpty ||
                                mobileNumber.text.isEmpty ||
                                homeAddress.text.isEmpty ||
                                password.text.isEmpty ||
                                confirmPassword.text.isEmpty) {
                              BannerNotif.notif(
                                  "Error",
                                  "Please fill all the fields",
                                  Colors.red.shade600);
                            } else if (pick.image == null) {
                              BannerNotif.notif(
                                  "Error",
                                  "Please upload an account image (jpg, png, or jpeg)",
                                  Colors.red.shade600);
                            } else if (password.text != confirmPassword.text) {
                              BannerNotif.notif(
                                  "Error",
                                  "Password did not match",
                                  Colors.red.shade600);
                            } else {
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ConfirmAccount(
                                    firstname: firstname.text,
                                    lastname: lastname.text,
                                    mobileNumber: mobileNumber.text,
                                    homeAddress: homeAddress.text,
                                    username: username.text,
                                    password: hash.encrypt(password.text),
                                    image: pick.getImageBytes(),
                                  );
                                },
                              );
                            }
                          },
                          child: Text(
                            'CONFIRM',
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
