import 'package:flutter/material.dart';
import '../../Backend/Session.dart';

class ViewProfile extends StatelessWidget {
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
            MediaQuery.of(context).size.width >= 800 //Responsive
                ? Image.asset(
                    '../../../assets/images/user.png',
                    width: 200,
                  )
                : SizedBox(),
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
                    'Michael Jacinto',
                    style:
                        TextStyle(fontFamily: 'Cairo_SemiBold', fontSize: 15),
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
                          fontSize: 12),
                    ),
                  ),
                  Text(
                    'Admin',
                    style:
                        TextStyle(fontFamily: 'Cairo_SemiBold', fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  String? getRole() {
    final prefs = Session();
    String? role;
    prefs.getrole().then((value) => role);
    return role;
  }
}
