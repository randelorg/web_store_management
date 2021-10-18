import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'LoginPage/LoginPage.dart';
import 'DashBoard/Home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Dellrains Store Management System',
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
