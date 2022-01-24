import 'package:flutter/material.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Pages/Employees/UpdateEmployee.dart';
import '../../Helpers/CreateQRHelper.dart';

class ViewEmpProfile extends StatefulWidget {
  final String? id, name, number, role;
  ViewEmpProfile({this.id, this.role, this.name, this.number});

  @override
  _ViewEmpProfile createState() => _ViewEmpProfile();
}

class _ViewEmpProfile extends State<ViewEmpProfile> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.all(20),
      title: Text(
        'Employee Profile',
        softWrap: true,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actions: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: CreateQrHelper.createQr(qrContent()),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: TextStyle(
                  fontSize: 10,
                  decoration: TextDecoration.underline,
                ),
              ),
              child: Text(
                'Update Profile',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async {
                String fullname = widget.name.toString().trim();
                List name = fullname.split(" ");
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return UpdateEmployee(
                      eid: widget.id.toString(),
                      firstname: name[0],
                      lastname: name[1],
                      number: widget.number.toString(),
                      address: _findAddress(widget.id.toString()),
                    );
                  },
                );
              },
            ),
            Card(
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              shadowColor: Colors.black,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 50, top: 10, bottom: 5),
                    child: Text(
                      'Employee ID',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 5),
                    child: Text(
                      widget.id.toString(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              shadowColor: Colors.black,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 50, top: 10, bottom: 5),
                    child: Text(
                      'Name',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 5),
                    child: Text(
                      widget.name.toString(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              shadowColor: Colors.black,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20, top: 10, bottom: 5),
                    child: Text(
                      'Mobile Number',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 5),
                    child: Text(
                      widget.number.toString(),
                      softWrap: true,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              shadowColor: Colors.black,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20, top: 10, bottom: 5),
                    child: Text(
                      'Role',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 5),
                    child: Text(
                      widget.role.toString(),
                      softWrap: true,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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

  String _findAddress(String eid) {
    String address = '';
    Mapping.employeeList
        .where((element) => element.getEmployeeID.toString() == eid)
        .forEach((element) {
      address = element.getHomeAddress;
    });
    return address;
  }

  String qrContent() {
    String content = "Name " +
        widget.name.toString() +
        "\n" +
        "Mobile Number " +
        widget.number.toString() +
        "\n" +
        "Role " +
        widget.role.toString();
    return content;
  }
}
