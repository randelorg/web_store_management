import 'package:flutter/material.dart';
import 'package:get/get.dart'; //library for going to next pages
import 'package:web_store_management/LoginPage/LoginPage.dart';

import 'NotificationDrawer.dart';
import 'ViewProfile.dart';

class TopBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'DASHBOARD',
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),

      //automaticallyImplyLeading: true,
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
          child: IconButton(
            icon: const Icon(Icons.person, color: Colors.blue),
            tooltip: 'Profile',
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ViewProfile();
                  });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 30),
          child: IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            tooltip: 'Logout',
            onPressed: () {
              Get.to(LoginPage());
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
