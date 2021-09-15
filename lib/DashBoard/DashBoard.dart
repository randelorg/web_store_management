import 'package:flutter/material.dart';

import 'NavDrawer.dart';
import 'TopBar.dart';



class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      //drawer: NavDrawer(),
      //backgroundColor: Color(0xFFFFFF),
     body: Center(
        child: NavDrawer(),
      ),
    );
  }
}

// class Body extends StatefulWidget {
//   @override
//   _Body createState() => _Body();
// }

// class _Body extends State<Body> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children:[
//         Container(
//           alignment: Alignment.center,
//           width: 400,
//           height: 400,
//           //child: navBar(),  
//         ),
//       ],
//     );
//   }
// }
