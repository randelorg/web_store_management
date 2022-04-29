import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Backend/BorrowerOperation.dart';
import 'package:web_store_management/Backend/GlobalController.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Notification/BannerNotif.dart';
import 'package:web_store_management/Pages/RequestedProducts/AddRequest.dart';

class ReqManualBorrowerSearch extends StatefulWidget {
  @override
  _ReqManualBorrowerSearch createState() => _ReqManualBorrowerSearch();
}

class _ReqManualBorrowerSearch extends State<ReqManualBorrowerSearch> {
  var borrower = BorrowerOperation();
  var controller = GlobalController();

  final TextEditingController borrowername = TextEditingController();
  final TextEditingController confirmedname = TextEditingController();

  List<String> borrowerDetail = [];

  @override
  void initState() {
    super.initState();
    controller.fetchBorrowers();
    confirmedname.text = 'No data, Please Enter Name.';
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
                  }),
            ),
            Text(
              'Search Borrower',
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: HexColor("#155293"),
                fontFamily: 'Cairo_Bold',
                fontSize: 30,
              ),
            ),
            Form(
              child: Center(
                child: Column(
                  children: <Widget>[
                    // Input Borrowers Name
                    Container(
                      padding: EdgeInsets.only(left: 5, right: 5, top: 10),
                      child: TextFormField(
                        controller: borrowername,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: 'Borrowers Name',
                          filled: true,
                          fillColor: Colors.blueGrey[50],
                          labelStyle: TextStyle(fontSize: 12),
                          contentPadding: EdgeInsets.only(left: 15),
                          suffixIcon: IconButton(
                            iconSize: 25,
                            icon: Icon(Icons.search, color: Colors.grey),
                            onPressed: () {
                              if (borrowername.text.isEmpty) {
                                return;
                              }

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
                            borderSide:
                                BorderSide(color: Colors.blueGrey.shade50),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueGrey.shade50),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),

                    getName(),

                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      height: 40,
                      width: 110,
                      decoration: BoxDecoration(
                          color: HexColor("#155293"),
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                          child: Text(
                            'CONFIRM',
                            style: TextStyle(
                              fontFamily: 'Cairo_SemiBold',
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            if (borrowerDetail.isEmpty) {
                              BannerNotif.notif(
                                  "Error",
                                  "Please fill the borrower name field",
                                  Colors.red.shade600);
                            } else {
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AddRequest(
                                    id: borrowerDetail[0],
                                    name: borrowerDetail[1],
                                    address: borrowerDetail[2],
                                    number: borrowerDetail[3],
                                  );
                                },
                              );
                            }
                          }),
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
