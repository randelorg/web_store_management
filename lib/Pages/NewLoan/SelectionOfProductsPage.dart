import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Backend/TextMessage.dart';
import 'package:web_store_management/Models/ProductModel.dart';
import 'package:web_store_management/Notification/BannerNotif.dart';
import '../../Helpers/FilePickerHelper.dart';
import 'FinalizePage.dart';
import '../../Backend/Utility/Mapping.dart';
import '../../Backend/GlobalController.dart';

class SelectionOfProductsPage extends StatefulWidget {
  const SelectionOfProductsPage({Key? key}) : super(key: key);

  @override
  _SelectionOfProductsPage createState() => _SelectionOfProductsPage();
}

class _SelectionOfProductsPage extends State<SelectionOfProductsPage> {
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  //final mobileNumber = TextEditingController();
  final homeAddress = TextEditingController();
  //classess
  var pick = Picker();
  var image;
  //display selected file name
  String fileName = 'UPLOAD CONTRACT';

  var controller = GlobalController();
  late Future _products;
  int indexValue = 0;

  //for mobile verification
  final mobileNumberOtp = TextEditingController();
  final otp = TextEditingController();
  var sendMessOtp = TextMessage();
  int counter = 0;
  bool successSentOtp = false, sendButton = true;
  String _verifyOtp = '';

  bool checkOtp(int code) {
    if (code == int.parse(_verifyOtp)) return true;

    return false;
  }

