import 'package:flutter/material.dart';

class TopBar extends StatelessWidget with PreferredSizeWidget
{
    @override 
    Widget build(BuildContext context){
    return AppBar(
      title: const Text(
            'DASHBOARD',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Image.asset('../assets/images/store-logo.png'),
        leadingWidth: 100,

        actions: 
        <Widget>[
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.blue
            ),
            tooltip: 'Notifactions',
            onPressed: (){
              //come up with this
            },
          ),
          IconButton(
            icon: const Icon(
                Icons.person,
                color: Colors.blue
              ),
            tooltip: 'Profile',
            onPressed: (){
              //come up with this
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.red
            ),
            tooltip: 'Logout',
            onPressed: (){
              //come up with this
            },
          )
        ],
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}