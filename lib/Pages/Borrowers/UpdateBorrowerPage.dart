import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Backend/BorrowerOperation.dart';
import 'package:web_store_management/Notification/Snack_notification.dart';

class UpdateBorrowerPage extends StatefulWidget {
  final String? bid, firstname, lastname, number, address;
  UpdateBorrowerPage({
    required this.bid,
    this.firstname,
    this.lastname,
    this.number,
    this.address,
  });

  @override
  _UpdateBorrowerPage createState() => _UpdateBorrowerPage();
}

class _UpdateBorrowerPage extends State<UpdateBorrowerPage> {
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
              'Update Borrower',
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: HexColor("#155293"),
                fontFamily: 'Cairo_Bold',
                fontSize: 30,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 25, bottom: 5),
              child: Container(
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text('Update Borrower',
                      style: TextStyle(
                        fontFamily: 'Cairo_SemiBold',
                        fontSize: 16,
                        color: HexColor("#155293"),
                      )),
                ),
              ),
            ),
            Divider(
              thickness: 3,
            ),
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
              padding: const EdgeInsets.only(left: 6.0, right: 6.0, bottom: 6.0, top: 1.0),
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
              padding: const EdgeInsets.only(left: 6.0, right: 6.0, bottom: 6.0, top: 1.0),
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
              padding: const EdgeInsets.only(left: 6.0, right: 6.0, bottom: 6.0, top: 1.0),
              child: TextField(
                maxLength: 12,
                controller: number,
                decoration: InputDecoration(
                  counterText: '',
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
              padding: const EdgeInsets.only(left: 6.0, right: 6.0, bottom: 6.0, top: 1.0),
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
                        decoration: BoxDecoration(
                          color: HexColor("#155293"),
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(
                            top: 18, bottom: 18, left: 36, right: 36),
                        primary: Colors.white,
                        textStyle: TextStyle(
                            fontFamily: 'Cairo_SemiBold',
                            fontSize: 14,
                            color: Colors.white),
                      ),
                      child: const Text('UPDATE'),
                      onPressed: () {
                        if (firstname.text.isEmpty || lastname.text.isEmpty ||
                            number.text.isEmpty || address.text.isEmpty) {
                              SnackNotification.notif(
                               "Error",
                               "Please fill all the fields",Colors.red.shade600);
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
                              SnackNotification.notif(
                                'Success',
                                'Borrower ' +
                                    widget.firstname.toString() +
                                    ' ' +
                                    widget.lastname.toString() +
                                    ' has been updated',
                                Colors.green.shade500,
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
        )
      ],
    );
  }
}
