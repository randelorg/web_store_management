import 'package:flutter/material.dart';
import 'package:web_store_management/Pages/Navbar/NavDrawerAttendant.dart';
import 'package:web_store_management/Pages/Navbar/TopBar.dart';

class HomeAttendant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: NavDrawerAttendant(),
    );
  }
}
