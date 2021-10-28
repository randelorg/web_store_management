import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';

import '../ViewProfile.dart';
import '../AddAccount.dart';
import '../EditProfile.dart';

class ProfileDrawer extends StatefulWidget {
  @override
  _ProfileDrawer createState() => _ProfileDrawer();
}

class _ProfileDrawer extends State<ProfileDrawer> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      elevation: 5,
      child: Icon(
        Icons.person,
        color: Colors.blue,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
                  child: TextButton.icon(
                    icon: Icon(
                      Icons.visibility,
                      color: Colors.blue,
                    ),
                    label: Text(
                      'View Profile',
                      softWrap: true,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ViewProfile();
                        },
                      );
                    },
                  ),
                ),
              ),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
                  child: TextButton.icon(
                    icon: Icon(
                      Icons.filter_alt,
                      color: Colors.blue,
                    ),
                    label: Text(
                      'Update Profile',
                      softWrap: true,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return EditProfile();
                        },
                      );
                    },
                  ),
                ),
              ),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
                  child: TextButton.icon(
                    icon: Icon(
                      Icons.person_add,
                      color: Colors.blue,
                    ),
                    label: Text(
                      'Add new account',
                      softWrap: true,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AddAccount();
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
