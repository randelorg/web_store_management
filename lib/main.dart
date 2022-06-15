import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:web_store_management/Home.dart';
import 'package:web_store_management/Pages/LoginPage/FrontLogin.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Dellrains Store Management System',
      theme: ThemeData(
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color:Colors.amber),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => FrontLogin(),
        '/home': (context) => Home(),
        '/logout': (context) => FrontLogin(),
      },
    );
  }
}
