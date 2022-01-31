import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_store_management/Backend/LoanOperation.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Notification/Snack_notification.dart';

class PaymentPlanPage extends StatefulWidget {
  final String? firstname, lastname, mobile, address;
  final num total;
  PaymentPlanPage({
    required this.firstname,
    required this.lastname,
    required this.mobile,
    required this.address,
    required this.total,
  });

  @override
  _PaymentPlanPage createState() => _PaymentPlanPage();
}

class _PaymentPlanPage extends State<PaymentPlanPage> {
  var newloan = LoanOperation();
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
      actionsPadding: EdgeInsets.all(20),
      title: Text(
        'Payment Plan',
        softWrap: true,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Colors.black,
          overflow: TextOverflow.fade,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actions: <Widget>[
        Column(
          children: [
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
                  contentPadding: EdgeInsets.only(left: 30),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500),
                    borderRadius: BorderRadius.circular(10),
                  ),
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
                  contentPadding: EdgeInsets.only(left: 30),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Terms (if months interact with the slider)',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Container(
                width: 380,
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
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.blue.shade700),
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
            Slider(
              value: _currenSliderValue,
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
              padding: EdgeInsets.all(10),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Choose due date if months is selected',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextField(
                controller: duedate,
                decoration: InputDecoration(
                  labelStyle: TextStyle(fontSize: 12),
                  contentPadding: EdgeInsets.only(left: 30),
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
                      firstDate: DateTime(1999),
                      lastDate: DateTime(2031));
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
              padding: const EdgeInsets.only(top: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade900,
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 15, bottom: 15),
                        primary: Colors.white,
                        textStyle: TextStyle(fontSize: 20),
                      ),
                      child: const Text('SEND TO REVIEW'),
                      onPressed: () {
                        newloan
                            .addBorrower(
                          widget.firstname.toString(),
                          widget.lastname.toString(),
                          widget.mobile.toString(),
                          widget.address.toString(),
                          widget.total,
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
