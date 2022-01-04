import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart'; //library for going to next pages
import 'package:web_store_management/Backend/GlobalController.dart';
import 'package:web_store_management/Backend/Login_operation.dart';

import 'Drawers/NotificationDrawer.dart';
import 'Drawers/ProfileDrawer.dart';

class TopBar extends StatefulWidget with PreferredSizeWidget {
  final Function? updateTitle;
  final String? title;
  TopBar({this.updateTitle, this.title});

  @override
  _TopBar createState() => _TopBar();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _TopBar extends State<TopBar> {
  var controller = GlobalController();
  var login = Login();
  String? title;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.title.toString());
    return AppBar(
      title: Text(
        title.toString(),
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
            onPressed: () {
              login.logout(); //destroys the session
              Navigator.pushNamed(context, '/logout');
            },
          ),
        ),
      ],
    );
  }
}
