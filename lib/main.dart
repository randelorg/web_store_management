import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Screens/LoginPage/LoginPage.dart';
import 'Screens/DashBoard/Home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Dellrains Store Management System',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => Home(),
        '/logout': (context) => LoginPage(),
      },
    );
  }
}
