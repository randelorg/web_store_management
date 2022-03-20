import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart'; //library for going to next pages
import 'package:web_store_management/Backend/GlobalController.dart';
import 'package:web_store_management/Backend/LoginOperation.dart';
import 'package:web_store_management/Backend/Session.dart';

import 'Drawers/NotificationDrawer.dart';
import 'Drawers/ProfileDrawer.dart';

class TopBar extends StatefulWidget with PreferredSizeWidget {
  @override
  _TopBar createState() => _TopBar();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _TopBar extends State<TopBar> {
  var controller = GlobalController();
  var login = Login();

  @override
  void initState() {
    Session.getid().then((id) {
      setState(() {
        if (id.isEmpty) {
          Navigator.pushReplacementNamed(context, '/logout');
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Dellrains Management System',
        style: TextStyle(
          color: HexColor("#155293"),
          fontFamily: 'Cairo_Bold',
          fontSize: 25,
        ),
      ),
      automaticallyImplyLeading: true,
      centerTitle: true,
      backgroundColor: Colors.white,
      leading: Image.asset('../assets/images/store-logo.png'),
      leadingWidth: 100,
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Container(
            child: NotificationDrawer(),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Container(
            child: ProfileDrawer(),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 30),
          child: IconButton(
            icon: Icon(Icons.logout, color: HexColor("#EA1C24")),
            tooltip: 'Logout',
            onPressed: () async {
              await login.logout().then((value) {
                if (value) {
                  Navigator.pushReplacementNamed(context, '/logout');
                }
              }); //destroys the session
            },
          ),
        ),
      ],
    );
  }
}
