import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_store_management/Backend/EmployeeOperation.dart';
import 'package:web_store_management/Backend/GlobalController.dart';
import 'package:web_store_management/Backend/Session.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Notification/BannerNotif.dart';
import 'package:web_store_management/Pages/Navbar/UpdateProfile.dart';
import 'package:web_store_management/Pages/Navbar/ViewProfile.dart';

class ProfileDrawer extends StatefulWidget {
  @override
  _ProfileDrawer createState() => _ProfileDrawer();
}

class _ProfileDrawer extends State<ProfileDrawer> {
  var controller = GlobalController();
  var emp = EmployeeOperation();

  bool _isAuthorized = false;
  bool _isEmployee = true;

  String branchName = '';

  String _getTodayDate() {
    var _formatter = new DateFormat('yyyy-MM-dd hh:mm:ss a');
    var _now = new DateTime.now();
    String formattedDate = _formatter.format(_now);
    return formattedDate;
  }

  @override
  void initState() {
    super.initState();
    controller.fetchAllEmployees();
    if (Mapping.userRole == "Manager") {
      setState(() {
        _isAuthorized = true;
        _isEmployee = false;
      });
    }
    Session.getBranch().then((branch) {
      setState(() {
        branchName = branch;
      });
    });
  }

  void timeIn(String id, String date) {
    emp.timeIn(id, date).then(
          (value) => BannerNotif.notif(
            'Success',
            'Time-in: $date',
            Colors.green.shade600,
          ),
        );
  }

  void timeOut(String id, String date) {
    emp.timeOut(id, date).then(
          (value) => BannerNotif.notif(
            'Success',
            'Time-out: $date',
            Colors.red.shade600,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: Icon(Icons.person, color: HexColor("#155293")),
      itemBuilder: (context) => <PopupMenuEntry>[
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.store),
            title: Text('$branchName'),
          ),
          value: 1,
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.person),
            title: TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ViewProfile();
                  },
                );
              },
              child: Text('Update Profile'),
            ),
          ),
          value: 2,
        ),
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.create_rounded),
            title: TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return UpdateProfile();
                  },
                );
              },
              child: Text('View Profile'),
            ),
          ),
          value: 3,
        ),
        const PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.person_add),
            title: Text('Add Manager'),
          ),
          value: 4,
        ),
      ],
    );
  }
}
