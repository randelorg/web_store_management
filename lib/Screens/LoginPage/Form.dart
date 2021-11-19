import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:web_store_management/Notification/Snack_notification.dart';
import '../../Backend/Login_operation.dart';
import '../../Backend/GlobalController.dart';

class Body extends StatefulWidget {
  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
  var login = Login();
  var controller = GlobalController();

  String administrator = 'Administrator';
  String storeAttendant = 'Store Attendant';
  String? loginRole;

  @override
  void initState() {
    super.initState();
    //get all the admin account and compare
    //in-app authentication of users
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
            child: _formLogin(),
          ),
        )
      ],
    );
  }

  Widget _formLogin() {
    final username = TextEditingController();
    final password = TextEditingController();

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
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.blue.shade700),
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
            counterText: 'Forgot password?',
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
                child: Text("Sign In"),
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.redAccent.shade200,
              onPrimary: Colors.white,
            ),
            onPressed: () {
              if (username.text.isEmpty || password.text.isEmpty) {
                SnackNotification.notif("Error", "Please fill all the fields");
              } else {
                login
                    .mainLogin(
                        administrator.toString(), username.text, password.text)
                    .then((value) {
                  setState(() {
                    if (value) {
                      Navigator.pushNamed(context, '/home');
                    } else {
                      SnackNotification.notif(
                          "Error", "Wrong username or password");
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
