import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Backend/BranchOperation.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Notification/BannerNotif.dart';

class AddBranch extends StatefulWidget {
  @override
  _AddBranch createState() => _AddBranch();
}

class _AddBranch extends State<AddBranch> {
  var branch = BranchOperation();
  final TextEditingController branchName = new TextEditingController();
  final TextEditingController branchAddress = new TextEditingController();
  String? employeeAssigned = '';
  List<String> employees = [];
  //for dropdown list

  @override
  void initState() {
    super.initState();
    Mapping.employeeList.forEach((element) {
      employees.add(element.toString());
    });
    employeeAssigned = employees[0];
  }

  String getEmpId() {
    String id = '';
    Mapping.employeeList
        .where((element) =>
            element.toString().toLowerCase() == employeeAssigned!.toLowerCase())
        .forEach((element) {
      id = element.getEmployeeID;
    });
    return id;
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
            Text(
              'Add Branch',
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: HexColor("#155293"),
                fontFamily: 'Cairo_Bold',
                fontSize: 30,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 20, left: 2),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Branch Name',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: TextField(
                controller: branchName,
                decoration: InputDecoration(
                  hintText: 'Branch Name',
                  filled: true,
                  fillColor: Colors.blueGrey[50],
                  labelStyle: TextStyle(fontSize: 10),
                  contentPadding: EdgeInsets.only(left: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey.shade50),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey.shade50),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 2),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Branch Address',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: TextField(
                controller: branchAddress,
                decoration: InputDecoration(
                  hintText: 'Branch Address',
                  filled: true,
                  fillColor: Colors.blueGrey[50],
                  labelStyle: TextStyle(fontSize: 10),
                  contentPadding: EdgeInsets.only(left: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey.shade50),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey.shade50),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 2),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select Employee Assigned',
                  style: TextStyle(fontSize: 10),
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
                    value: employeeAssigned,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: HexColor("#155293")),
                    onChanged: (value) {
                      setState(() {
                        employeeAssigned = value!;
                      });
                    },
                    items:
                        employees.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: HexColor("#155293"),
                            ),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                            primary: Colors.white,
                            textStyle: TextStyle(
                              fontFamily: 'Cairo_SemiBold',
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          child: const Text('CONFIRM'),
                          onPressed: () {
                            if (branchName.text.isEmpty || branchAddress.text.isEmpty) {                     
                              BannerNotif.notif(
                                   "Error",
                                   "Please fill all the fields",Colors.red.shade600);
                            } else {
                              branch
                                  .addBranch(branchName.text,
                                      branchAddress.text, getEmpId())
                                  .then(
                                    (value) => BannerNotif.notif(
                                      'Success',
                                      'New branch added successfully',
                                      Colors.green.shade600,
                                    ),
                                  );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
