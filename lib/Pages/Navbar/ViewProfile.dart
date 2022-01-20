import 'dart:typed_data';

import 'package:flutter/material.dart';
import '../../Backend/Session.dart';
import '../../Backend/Utility/Mapping.dart';

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
      if (Mapping.userRole == "StoreAttendant") {
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
      insetPadding: EdgeInsets.only(left: 20, right: 20, top: 180, bottom: 200),
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
              radius: 80,
              child: ClipOval(
                child: Image.memory(
                  Uint8List.fromList(picture),
                  height: 200,
                  width: 200,
                  fit: BoxFit.fitWidth,
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
                    name.toString(),
                    style: TextStyle(
                      fontFamily: 'Cairo_SemiBold',
                      fontSize: 15,
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
                        left: 10, top: 10, bottom: 15, right: 33),
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
                    Mapping.userRole.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Cairo_SemiBold',
                      fontSize: 15,
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
