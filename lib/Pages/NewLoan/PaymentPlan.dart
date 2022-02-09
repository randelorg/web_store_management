import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:web_store_management/Backend/LoanOperation.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Notification/Snack_notification.dart';

class PaymentPlanPage extends StatefulWidget {
  final String? firstname, lastname, mobile, address;
  final num total;
  final Uint8List contract;
  PaymentPlanPage(
      {required this.firstname,
      required this.lastname,
      required this.mobile,
      required this.address,
      required this.total,
      required this.contract});

  @override
  _PaymentPlanPage createState() => _PaymentPlanPage();
}

class _PaymentPlanPage extends State<PaymentPlanPage> {
  var newloan = LoanOperation();
  var image;
  TextEditingController borrowerName = TextEditingController();
  TextEditingController totalAmount = TextEditingController();
  TextEditingController duedate = TextEditingController();

  String plan = 'Daily';
  double _currenSliderValue = 3;

  @override
  void initState() {
    duedate.text = "";
    super.initState();
    borrowerName.text =
        widget.firstname.toString() + " " + widget.lastname.toString();
    totalAmount.text = widget.total.toString();
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
              'Payment Plan',
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: HexColor("#155293"),
                fontFamily: 'Cairo_Bold',
                fontSize: 30,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Borrower Name',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextField(
                controller: borrowerName,
                enabled: false,
                decoration: InputDecoration(
                  hintText: 'Borrower Name',
                  //enabled: false,
                  filled: true,
                  fillColor: Colors.blueGrey[50],
                  labelStyle: TextStyle(fontSize: 12),
                  contentPadding: EdgeInsets.only(left: 15),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Total Amount',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextField(
                controller: totalAmount,
                enabled: false,
                decoration: InputDecoration(
                  hintText: 'Total Amount',
                  //enabled: false,
                  filled: true,
                  fillColor: Colors.blueGrey[50],
                  labelStyle: TextStyle(fontSize: 12),
                  contentPadding: EdgeInsets.only(left: 15),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Terms (if months interact with the slider)',
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
                    value: plan,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: HexColor("#155293")),
                    onChanged: (String? value) {
                      setState(() {
                        plan = value!;
                      });
                    },
                    items: <String>['Daily', 'Every 15 days', 'Monthly']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            Slider(
              value: _currenSliderValue,
              inactiveColor: HexColor("#155293"),
              activeColor: HexColor("#155293"),
              min: 3,
              max: 12,
              divisions: 3,
              label: _currenSliderValue.toString(),
              onChanged: (double value) {
                setState(() {
                  _currenSliderValue = value;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Choose due date if months is selected',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextField(
                controller: duedate,
                decoration: InputDecoration(
                  labelStyle: TextStyle(fontSize: 12),
                  contentPadding: EdgeInsets.only(left: 15),
                  hintText: 'Due Date',
                  fillColor: Colors.blueGrey[50],
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                //readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2022),
                    lastDate: DateTime(2032),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: Colors.red, //Background Color
                            onPrimary: Colors.white, //Text Color
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              primary: Colors.black, //Button Text Color
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    setState(() {
                      duedate.text = formattedDate;
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(color: HexColor("#155293")),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 20, bottom: 20),
                          primary: Colors.white,
                          textStyle: TextStyle(
                              fontSize: 14, fontFamily: 'Cairo_SemiBold')),
                      child: const Text('SEND TO REVIEW'),
                      onPressed: () {
                        newloan
                            .addBorrower(
                          widget.firstname.toString(),
                          widget.lastname.toString(),
                          widget.mobile.toString(),
                          widget.address.toString(),
                          widget.total,
                          widget.contract,
                        )
                            .then(
                          (value) {
                            if (value) {
                              newloan
                                  .addNewLoan(
                                    widget.firstname.toString(),
                                    widget.lastname.toString(),
                                    plan,
                                    _currenSliderValue.toString(),
                                    duedate.text,
                                  )
                                  .then(
                                    (value) => {
                                      if (value)
                                        {
                                          Navigator.pop(context),
                                          //clear all the previous addition in this list
                                          Mapping.selectedProducts.clear(),
                                          SnackNotification.notif(
                                            'Success',
                                            'New loan is sent to credit approval',
                                            Colors.green.shade900,
                                          )
                                        }
                                    },
                                  );
                            }
                          },
                        );
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
