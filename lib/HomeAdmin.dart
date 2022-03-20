import 'package:flutter/material.dart';
import 'package:web_store_management/Pages/Navbar/NavDrawerAdmin.dart';
import 'package:web_store_management/Pages/Navbar/TopBar.dart';
class HomeAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: NavDrawerAdmin(),
    );
  }
}
