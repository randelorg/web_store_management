import 'package:flutter/material.dart';
import '../Navbar/NavDrawerAdmin.dart';
import '../Navbar/TopBar.dart';

class HomeAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: NavDrawerAdmin(),
    );
  }
}
