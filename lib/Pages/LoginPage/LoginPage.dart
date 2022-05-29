import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Notification/BannerNotif.dart';
import 'package:web_store_management/Pages/LoginPage/ForgotPasswordScreens/ForgotPassword.dart';
import '../../Backend/LoginOperation.dart';
import '../../Backend/GlobalController.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  var login = Login();
  late Future branches;
  var controller = GlobalController();
  final username = TextEditingController();
  final password = TextEditingController();

  String _originBranch = 'Main';
  String _manager = 'Manager';
  final String storeAttendant = 'Store Attendant';
  String? loginRole;

  @override
  void initState() {
    branches = controller.fetchBranches();
    super.initState();
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  List<String> getLocations() {
    List<String> branches = [];
    branches.addAll(Mapping.branchList.map((e) => e.branchName));
    branches.add('Main');
    return branches;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MediaQuery.of(context).size.width >= 800 //Responsive
            ? Image.asset(
                'images/login-logo.jpg',
                width: 350,
              )
            : SizedBox(),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 40),
          child: Container(
            width: 300,
            child: _formLogin(context),
          ),
        )
      ],
    );
  }

  Widget _formLogin(BuildContext context) {
    return Column(
      children: [
        //fetch branches
        FutureBuilder(
          future: branches,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  semanticsLabel: 'Fetching branches',
                ),
              );
            }
            if (snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[50],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.blueGrey.shade50,
                      style: BorderStyle.solid,
                      width: 0.80,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: _originBranch,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: HexColor("#155293")),
                      onChanged: (role) {
                        setState(() {
                          _originBranch = role!;
                        });
                      },
                      items: getLocations()
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: EdgeInsets.only(left: 25),
                            child: Text(
                              value,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              );
            }
            return Center(
              child: Text(
                'Cant fetch branches',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontFamily: 'Cairo_SemiBold',
                  fontSize: 20,
                ),
              ),
            );
          },
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Container(
            width: 300,
            decoration: BoxDecoration(
              color: Colors.blueGrey[50],
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.blueGrey.shade50,
                style: BorderStyle.solid,
                width: 0.80,
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: _manager,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: HexColor("#155293")),
                onChanged: (role) {
                  setState(() {
                    _manager = role!;
                  });
                },
                items: <String>['Manager', 'Store Attendant']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        TextField(
          controller: username,
          decoration: InputDecoration(
            hintText: 'Username',
            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: TextStyle(fontSize: 12),
            contentPadding: EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade50),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade50),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          controller: password,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Password',
            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: TextStyle(fontSize: 12),
            contentPadding: EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade50),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade50),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 180),
          child: TextButton(
            child: Text(
              'Forgot password?',
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Cairo_SemiBold',
                color: HexColor("#155293"),
              ),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ForgotPassword();
                },
              );
            },
          ),
        ),
        SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ElevatedButton(
            child: Container(
              width: double.infinity,
              height: 50,
              child: Center(
                child: Text(
                  "Log In",
                  style: TextStyle(fontFamily: 'Cairo_Bold', fontSize: 18),
                ),
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: HexColor("#EA1C24"),
              onPrimary: Colors.white,
            ),
            onPressed: () {
              if (username.text.isEmpty || password.text.isEmpty) {
                BannerNotif.notif(
                  "Error",
                  "Please fill all the fields",
                  Colors.red.shade600,
                );
              } else {
                login
                    .mainLogin(
                  _originBranch,
                  _manager.toString(),
                  username.text,
                  password.text,
                )
                    .then((value) {
                  setState(() {
                    if (!value) {
                      BannerNotif.notif(
                        "Error",
                        "Wrong username or password",
                        Colors.red.shade600,
                      );
                    } else {
                      Navigator.pushReplacementNamed(context, '/home');
                    }
                  });
                });
              }
            },
          ),
        ),
      ],
    );
  }
}
