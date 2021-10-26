import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';

class ViewProfile extends StatelessWidget {
  const ViewProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actions: <Widget>[
        Column(
          children: [
            MediaQuery.of(context).size.width >= 800 //Responsive
                ? Image.asset(
                    '../../../assets/images/user.png',
                    width: 200,
                  )
                : SizedBox(),
            Card(
              margin: EdgeInsets.all(5),
              elevation: 5,
              shadowColor: Colors.black,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 10, top: 15, bottom: 15, right: 60),
                    child: Text(
                      'Name',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                  Text(
                    'Michael Jacinto',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.all(5),
              elevation: 5,
              shadowColor: Colors.black,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 10, top: 15, bottom: 15, right: 50),
                    child: Text(
                      'User Level',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                  Text(
                    'Admin',
                    style: TextStyle(
                      fontSize: 20,
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
}
