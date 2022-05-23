import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Backend/BorrowerOperation.dart';
import 'package:web_store_management/Notification/BannerNotif.dart';

class UpdateBrwPage extends StatefulWidget {
  final String? bid, firstname, lastname, number, address;
  UpdateBrwPage({
    required this.bid,
    this.firstname,
    this.lastname,
    this.number,
    this.address,
  });

  @override
  _UpdateBrwPage createState() => _UpdateBrwPage();
}

class _UpdateBrwPage extends State<UpdateBrwPage> {
  var borrower = BorrowerOperation();
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final number = TextEditingController();
  final address = TextEditingController();

  @override
  void initState() {
    super.initState();
    firstname.text = widget.firstname.toString();
    lastname.text = widget.lastname.toString();
    number.text = widget.number.toString();
    address.text = widget.address.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(
              'Update Borrower',
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: HexColor("#155293"),
                fontFamily: 'Cairo_Bold',
                fontSize: 25,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 2),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Firstname',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: TextField(
                controller: firstname,
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
              padding: EdgeInsets.only(left: 2),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Lastname',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: TextField(
                controller: lastname,
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
              padding: EdgeInsets.only(left: 2),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Mobile Number',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: TextField(
                maxLength: 12,
                controller: number,
                decoration: InputDecoration(
                  counterText: '',
                  hintText: 'Mobile Number',
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
              padding: EdgeInsets.only(left: 2),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Home Address',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: TextField(
                controller: address,
                decoration: InputDecoration(
                  hintText: 'Home Address',
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
              padding: EdgeInsets.only(top: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
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
                        padding: const EdgeInsets.only(
                            left: 36, right: 36, top: 18, bottom: 18),
                        primary: Colors.white,
                        textStyle: TextStyle(
                            fontFamily: 'Cairo_SemiBold',
                            fontSize: 14,
                            color: Colors.white),
                      ),
                      child: const Text('UPDATE'),
                      onPressed: () {
                        if (firstname.text.isEmpty ||
                            lastname.text.isEmpty ||
                            number.text.isEmpty ||
                            address.text.isEmpty) {
                          BannerNotif.notif(
                              "Error",
                              "Please fill all the fields",
                              Colors.red.shade600);
                        } else {
                          borrower
                              .updateBorrower(
                            int.parse(widget.bid.toString()),
                            firstname.text,
                            lastname.text,
                            number.text,
                            address.text,
                          )
                              .then((value) {
                            if (value) {
                              Navigator.pop(context);
                              BannerNotif.notif(
                                'Success',
                                'Borrower ' +
                                    widget.firstname.toString() +
                                    ' ' +
                                    widget.lastname.toString() +
                                    ' has been updated',
                                Colors.green.shade600,
                              );
                            }
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
