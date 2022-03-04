import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:web_store_management/Backend/BorrowerOperation.dart';
import 'package:web_store_management/Notification/Snack_notification.dart';

class AddRepair extends StatefulWidget {
  final String? id, name, address, number;
  AddRepair({required this.id, this.name, this.address, this.number});
  @override
  _AddRepair createState() => _AddRepair();
}

class _AddRepair extends State<AddRepair> {
  var borrower = BorrowerOperation();
  final TextEditingController dateinput = TextEditingController();
  final TextEditingController productname = TextEditingController();
  final TextEditingController brwname = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController mobile = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateinput.text = "";
    brwname.text = widget.name.toString();
    address.text = widget.address.toString();
    mobile.text = widget.number.toString();
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
              'New Repair',
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
                  'Product Name',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Container(
              width: 320,
              child: Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: TextField(
                  controller: productname,
                  decoration: InputDecoration(
                    hintText: 'Product Name',
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
            ),
          
            Padding(
              padding: EdgeInsets.only(left: 2),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Borrower Name',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: TextField(
                controller: brwname,
                enabled: false,
                decoration: InputDecoration(
                  hintText: 'Borrower Name',
                  suffixIcon: InkWell(
                    child: IconButton(
                      icon: Icon(Icons.qr_code_scanner_outlined),
                      color: Colors.grey,
                      tooltip: 'Search by QR',
                      onPressed: () {},
                    ),
                  ),
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
                enabled: false,
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
                controller: mobile,
                enabled: false,
                decoration: InputDecoration(
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
                  'Date of turn over',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: TextField(
                controller: dateinput,
                decoration: InputDecoration(
                  labelStyle: TextStyle(fontSize: 12),
                  hintText: 'Date of turn over',
                  filled: true,
                  fillColor: Colors.blueGrey[50],
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
                    print(pickedDate);
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(formattedDate);
                    setState(() {
                      dateinput.text = formattedDate;
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
                        padding: const EdgeInsets.only(left: 20, right: 20, top: 18, bottom: 18),
                        primary: Colors.white,
                        textStyle: TextStyle(
                            fontFamily: 'Cairo_SemiBold',
                            fontSize: 16,
                            color: Colors.white),
                      ),
                      child: const Text('ADD REPAIR'),
                      onPressed: () {
                        if (productname.text.isEmpty || dateinput.text.isEmpty) {
                          SnackNotification.notif(
                            "Error",
                             "Please fill all the fields",Colors.red.shade600);
                        } else {
                          Navigator.pop(context);
                          borrower
                              .addRepair(
                            int.parse(widget.id.toString()),
                            productname.text,
                            dateinput.text,
                          )
                              .then((value) {
                            if (value) {
                              SnackNotification.notif(
                                "Success",
                                "Successfully added repair",
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
        )
      ],
    );
  }
}
