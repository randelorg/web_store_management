import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';

import '../ViewProfile.dart';
import '../AddAccount.dart';
import '../UpdateProfile.dart';

class ProfileDrawer extends StatefulWidget {
  @override
  _ProfileDrawer createState() => _ProfileDrawer();
}

class _ProfileDrawer extends State<ProfileDrawer> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      tooltip: "My Profile",
      elevation: 5,
      child: Icon(Icons.person, color: HexColor("#155293")),
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
                    icon: Icon(Icons.visibility, color: HexColor("#155293")),
                    label: Text(
                      'View Profile',
                      style: TextStyle(
                          fontFamily: 'Cairo_SemiBold',
                          color: HexColor("#155293")),
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
                    icon:
                        Icon(Icons.create_rounded, color: HexColor("#155293")),
                    label: Text(
                      'Update Profile',
                      style: TextStyle(
                          fontFamily: 'Cairo_SemiBold',
                          color: HexColor("#155293")),
                      softWrap: true,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return UpdateProfile();
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
                    icon: Icon(Icons.person_add, color: HexColor("#155293")),
                    label: Text(
                      'Add new admin',
                      style: TextStyle(
                          fontFamily: 'Cairo_SemiBold',
                          color: HexColor("#155293")),
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
