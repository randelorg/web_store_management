import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';
import 'package:web_store_management/Backend/BorrowerOperation.dart';
import 'package:web_store_management/Backend/ProductOperation.dart';
import 'package:web_store_management/Notification/BannerNotif.dart';
import 'package:web_store_management/Pages/LoanRelated/Returns/AddReturn.dart';

class SearchSerialNumber extends StatefulWidget {
  @override
  _SearchSerialNumber createState() => _SearchSerialNumber();
}

class _SearchSerialNumber extends State<SearchSerialNumber> {
  var itemCode = ProductOperation();
  final TextEditingController itemcode = TextEditingController();
  final TextEditingController confirmedname = TextEditingController();
  var controller = BorrowerOperation();
  List<String> borrowerDetail = [];

  @override
  void initState() {
    confirmedname.text = 'No data, Please Enter Product Item Code.';
    super.initState();
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
              'Search Item Code',
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: HexColor("#155293"),
                fontFamily: 'Cairo_Bold',
                fontSize: 15,
              ),
            ),
            Form(
              child: Center(
                child: Column(
                  children: <Widget>[
                    // Input Borrowers Name
                    Container(
                      padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                      child: TextFormField(
                        controller: itemcode,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Serial Number',
                          filled: true,
                          fillColor: Colors.blueGrey[50],
                          labelStyle: TextStyle(fontSize: 12),
                          contentPadding: EdgeInsets.only(left: 15),
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

                    // Pay Button
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      height: 40,
                      width: 110,
                      decoration: BoxDecoration(
                        color: HexColor("#155293"),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        child: Text(
                          'SEARCH',
                          style: TextStyle(
                            fontFamily: 'Cairo_SemiBold',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          if (itemcode.text.isEmpty) {
                            return;
                          }

                          itemCode.findItemCode(itemcode.text).then((value) {
                            if (value.isEmpty) {
                              BannerNotif.notif(
                                '',
                                'Cant find item code',
                                Colors.red,
                              );
                            } else {
                              Navigator.pop(context);
                              showModalSideSheet(
                                context: context,
                                width: MediaQuery.of(context).size.width / 4,
                                body: ListView(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(30.0),
                                      child: AddReturn(
                                        itemcode: value.last.getProductItemCode,
                                        barcode: value.last.getProductCode,
                                        remarks: value.last.getRemarks,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          });
                        },
                      ),
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
