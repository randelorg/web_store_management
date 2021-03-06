import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:web_store_management/Backend/GlobalController.dart';
import 'package:web_store_management/Backend/LoginOperation.dart';
import 'package:web_store_management/Backend/Session.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Pages/Navbar/AddAccount.dart';
import 'package:web_store_management/Pages/Navbar/NavDrawerAdmin.dart';
import 'package:web_store_management/Pages/Navbar/NavDrawerAttendant.dart';
import 'package:web_store_management/Pages/Navbar/UpdateProfile.dart';
import 'package:web_store_management/Pages/Navbar/ViewProfile.dart';

class Home extends StatefulWidget with PreferredSizeWidget {
  @override
  _Home createState() => _Home();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _Home extends State<Home> {
  var controller = GlobalController();
  var login = Login();
  bool _isAuthorized = false;
  String branchName = '';
  late Future<int> route;

  @override
  void initState() {
    route = _identifyRoute();
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
    Session.getBranch().then((branch) {
      setState(() {
        branchName = branch;
      });
    });
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
            //Menu Button
            PopupMenuButton(
              icon: Icon(
                Icons.menu,
                color: HexColor("#155293"),
              ),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.store),
                      title: Text('$branchName'),
                    ),
                    value: 0,
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.create_rounded),
                      title: Text('View Profile'),
                    ),
                    value: 1,
                  ),
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
            if (snapshot.hasData) {
              if (snapshot.data == 0) {
                return NavDrawerAdmin();
              } else if (snapshot.data == 1) {
                return NavDrawerAttendant();
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
    final String manager = "Manager", attendant = "Store Attendant";
    int result = -1;
    await Session.getrole().then((role) {
      if (role == manager) {
        result = 0;
      } else if (role == attendant) {
        result = 1;
      }
    });
    return result;
  }

  void _destinationMenu(dynamic value) {
    switch (value) {
      case 1:
        routeName(ViewProfile());
        break;
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

  void _destinationNotif(dynamic value) {
    if (value == 1) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return UpdateProfile();
        },
      );
    } else if (value == 2) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ViewProfile();
        },
      );
    }
  }
}
