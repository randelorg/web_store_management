import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class ViewBorrowerProfile extends StatefulWidget {
  @override
  _ViewBorrowerProfile createState() => _ViewBorrowerProfile();
}

class _ViewBorrowerProfile extends State<ViewBorrowerProfile> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Borrower Profile',
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
            Icon(
              Icons.qr_code_2_sharp,
              size: 150,
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
              onPressed: () {},
            ),
            Card(
                margin: EdgeInsets.all(10),
                elevation: 5,
                shadowColor: Colors.black,
                child: Row(
                  children: [
                    Padding(
                        padding:
                            EdgeInsets.only(right: 50, top: 10, bottom: 10),
                        child: Text(
                          'Firstname',
                          style: TextStyle(color: Colors.grey),
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text('John Vincent',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))),
                  ],
                )),
            Card(
                margin: EdgeInsets.all(10),
                elevation: 5,
                shadowColor: Colors.black,
                child: Row(
                  children: [
                    Padding(
                        padding:
                            EdgeInsets.only(right: 50, top: 10, bottom: 10),
                        child: Text(
                          'Lastname',
                          style: TextStyle(color: Colors.grey),
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text('Aborde',
                            softWrap: true,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))),
                  ],
                )),
            Card(
                margin: EdgeInsets.all(10),
                elevation: 5,
                shadowColor: Colors.black,
                child: Row(
                  children: [
                    Padding(
                        padding:
                            EdgeInsets.only(right: 20, top: 10, bottom: 10),
                        child: Text(
                          'Mobile Number',
                          style: TextStyle(color: Colors.grey),
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text('+639 3323 8234',
                            softWrap: true,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))),
                  ],
                )),
            Card(
                margin: EdgeInsets.all(10),
                elevation: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding:
                            EdgeInsets.only(right: 20, top: 10, bottom: 10),
                        child: Text(
                          'Home Address',
                          maxLines: 4,
                          style: TextStyle(color: Colors.grey),
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text('169D Concepcion Naga City',
                            softWrap: true,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))),
                  ],
                )),
            Card(
              margin: EdgeInsets.all(10),
              elevation: 5,
              shadowColor: Colors.black,
              child: Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(right: 40, top: 10, bottom: 10),
                      child: Text(
                        'Total Debt',
                        style: TextStyle(color: Colors.grey),
                      )),
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Icon(Icons.attach_money),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text('50,000',
                          softWrap: true,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              //crossAxisAlignment: CrossAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    IconButton(
                        icon: const Icon(
                          Icons.payments,
                          size: 30,
                        ),
                        tooltip: 'Payment History',
                        onPressed: () {}),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                        icon: const Icon(
                          Icons.credit_score,
                          size: 30,
                        ),
                        tooltip: 'Loan History',
                        onPressed: () {}),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                        icon: const Icon(
                          Icons.gavel,
                          size: 30,
                        ),
                        tooltip: 'View Contract',
                        onPressed: () {}),
                  ],
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}
