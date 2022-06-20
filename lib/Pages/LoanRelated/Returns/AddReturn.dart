import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:web_store_management/Backend/BorrowerOperation.dart';
import 'package:web_store_management/Notification/BannerNotif.dart';

class AddReturn extends StatefulWidget {
  final String? itemcode, barcode, remarks;
  AddReturn({required this.itemcode, this.barcode, this.remarks});
  @override
  _AddReturn createState() => _AddReturn();

  final String returnStatus = 'PENDING';
}

class _AddReturn extends State<AddReturn> {
  var borrower = BorrowerOperation();

  var dateinput = TextEditingController();
  var productItemcode = TextEditingController();
  var productBarcode = TextEditingController();
  var productRemarks = TextEditingController();

  //for customers
  var mobile = TextEditingController();
  var fullname = TextEditingController();
  var address = TextEditingController();

  @override
  void initState() {
    dateinput.text = "";
    productItemcode.text = widget.itemcode.toString();
    productBarcode.text = widget.barcode.toString();
    productRemarks.text = widget.remarks.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 140),
          child: Text(
            'Add Returns',
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: HexColor("#155293"),
              fontFamily: 'Cairo_Bold',
              fontSize: 25,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, left: 2),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Product Details',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Cairo_Bold',
                ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 2),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Product Barcode',
              style: TextStyle(fontSize: 10),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: TextField(
              controller: productItemcode,
              enabled: false,
              decoration: InputDecoration(
                hintText: 'Product Barcode',
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
              'Product Item Code',
              style: TextStyle(fontSize: 10),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: TextField(
            controller: productItemcode,
            enabled: false,
            decoration: InputDecoration(
              hintText: 'Item Code',
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
              'Product Description',
              style: TextStyle(fontSize: 10),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: TextField(
            controller: productRemarks,
            enabled: false,
            decoration: InputDecoration(
              hintText: 'Description',
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
          padding: EdgeInsets.only(top: 20, left: 2),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Customer Details',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Cairo_Bold',
                ),
            ),
          ),
        ),    
        Padding(
          padding: EdgeInsets.only(left: 2),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Full Name',
              style: TextStyle(fontSize: 10),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: TextField(
            controller: fullname,
            decoration: InputDecoration(
              hintText: 'Full Name',
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
          padding: EdgeInsets.only(left: 2),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Date of Turn Over',
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
              hintText: 'Date of Turn Over',
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
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                setState(() {
                  dateinput.text = formattedDate;
                });
              } else {
                print("Date is not selected");
              }
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
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
                              left: 20, right: 20, top: 15, bottom: 15),
                          primary: Colors.white,
                          textStyle: TextStyle(
                              fontFamily: 'Cairo_SemiBold',
                              fontSize: 14,
                              color: Colors.white),
                        ),
                        child: const Text('ADD RETURNS'),
                        onPressed: () {
                          if (fullname.text.isEmpty) {
                            BannerNotif.notif(
                              "Error",
                              "Please fill all the fields",
                              Colors.red.shade600,
                            );
                          } else {
                            Navigator.pop(context);
                            borrower
                                .addReturn(
                              widget.returnStatus,
                              widget.itemcode.toString(),
                              dateinput.text,
                              fullname.text,
                              mobile.text,
                              address.text,
                            )
                                .then((value) {
                              if (value) {
                                BannerNotif.notif(
                                  "Success",
                                  "Successfully added return",
                                  Colors.green.shade600,
                                );
                              }
                            });
                          }
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
