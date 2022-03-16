import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:printing/printing.dart';
import 'package:web_store_management/Backend/BorrowerOperation.dart';
import 'package:web_store_management/Backend/HistoryOperation.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Helpers/PrintHelper.dart';
import 'package:web_store_management/Pages/Borrowers/UpdateBorrowerPage.dart';
import '../Reports/GlobalHistoryScreens/PaymentHistoryScreen.dart';
import '../Reports/GlobalHistoryScreens/ProductHistoryScreen.dart';
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
  var brw = BorrowerOperation();
  String address = "";

  @override
  void initState() {
    super.initState();
  }

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
              'Borrower Profile',
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: HexColor("#155293"),
                fontFamily: 'Cairo_Bold',
                fontSize: 30,
              ),
            ),
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
                Navigator.pop(context);
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
              margin: EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              shadowColor: Colors.black,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 10, top: 10, bottom: 10, right: 70),
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
                    style:
                        TextStyle(fontSize: 14, fontFamily: 'Cairo_SemiBold'),
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
                    padding: EdgeInsets.only(
                        left: 10, top: 10, bottom: 10, right: 25),
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
                    style:
                        TextStyle(fontSize: 14, fontFamily: 'Cairo_SemiBold'),
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
                    padding: EdgeInsets.only(
                        left: 10, top: 10, bottom: 10, right: 45),
                    child: Text(
                      'Total Debt',
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontFamily: 'Cairo_SemiBold',
                          fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 3),
                    child: Icon(Icons.attach_money),
                  ),
                  Text(
                    widget.balance.toString(),
                    softWrap: true,
                    style:
                        TextStyle(fontSize: 14, fontFamily: 'Cairo_SemiBold'),
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
                                  child: LocalPaymentHistory(
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
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              child: PdfPreview(
                                padding: EdgeInsets.all(100),
                                build: (format) =>
                                    PrintHelper.generatePdfContract(
                                  widget.id.toString(),
                                ),
                              ),
                            );
                          },
                        );
                      },
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
