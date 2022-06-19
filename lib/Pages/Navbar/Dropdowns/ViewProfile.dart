import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:web_store_management/Backend/Session.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';

class ViewProfile extends StatefulWidget {
  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  List<int> picture = [];
  String? name;

  @override
  void initState() {
    super.initState();
    try {
      if (Mapping.userRole == "Store Attendant") {
        name = Mapping.employeeLogin[0].toString();
        picture = Mapping.employeeLogin[0].getUserImage.cast<int>();
      } else {
        //if user is admin
        name = Mapping.adminLogin[0].toString();
        picture = Mapping.adminLogin[0].getUserImage.cast<int>();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.only(bottom: 5, left: 5, right: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actions: <Widget>[
        Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(
                  Icons.cancel,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            CircleAvatar(
              radius: 75,
              child: ClipOval(
                child: Image.memory(
                  Uint8List.fromList(picture),
                  fit: BoxFit.fill,
                  height: 250,
                  width: 250,
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.only(left: 5, top: 20, bottom: 5, right: 5),
              elevation: 5,
              shadowColor: Colors.black,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 10, top: 10, bottom: 10, right: 50),
                    child: Text(
                      'Name',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontFamily: 'Cairo_SemiBold',
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Text(
                    name.toString().toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Cairo_SemiBold',
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 5),
              elevation: 5,
              shadowColor: Colors.black,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 10, top: 10, bottom: 10, right: 30),
                    child: Text(
                      'User Level',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontFamily: 'Cairo_SemiBold',
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Text(
                    Mapping.userRole,
                    style: TextStyle(
                      fontFamily: 'Cairo_SemiBold',
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<String> getRole() async {
    String? role;
    await Session.getrole().then((value) => role);
    return role.toString();
  }
}
