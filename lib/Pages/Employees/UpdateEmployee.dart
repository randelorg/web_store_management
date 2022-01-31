import 'package:flutter/material.dart';
import 'package:web_store_management/Backend/EmployeeOperation.dart';
import 'package:web_store_management/Notification/Snack_notification.dart';

class UpdateEmployee extends StatefulWidget {
  final int? pid;
  final String? eid, firstname, lastname, number, address;
  UpdateEmployee({
    required this.pid,
    required this.eid,
    this.firstname,
    this.lastname,
    this.number,
    this.address,
  });

  @override
  _UpdateEmployee createState() => _UpdateEmployee();
}

class _UpdateEmployee extends State<UpdateEmployee> {
  var employee = EmployeeOperation();
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final number = TextEditingController();
  final address = TextEditingController();

  String collector = 'Collector';
  String storeAttendant = 'Store Attendant';

  @override
  void initState() {
    print(widget.pid?.toInt());
    super.initState();
    firstname.text = widget.firstname.toString();
    lastname.text = widget.lastname.toString();
    number.text = widget.number.toString();
    address.text = widget.address.toString();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.all(15),
      title: Text(
        'Update Employee',
        softWrap: true,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Colors.blue,
          overflow: TextOverflow.fade,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actions: <Widget>[
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 7),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Firstname',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 6.0, right: 6.0, bottom: 6.0, top: 1.0),
              child: TextField(
                controller: firstname,
                enabled: false,
                decoration: InputDecoration(
                  hintText: 'Firstname',
                  filled: true,
                  fillColor: Colors.blueGrey[50],
                  labelStyle: TextStyle(fontSize: 12),
                  contentPadding: EdgeInsets.only(left: 15),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey.shade50),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey.shade50),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 7),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Lastname',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 6.0, right: 6.0, bottom: 6.0, top: 1.0),
              child: TextField(
                controller: lastname,
                enabled: false,
                decoration: InputDecoration(
                  hintText: 'Lastname',
                  filled: true,
                  fillColor: Colors.blueGrey[50],
                  labelStyle: TextStyle(fontSize: 12),
                  contentPadding: EdgeInsets.only(left: 15),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey.shade50),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey.shade50),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Container(
                width: 320,
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blueGrey.shade50,
                    style: BorderStyle.solid,
                    width: 0.80,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: collector,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.blue.shade700),
                    onChanged: (value) {
                      setState(() {
                        collector = value!;
                      });
                    },
                    items: <String>['Collector', 'Store Attendant']
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
            Padding(
              padding: EdgeInsets.only(left: 7),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Mobile number',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 6.0, right: 6.0, bottom: 6.0, top: 1.0),
              child: TextField(
                controller: number,
                decoration: InputDecoration(
                  hintText: 'Number',
                  filled: true,
                  fillColor: Colors.blueGrey[50],
                  labelStyle: TextStyle(fontSize: 12),
                  contentPadding: EdgeInsets.only(left: 15),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey.shade50),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey.shade50),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 7),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Address',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 6.0, right: 6.0, bottom: 6.0, top: 1.0),
              child: TextField(
                controller: address,
                decoration: InputDecoration(
                  hintText: 'Address',
                  filled: true,
                  fillColor: Colors.blueGrey[50],
                  labelStyle: TextStyle(fontSize: 12),
                  contentPadding: EdgeInsets.only(left: 15),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey.shade50),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey.shade50),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, top: 15, bottom: 15),
                        primary: Colors.white,
                        textStyle: TextStyle(fontSize: 20),
                      ),
                      child: const Text('UPDATE'),
                      onPressed: () {
                        employee
                            .updateEmployeeAccount(
                                widget.pid!.toInt(),
                                widget.eid.toString(),
                                collector.replaceAll(' ', '').toString(),
                                number.text,
                                address.text)
                            .then((value) {
                          if (value) {
                            Navigator.pop(context);
                            SnackNotification.notif(
                              'Success',
                              'Successfully updated employee account',
                              Colors.green.shade500,
                            );
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
