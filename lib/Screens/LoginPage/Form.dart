import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart'; //library for going to next pages

import '../DashBoard/Home.dart';
import '../../Backend/GlobalController.dart';

class Body extends StatefulWidget {
  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
  var controller = GlobalController();

  @override
  void initState() {
    super.initState();
    controller.fetchAdmin();
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
            child: _formLogin(controller),
          ),
        )
      ],
    );
  }
}

Widget _formLogin(GlobalController controller) {
  final username = TextEditingController();
  final password = TextEditingController();

  return Column(
    children: [
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
      SizedBox(height: 30),
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
      SizedBox(height: 40),
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
              Get.snackbar(
                "Error",
                "Please fill all the fields",
                backgroundColor: Colors.redAccent.shade200,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
                borderRadius: 20,
                margin: EdgeInsets.all(20),
                duration: Duration(seconds: 3),
              );
            } else {
              switch (controller.login(username.text, password.text)) {
                case 'success':
                  Get.to(Home());
                  break;
                case 'failed':
                  Get.snackbar(
                    "Error",
                    "Username and password are incorrect",
                    backgroundColor: Colors.redAccent.shade200,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                    borderRadius: 20,
                    margin: EdgeInsets.all(20),
                    duration: Duration(seconds: 3),
                  );
                  break;
              }
            }
          },
        ),
      ),
    ],
  );
}
