import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Notification/Snack_notification.dart';
import '../../Backend/LoginOperation.dart';
import '../../Backend/GlobalController.dart';

class BodyLogin extends StatefulWidget {
  @override
  _BodyLogin createState() => _BodyLogin();
}

class _BodyLogin extends State<BodyLogin> {
  var login = Login();
  var controller = GlobalController();
  final username = TextEditingController();
  final password = TextEditingController();

  String administrator = 'Administrator';
  String storeAttendant = 'Store Attendant';
  String? loginRole;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MediaQuery.of(context).size.width >= 800 //Responsive
            ? Image.asset(
                'images/login-logo.jpg',
                width: 350,
              )
            : SizedBox(),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 40),
          child: Container(
            width: 300,
            child: _formLogin(context),
          ),
        )
      ],
    );
  }

  Widget _formLogin(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Container(
            width: 300,
            decoration: BoxDecoration(
              color: Colors.blueGrey[50],
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.blueGrey.shade50,
                style: BorderStyle.solid,
                width: 0.80,
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: administrator,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: HexColor("#155293")),
                onChanged: (role) {
                  setState(() {
                    administrator = role!;
                  });
                },
                items: <String>['Administrator', 'Store Attendant']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        TextField(
          controller: username,
          decoration: InputDecoration(
            hintText: 'Username',
            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: TextStyle(fontSize: 12),
            contentPadding: EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade50),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade50),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          controller: password,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Password',
            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: TextStyle(fontSize: 12),
            contentPadding: EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade50),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade50),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        TextButton(
          child: Text(
            'Forgot password?',
            style: TextStyle(
              fontSize: 11,
            ),
          ),
          onPressed: () {},
        ),
        SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.shade100,
                spreadRadius: 10,
                blurRadius: 20,
              ),
            ],
          ),
          child: ElevatedButton(
            child: Container(
              width: double.infinity,
              height: 50,
              child: Center(
                child: Text(
                  "Sign In",
                  style: TextStyle(fontFamily: 'Cairo_Bold', fontSize: 18),
                ),
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: HexColor("#EA1C24"),
              onPrimary: Colors.white,
            ),
            onPressed: () {
              if (username.text.isEmpty || password.text.isEmpty) {
                SnackNotification.notif(
                  "Error",
                  "Please fill all the fields",
                  Colors.red.shade600,
                );
              } else {
                login
                    .mainLogin(
                  administrator.toString(),
                  username.text,
                  password.text,
                )
                    .then((value) {
                  setState(() {
                    if (value) {
                      Navigator.pushNamed(context, '/home');
                    } else {
                      SnackNotification.notif(
                        "Error",
                        "Wrong username or password",
                        Colors.red.shade600,
                      );
                    }
                  });
                });
              }
            },
          ),
        ),
      ],
    );
  }
}
