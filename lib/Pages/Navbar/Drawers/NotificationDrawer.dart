import 'package:hexcolor/hexcolor.dart'; 
import 'package:flutter/material.dart'; //library for going to next pages

class NotificationDrawer extends StatefulWidget {
  @override
  _NotificationDrawer createState() => _NotificationDrawer();
}

class _NotificationDrawer extends State<NotificationDrawer> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      tooltip: "Notifications",
      elevation: 5,
      child: Icon(
        Icons.notifications,
        color: HexColor("#155293")
      ),
      itemBuilder: (context) => [
        PopupMenuItem( 
          child: Column(
            children: _notificationsList(),
          ),
        ),
      ],
    );
  }
}

List<Widget> _notificationsList() {
  List<Widget> _notifications;

  return _notifications = List.generate(
    20,
    (index) {
      return new Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10, right: 20),
          child: TextButton.icon(
            icon: Icon(
              Icons.notifications_active,
              color: HexColor("#155293")
            ),
            label: Text(      
              'Longgg notification',
              style: TextStyle(fontFamily: 'Cairo_SemiBold', color: HexColor("#155293")),
              softWrap: true,
            ),
            onPressed: () {}, //pwdeng refresh button
          ),
        ),
      );
    },
  );
}
