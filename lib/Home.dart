import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:web_store_management/Backend/GlobalController.dart';
import 'package:web_store_management/Backend/LoginOperation.dart';
import 'package:web_store_management/Backend/Session.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Pages/Navbar/Dropdowns/AddAccount.dart';
import 'package:web_store_management/Pages/Navbar/Dropdowns/UpdateProfile.dart';
import 'package:web_store_management/Pages/Navbar/Dropdowns/ViewProfile.dart';
import 'package:web_store_management/Pages/Navbar/NavDrawerAdmin.dart';
import 'package:web_store_management/Pages/Navbar/NavDrawerAdminBranch.dart';
import 'package:web_store_management/Pages/Navbar/NavDrawerAttendant.dart';
import 'package:web_store_management/Pages/Navbar/NavrDrawerAttendantBranch.dart';

class Home extends StatefulWidget with PreferredSizeWidget {
  @override
  _Home createState() => _Home();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  final String manager = "Manager", attendant = "Store Attendant";
  final mainBranch = 'Dellrains Main';
}

class _Home extends State<Home> {
  var controller = GlobalController();
  var login = Login();
  bool _isAuthorized = false;
  String branchName = '';
  late Future<int> route;

  Future<void> getBranch() async {
    await Session.getBranch().then((branch) {
      setState(() {
        branchName = branch;
        route = _identifyRoute();
      });
    });
  }

  @override
  void initState() {
    getBranch();
    route = Future.value(-1);
    Session.getid().then((id) {
      setState(() {
        if (id.isEmpty) {
          Navigator.pushReplacementNamed(context, '/logout');
        }
      });
    });
    controller.fetchAllEmployees();
    if (Mapping.userRole == "Manager") {
      setState(() {
        _isAuthorized = true;
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 45,
          title: Text(
            'Dellrains Store Management System',
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
          actions: [
            //view profile
            IconButton(
              icon: Icon(
                Icons.person,
                color: HexColor("#155293"),
              ),
              onPressed: () {
                routeName(ViewProfile());
              },
            ),
            //Menu Button
            Visibility(
              visible: _isAuthorized,
              child: PopupMenuButton(
                icon: Icon(
                  Icons.menu,
                  color: HexColor("#155293"),
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      enabled: _isAuthorized,
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Update Profile'),
                      ),
                      value: 2,
                    ),
                    PopupMenuItem(
                      enabled: _isAuthorized,
                      child: ListTile(
                        leading: Icon(Icons.person_add),
                        title: Text('Add Manager'),
                      ),
                      value: 3,
                    ),
                  ];
                },
                onSelected: (value) {
                  _destinationMenu(value);
                },
              ),
            ),

            //logout button
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
        ),
        body: FutureBuilder(
          future: route,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            // 2 = Main branch and admin role
            // 0 = Other branch and admin role
            // 3 = Main branch and attendant role
            // 1 = Other branch and attendant role
            if (snapshot.hasData) {
              if (snapshot.data == 2) {
                return NavDrawerAdmin();
              } else if (snapshot.data == 0) {
                return NavDrawerAdminBranch();
              } else if (snapshot.data == 3) {
                return NavDrawerAttendant();
              } else if (snapshot.data == 1) {
                return NavDrawerAttendantBranch();
              } else {
                return Center(
                  child: Text("You are not authorized to access this page"),
                );
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  Future<int> _identifyRoute() async {
    int result = -1;

    // 2 = Main branch and admin role
    // 0 = Other branch and admin role
    // 3 = Main branch and attendant role
    // 1 = Other branch and attendant role
    await Session.getrole().then((role) {
      if (role == widget.manager) {
        if (branchName == widget.mainBranch) {
          result = 2;
        } else {
          result = 0;
        }
      } else if (role == widget.attendant) {
        if (branchName == widget.mainBranch) {
          result = 3;
        } else {
          result = 1;
        }
      }
    });

    print("result route $result");
    return result;
  }

  void _destinationMenu(dynamic value) {
    switch (value) {
      case 2:
        routeName(UpdateProfile());
        break;
      case 3:
        routeName(AddAccount());
        break;
      default:
    }
  }

  void routeName(Widget name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return name;
      },
    );
  }
}
