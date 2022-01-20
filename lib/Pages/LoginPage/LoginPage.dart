import 'package:flutter/material.dart'; //library for going to next pages
import 'BodyLogin.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFF),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MediaQuery.of(context).size.width >= 880
              ? BodyLogin()
              : SizedBox(), // Responsive
        ],
      ),
    );
  }
}
