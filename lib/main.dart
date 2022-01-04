import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Pages/LoginPage/LoginPage.dart';
import 'Pages/DashBoard/Home.dart';

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
