import 'package:flutter/material.dart';
import 'package:get/get.dart'; //library for going to next pages
import 'package:web_store_management/LoginPage/LoginPage.dart';

class TopBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'DELLRAINS STORE MANAGEMENT SYSTEM',
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
      //automaticallyImplyLeading: true,
      centerTitle: false,
      backgroundColor: Colors.white,
      leading: Image.asset('../assets/images/store-logo.png'),
      leadingWidth: 100,

      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.person, color: Colors.blue),
          tooltip: 'Profile',
          onPressed: () {
            //come up with this
          },
        ),
        Container(
          child:PopupMenuButton(
            child: Icon(Icons.notifications, color: Colors.blue,),
            //onSelected: (WhyFarther result) { setState(() { _selection = result; }); },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Column(
                  children: [
                    TextButton.icon(
                      icon: Icon(
                        Icons.notifications_active,
                        color: Colors.blue,
                      ),
                      label: Text(
                        'Item 01',
                        softWrap: true,
                      ),
                      onPressed: () {}, //pwdeng refresh button
                    ),
                    TextButton.icon(
                      icon: Icon(
                        Icons.notifications_active,
                        color: Colors.blue,
                      ),
                      label: Text(
                        'Item 02',
                        softWrap: true,
                      ),
                      onPressed: () {}, //pwdeng refresh button
                    ),
                    TextButton.icon(
                      icon: Icon(
                        Icons.notifications_active,
                        color: Colors.blue,
                      ),
                      label: Text(
                        'Item 03',
                        softWrap: true,
                      ),
                      onPressed: () {}, //pwdeng refresh button
                    ),
                    TextButton.icon(
                      icon: Icon(
                        Icons.notifications_active,
                        color: Colors.blue,
                      ),
                      label: Text(
                        'Item 04',
                        softWrap: true,
                      ),
                      onPressed: () {}, //pwdeng refresh button
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.red),
          tooltip: 'Logout',
          onPressed: () {
            Get.to(LoginPage());
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
