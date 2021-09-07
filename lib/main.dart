import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'LoginPage/LoginPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      title: 'Dellrains Store Management System',
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
