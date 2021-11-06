import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart'; //library for going to next pages

import 'Form.dart';

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
              ? Body()
              : SizedBox(), // Responsive
        ],
      ),
    );
  }
}
