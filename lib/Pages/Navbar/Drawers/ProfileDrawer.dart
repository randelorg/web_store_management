import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:web_store_management/Backend/GlobalController.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Pages/Navbar/AddBranch.dart';

import '../ViewProfile.dart';
import '../AddAccount.dart';
import '../UpdateProfile.dart';

class ProfileDrawer extends StatefulWidget {
  @override
  _ProfileDrawer createState() => _ProfileDrawer();
}

class _ProfileDrawer extends State<ProfileDrawer> {
  var controller = GlobalController();
  bool _isAuthorized = false;
  bool _isEmployee = true;
  bool _timein = false;
  bool _timeout = false;

  @override
  void initState() {
    super.initState();
    controller.fetchAllEmployees();
    if (Mapping.userRole == "Administrator") {
      setState(() {
        _isAuthorized = true;
        _isEmployee = false;
      });
    }
  }

  void checkTimeState(bool state) {}

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      tooltip: "My Profile",
      offset: const Offset(0.0, 45.0),
      elevation: 2,
      child: Icon(Icons.person, color: HexColor("#155293")),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Container(
                    child: Text(
                      'Profile Management',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10, right: 10, left: 10),
                    child: TextButton.icon(
                      icon: Icon(
                        Icons.visibility,
                        color: HexColor("#155293"),
                      ),
                      label: Text(
                        'View Profile',
                        style: TextStyle(
                          fontFamily: 'Cairo_SemiBold',
                          color: HexColor("#155293"),
                        ),
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
                Visibility(
                  maintainSize: false,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: this._isAuthorized,
                  child: Column(
                    children: [
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            right: 10,
                            left: 10,
                          ),
                          child: TextButton.icon(
                            icon: Icon(
                              Icons.create_rounded,
                              color: HexColor("#155293"),
                            ),
                            label: Text(
                              'Update Profile',
                              style: TextStyle(
                                fontFamily: 'Cairo_SemiBold',
                                color: HexColor("#155293"),
                              ),
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
                          padding: EdgeInsets.only(
                              top: 10, bottom: 10, right: 10, left: 10),
                          child: TextButton.icon(
                            icon: Icon(
                              Icons.person_add,
                              color: HexColor("#155293"),
                            ),
                            label: Text(
                              'Add Admin',
                              style: TextStyle(
                                fontFamily: 'Cairo_SemiBold',
                                color: HexColor("#155293"),
                              ),
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
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Container(
                          child: Text(
                            'Branch Management',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            right: 10,
                            left: 10,
                          ),
                          child: TextButton.icon(
                            icon: Icon(
                              Icons.store,
                              color: HexColor("#155293"),
                            ),
                            label: Text(
                              'Add Branch',
                              style: TextStyle(
                                fontFamily: 'Cairo_SemiBold',
                                color: HexColor("#155293"),
                              ),
                              softWrap: true,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AddBranch();
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  maintainSize: false,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: this._isEmployee,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Container(
                          child: Text(
                            'DTR',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 5,
                            bottom: 10,
                            right: 10,
                            left: 10,
                          ),
                          child: TextButton.icon(
                            icon: Icon(
                              Icons.check_circle,
                              color: HexColor("#155293"),
                            ),
                            label: Text(
                              'Time in',
                              style: TextStyle(
                                fontFamily: 'Cairo_SemiBold',
                                color: HexColor("#155293"),
                              ),
                              softWrap: true,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 5,
                            bottom: 10,
                            right: 10,
                            left: 10,
                          ),
                          child: TextButton.icon(
                            icon: Icon(
                              Icons.cancel,
                              color: HexColor("#155293"),
                            ),
                            label: Text(
                              'Time out',
                              style: TextStyle(
                                fontFamily: 'Cairo_SemiBold',
                                color: HexColor("#155293"),
                              ),
                              softWrap: true,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