  @override
  void initState() {
    super.initState();
    this._products = controller.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          margin: EdgeInsets.all(10),
          width: (MediaQuery.of(context).size.width) / 4,
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Step 1",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const Text(
                  "BORROWER DETAILS",
                  style: TextStyle(fontFamily: 'Cairo_Bold', fontSize: 30),
                ),
                Padding(
                  padding: EdgeInsets.all(6),
                  child: TextField(
                    controller: mobileNumberOtp,
                    maxLength: 12,
                    enabled: false,
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
                  padding: EdgeInsets.only(
                      top: 20,
                      bottom: 6,
                      right: 6,
                      left: 6), //add padding to the textfields
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
                  padding: EdgeInsets.all(6),
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
                  padding: EdgeInsets.all(6),
                  child: TextField(
                    controller: homeAddress,
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
                  padding: EdgeInsets.only(top: 3),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: HexColor("#155293"),
                            ),
                          ),
                        ),
                        TextButton.icon(
                          icon: Icon(Icons.attach_file, color: Colors.white),
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            textStyle: TextStyle(
                                fontSize: 18, fontFamily: 'Cairo_SemiBold'),
                          ),
                          label: Text(fileName),
                          onPressed: () {
                            //get the filename and display it
                            pick.pickFile().then((value) {
                              setState(() {
                                fileName = value;
                              });
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const VerticalDivider(
          color: Colors.grey,
          thickness: 1,
          indent: 60,
          endIndent: 60,
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Step 2",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                "SEARCH PRODUCT",
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Cairo_Bold', fontSize: 30),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5, right: 20),
                  child: Container(
                    width: 300,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Product Barcode',
                        //TODO: add scan feature barcode here
                        // suffixIcon: IconButton(
                        //   onPressed: () {},
                        //   icon: Icon(Icons.scanner_sharp),
                        //   tooltip: 'Scan Product Barcode',
                        // ),
                        filled: true,
                        fillColor: Colors.blueGrey[50],
                        labelStyle: TextStyle(fontSize: 10),
                        contentPadding: EdgeInsets.only(left: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueGrey.shade50),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueGrey.shade50),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
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
                                fontFamily: 'Cairo_SemiBold', fontSize: 14),
                          ),
                          child: const Text('SEARCH'),
                          onPressed: () async {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            productInfo()
          ],
        ),

        // Row(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   crossAxisAlignment: CrossAxisAlignment.end,
        //   children: [
        //     Container(
        //       alignment: Alignment.center,
        //       width: 120,
        //       height: 60,
        //       child: ClipRRect(
        //         borderRadius: BorderRadius.circular(12),
        //         child: Stack(
        //           children: <Widget>[
        //             Positioned.fill(
        //               child: Container(
        //                 decoration: BoxDecoration(
        //                   color: HexColor("#155293"),
        //                 ),
        //               ),
        //             ),
        //             TextButton(
        //               style: TextButton.styleFrom(
        //                 padding: const EdgeInsets.all(15),
        //                 primary: Colors.white,
        //                 textStyle: TextStyle(
        //                   fontSize: 25,
        //                   fontFamily: 'Cairo_SemiBold',
        //                 ),
        //               ),
        //               onPressed: () {
        //                 //push to second page
        //                 //which is the finalize order page
        //                 if (firstname.text.isEmpty ||
        //                     lastname.text.isEmpty ||
        //                     homeAddress.text.isEmpty) {
        //                   BannerNotif.notif(
        //                       "Error",
        //                       "Please fill all the fields",
        //                       Colors.red.shade600);
        //                 } else if (pick.image == null) {
        //                   BannerNotif.notif(
        //                       "Error",
        //                       "Please upload a file (jpg, png, jpeg)",
        //                       Colors.red.shade600);
        //                 } else {
        //                   showDialog(
        //                     context: context,
        //                     builder: (BuildContext context) {
        //                       return SimpleDialog(
        //                         children: [
        //                           Container(
        //                             width:
        //                                 (MediaQuery.of(context).size.width) / 2,
        //                             height: 555,
        //                             child: FinalizePage(
        //                               action: 'new_loan',
        //                               firstname: firstname.text,
        //                               lastname: lastname.text,
        //                               mobile: mobileNumberOtp.text,
        //                               address: homeAddress.text,
        //                               contract: pick.getImageBytes(),
        //                             ),
        //                           ),
        //                         ],
        //                       );
        //                     },
        //                   );
        //                 }
        //               },
        //               child: const Text('NEXT'),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }

  Widget productInfo() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
      ),
      shadowColor: Colors.black,
      child: SizedBox(
        width: (MediaQuery.of(context).size.width) / 4,
        height: (MediaQuery.of(context).size.width) / 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: ListTile(
                title: Text(
                  'brwCredit[index].getStatus.toString()',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Cairo_SemiBold',
                  ),
                ),
                subtitle: Text(
                  'status',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              shadowColor: Colors.black,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 10, top: 10, bottom: 10, right: 50),
                    child: Text(
                      'Name',
                      softWrap: true,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontFamily: 'Cairo_SemiBold',
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'brwCredit[index].toString()',
                      overflow: TextOverflow.visible,
                      maxLines: 2,
                      softWrap: true,
                      style: TextStyle(
                        fontFamily: 'Cairo_SemiBold',
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              shadowColor: Colors.black,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 10, top: 10, bottom: 10, right: 40),
                    child: Text(
                      'Address',
                      softWrap: true,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontFamily: 'Cairo_SemiBold',
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'brwCredit[index].getHomeAddress.toString()',
                      overflow: TextOverflow.visible,
                      softWrap: true,
                      maxLines: 3,
                      style:
                          TextStyle(fontFamily: 'Cairo_SemiBold', fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              shadowColor: Colors.black,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 10, top: 10, bottom: 10, right: 40),
                    child: Text(
                      'Number',
                      softWrap: true,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontFamily: 'Cairo_SemiBold',
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '  brwCredit[index].getMobileNumber.toString()',
                      overflow: TextOverflow.visible,
                      softWrap: true,
                      maxLines: 2,
                      style:
                          TextStyle(fontFamily: 'Cairo_SemiBold', fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: TextStyle(
                  fontSize: 10,
                  decoration: TextDecoration.underline,
                ),
              ),
              child: Text(
                'Show Application',
                style: TextStyle(
                  color: HexColor("#155293"),
                ),
              ),
              onPressed: () {},
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
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
                                left: 20, right: 20, top: 10, bottom: 10),
                            primary: Colors.white,
                            textStyle: TextStyle(
                                fontSize: 18, fontFamily: 'Cairo_SemiBold')),
                        child: const Text('APPROVE'),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.cancel),
                  color: Colors.redAccent.shade400,
                  tooltip: 'DENY CREDIT',
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _verifyMobile() {
    return AlertDialog(
      actionsPadding: EdgeInsets.only(bottom: 5, left: 5, right: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      actions: <Widget>[
        Column(
          children: [
            Text(
              'Mobile Verification',
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: HexColor("#155293"),
                fontFamily: 'Cairo_Bold',
                fontSize: 30,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 7),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Enter mobile number',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: TextField(
                controller: mobileNumberOtp,
                maxLength: 11,
                autofocus: true,
                decoration: InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor: Colors.blueGrey[50],
                  labelStyle: TextStyle(fontSize: 10),
                  contentPadding: EdgeInsets.only(left: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey.shade50),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey.shade50),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            //send OTP to the mobile number button
            Visibility(
              visible: sendButton,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
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
                              left: 20, right: 20, top: 15, bottom: 15),
                          primary: Colors.white,
                          textStyle: TextStyle(
                            fontFamily: 'Cairo_SemiBold',
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        child: Text('Send OTP'),
                        onPressed: () {
                          if (mobileNumberOtp.text.isEmpty) {
                            BannerNotif.notif(
                              "Error",
                              "Please fill the mobile number field",
                              Colors.red.shade600,
                            );
                          } else {
                            if (mobileNumberOtp.text.isNotEmpty) {
                              _checkNumberifExisting(mobileNumberOtp.text)
                                  .then((value) {
                                if (!value) {
                                  sendMessOtp
                                      .getOtp(mobileNumberOtp.text)
                                      .then((value) {
                                    if (value > 0) {
                                      setState(() {
                                        successSentOtp = true;
                                        sendButton = false;
                                      });
                                      _verifyOtp = value.toString();
                                    } else {
                                      BannerNotif.notif(
                                        "Error",
                                        "Something went wrong please try again",
                                        Colors.red.shade600,
                                      );
                                    }
                                  });
                                } else {
                                  BannerNotif.notif(
                                    "Existing",
                                    "Mobile number is existing or use in different application",
                                    Colors.red.shade600,
                                  );
                                }
                              });
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: successSentOtp,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 30, left: 7),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Enter OTP',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: TextField(
                      controller: otp,
                      autofocus: true,
                      maxLength: 6,
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: Colors.blueGrey[50],
                        labelStyle: TextStyle(fontSize: 10),
                        contentPadding: EdgeInsets.only(left: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueGrey.shade50),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueGrey.shade50),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  //verify OTP
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Container(
                              decoration:
                                  BoxDecoration(color: HexColor("#155293")),
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
                            child: Text('Verify OTP'),
                            onPressed: () {
                              if (mobileNumberOtp.text.isEmpty) {
                                BannerNotif.notif(
                                  "Error",
                                  "Please fill the mobile number field",
                                  Colors.red.shade600,
                                );
                              } else {
                                if (checkOtp(int.parse(otp.text))) {
                                  setState(() {
                                    indexValue = 1;
                                  });
                                } else {
                                  setState(() {
                                    counter++;
                                  });

                                  //show snackbar that the otp is wrong
                                  BannerNotif.notif(
                                    'Try again',
                                    'Wrong OTP',
                                    Colors.red.shade600,
                                  );

                                  if (counter >= 3) {
                                    setState(() {
                                      successSentOtp = false;
                                      sendButton = true;
                                    });
                                    //attempted to enter wrong OTP 3 times
                                    BannerNotif.notif(
                                      'WRONG OTP',
                                      'You enter wrong OTP for 3 times, try again in few minutes',
                                      Colors.red.shade600,
                                    );
                                  }
                                }
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
          ],
        )
      ],
    );
  }

  Future<bool> _checkNumberifExisting(String mobile) async {
    bool result = false;
    await sendMessOtp.checkNumberIfNew(mobile).then((value) {
      if (value)
        result = value;
      else
        result = value;
    });

    return result;
  }
}

//selection of products
class _RowSelectProducts {
  _RowSelectProducts(
    this.valueA,
    this.valueB,
    this.valueC,
  );

  final String valueA;
  final String valueB;
  final String valueC;

  bool selected = false;
}

class _SelectionOfProducts extends DataTableSource {
  _SelectionOfProducts(this.context) {
    _rows = _selectionProducts();
  }

  int _selectedCount = 0;
  final BuildContext context;
  List<_RowSelectProducts> _rows = [];

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return null;
    final row = _rows[index];
    return DataRow.byIndex(
      index: index,
      selected: row.selected,
      onSelectChanged: (value) {
        if (row.selected) {
          value = false;
        } else {
          value = true;
        }

        if (row.selected != value) {
          if (value) {
            _selectedCount = 1;
          }

          assert(_selectedCount >= 0);
          row.selected = value;
          //add the checked product to the list
          //we will remove the duplicate products afterward
          Mapping.selectedProducts.add(
            ProductModel.selectedProduct(
              row.valueA.toString(), //code
              row.valueB.toString(), //name
              double.parse(
                row.valueC.toString(), //price
              ),
            ),
          );

          //delete the uncheck product to the list
          if (value == false) {
            Mapping.selectedProducts.removeWhere(
              (element) => element.productCode == row.valueA.toString(),
            );
          }

          notifyListeners();
        }
      },
      cells: [
        DataCell(Text(row.valueA)),
        DataCell(Text(row.valueB)),
        DataCell(Text(row.valueC)),
      ],
    );
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  List<_RowSelectProducts> _selectionProducts() {
    try {
      return List.generate(
        Mapping.productList.length,
        (index) {
          return new _RowSelectProducts(
            Mapping.productList[index].getProductCode.toString(),
            Mapping.productList[index].getProductName.toString(),
            Mapping.productList[index].getProductPrice
                .toStringAsFixed(2)
                .toString(),
          );
        },
      );
    } catch (e) {
      //if product list is empty
      return List.generate(0, (index) {
        return _RowSelectProducts(
          '',
          '',
          '',
        );
      });
    }
  }
}
