import 'package:flutter/material.dart';
import 'package:web_store_management/Pages/LoginPage/LoginPage.dart';

class FrontLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFF),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MediaQuery.of(context).size.width >= 880
              ? LoginPage()
              : SizedBox(), // Responsive
        ],
      ),
    );
  }
}
