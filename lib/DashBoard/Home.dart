import 'package:flutter/material.dart';

import '../Navbar/NavDrawer.dart';
import '../Navbar/TopBar.dart';



class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: NavDrawer(),
    );
  }
}
