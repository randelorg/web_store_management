import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Pages/Employees/UpdateEmployee.dart';
import '../../Helpers/CreateQRHelper.dart';

class ViewEmpProfile extends StatefulWidget {
  //person id = pid, employee id = eid
  final int? pid;
  final String? eid, name, number, role;
  ViewEmpProfile(
      {this.pid, required this.eid, this.role, this.name, this.number});

  @override
  _ViewEmpProfile createState() => _ViewEmpProfile();
}

class _ViewEmpProfile extends State<ViewEmpProfile> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.only(bottom: 5, left: 5, right: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actions: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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

            Text(
             'Employee Profile',
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(             
                color: HexColor("#155293"),
                fontFamily: 'Cairo_Bold',
                fontSize: 30,
              ),
            ),

            SizedBox(
              width: 200, height: 200,
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
                Navigator.pop(context);
                String fullname = widget.name.toString().trim();
                List name = fullname.split(" ");
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return UpdateEmployee(
                      pid: _personId(widget.eid.toString()),
                      eid: widget.eid.toString(),
                      firstname: name[0],
                      lastname: name[1],
                      number: widget.number.toString(),
                      address: _findAddress(widget.eid.toString()),
                    );
                  },
                );
              },
            ),
            Card(
              margin: EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              shadowColor: Colors.black,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 34),
                    child: Text(
                      'Employee ID',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontFamily: 'Cairo_SemiBold',
                        fontSize: 12),
                    ),
                  ),
                  Text(
                    widget.eid.toString(),
                    style:TextStyle(fontSize: 14, fontFamily: 'Cairo_SemiBold'),
                  ),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              shadowColor: Colors.black,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 74),
                    child: Text(
                      'Role',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontFamily: 'Cairo_SemiBold',
                        fontSize: 12),
                    ),
                  ), 
                  Text(
                    widget.role.toString(),
                    softWrap: true,
                    style:TextStyle(fontSize: 14, fontFamily: 'Cairo_SemiBold'),
                  ),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              shadowColor: Colors.black,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 65),
                    child: Text(
                      'Name',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontFamily: 'Cairo_SemiBold',
                        fontSize: 12),
                    ),
                  ),        
                  Text(                
                    widget.name.toString(),
                    style:TextStyle(fontSize: 14, fontFamily: 'Cairo_SemiBold'),
                  ),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 3,
              shadowColor: Colors.black,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 18),
                    child: Text(
                      'Mobile Number',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontFamily: 'Cairo_SemiBold',
                        fontSize: 12),
                    ),
                  ),    
                  Text(      
                    widget.number.toString(),
                    softWrap: true,
                    style:TextStyle(fontSize: 14, fontFamily: 'Cairo_SemiBold'),
                  ),                
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  int _personId(String eid) {
    int pid = 0;
    try {
      Mapping.employeeList
          .where((element) => element.getEmployeeID == eid)
          .forEach((element) {
        pid = element.getPersonId;
      });
      return pid;
    } catch (e) {
      return 0;
    }
  }

  String _findAddress(String eid) {
    String address = '';
    Mapping.employeeList
        .where((element) => element.getEmployeeID == eid)
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
