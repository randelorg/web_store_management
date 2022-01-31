import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Backend/BorrowerOperation.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Pages/Repairs/AddRepair.dart';

class ManualBorrowerSearch extends StatefulWidget {
  @override
  _ManualBorrowerSearch createState() => _ManualBorrowerSearch();
}

class _ManualBorrowerSearch extends State<ManualBorrowerSearch> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController borrowername = TextEditingController();
  final TextEditingController confirmedname = TextEditingController();
  var controller = BorrowerOperation();
  List<String> borrowerDetail = [];

  @override
  void initState() {
    super.initState();
    confirmedname.text = 'No data, please enter name';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Search Borrower',
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
            Form(
              key: _formKey,
              child: Center(
                child: Column(
                  children: <Widget>[
                    // Input Borrowers Name
                    Container(
                      padding: EdgeInsets.only(left: 35, right: 35, top: 50),
                      child: TextFormField(
                        controller: borrowername,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: 'Borrowers Name',
                          prefixIcon:
                              Icon(Icons.person_rounded, color: Colors.red),
                          suffixIcon: IconButton(
                            iconSize: 25,
                            icon: Icon(Icons.search, color: Colors.grey),
                            onPressed: () {
                              String fullname = borrowername.text.trim();
                              List<String> name = fullname.split(" ");
                              borrowerDetail = _findName(name[0], name[1]);
                              if (borrowerDetail != []) {
                                setState(() {
                                  confirmedname.text =
                                      borrowerDetail[1].toString();
                                  getName();
                                });
                              }
                            },
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.red, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "* Required Borrowers Name";
                          }
                        },
                      ),
                    ),

                    getName(),

                    // Pay Button
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      height: 60,
                      width: 140,
                      decoration: BoxDecoration(
                          color: HexColor("#155293"),
                          borderRadius: BorderRadius.circular(80)),
                      child: TextButton(
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                            fontFamily: 'Cairo_Bold',
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AddRepair(
                                  id: borrowerDetail[0],
                                  name: borrowerDetail[1],
                                  address: borrowerDetail[2],
                                  number: borrowerDetail[3],
                                );
                              },
                            );
                          }
                        },
                      ),
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

  Widget getName() {
    return Column(
      children: [
        // Display Borrowers Name
        Container(
          height: 45,
          width: 350,
          child: Card(
            elevation: 3,
            shadowColor: Colors.black,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 30),
                  child: Text(
                    'Check Name',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Text(
                  confirmedname.text,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Cairo_SemiBold',
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<String> _findName(String fname, String lname) {
    List<String> brw = [];
    Mapping.borrowerList
        .where((element) =>
            element.getFirstname?.toLowerCase() == fname.toLowerCase() &&
            element.getLastname?.toLowerCase() == lname.toLowerCase())
        .forEach((element) {
      brw.add(element.getBorrowerId.toString());
      brw.add(element.toString());
      brw.add(element.getHomeAddress);
      brw.add(element.getMobileNumber);
    });

    return brw;
  }
}
