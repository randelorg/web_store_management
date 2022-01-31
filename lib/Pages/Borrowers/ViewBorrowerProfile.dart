import 'package:flutter/material.dart';
import 'package:web_store_management/Backend/HistoryOperation.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Pages/Borrowers/UpdateBorrowerPage.dart';
import '../Reports/HistoryScreens/PaymentHistoryScreen.dart';
import '../Reports/HistoryScreens/ProductHistoryScreen.dart';
import '../../Helpers/CreateQRHelper.dart';

class ViewBorrowerProfile extends StatefulWidget {
  final String? id, name, number;
  final double? balance;
  ViewBorrowerProfile({
    required this.id,
    required this.name,
    required this.number,
    required this.balance,
  });

  @override
  _ViewBorrowerProfile createState() => _ViewBorrowerProfile();
}

class _ViewBorrowerProfile extends State<ViewBorrowerProfile> {
  var history = HistoryOperation();
  String address = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.all(20),
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
                    return UpdateBorrowerPage(
                      bid: widget.id.toString(),
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
                    padding: EdgeInsets.only(right: 40, top: 10, bottom: 5),
                    child: Text(
                      'Total Debt',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Icon(Icons.attach_money),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 5),
                    child: Text(
                      widget.balance.toString(),
                      softWrap: true,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
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
                      onPressed: () {
                        history.viewPaymentHistory(widget.id.toString());
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SimpleDialog(
                              children: [
                                Container(
                                  width:
                                      (MediaQuery.of(context).size.width) / 2,
                                  height: (MediaQuery.of(context).size.height),
                                  child: PaymentHistory(
                                    id: widget.id.toString(),
                                    borrowerName: widget.name.toString(),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    Text(
                      'Payment History',
                      style: TextStyle(fontSize: 8),
                    )
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
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SimpleDialog(
                              children: [
                                Container(
                                  width:
                                      (MediaQuery.of(context).size.width) / 2,
                                  height: (MediaQuery.of(context).size.height),
                                  child: ProductHistory(
                                    borrowerId: widget.id.toString(),
                                    borrowerName: widget.name.toString(),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    Text(
                      'Loan History',
                      style: TextStyle(fontSize: 8),
                    )
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
                      onPressed: () {},
                    ),
                    Text(
                      'View Contract',
                      style: TextStyle(fontSize: 8),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ],
    );
  }

  String _findAddress(String bid) {
    String address = '';
    Mapping.borrowerList
        .where((element) => element.borrowerId?.toString() == bid)
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
        "Balance " +
        widget.balance.toString();
    return content;
  }
}
