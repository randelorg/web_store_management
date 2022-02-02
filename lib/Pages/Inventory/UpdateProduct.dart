import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Notification/Snack_notification.dart';
import 'package:web_store_management/Pages/Inventory/InventoryPage.dart';
import '../../Backend/ProductOperation.dart';
import '../../Backend/Utility/Mapping.dart';

class UpdateProduct extends StatefulWidget {
  final String? name, quantity, price, unit;
  UpdateProduct({this.name, this.quantity, this.price, this.unit});

  @override
  _UpdateProduct createState() => _UpdateProduct();
}

class _UpdateProduct extends State<UpdateProduct> {
  var operation = ProductOperation();
  var updateTable = InventoryPage();
  final prodName = TextEditingController();
  final prodQuantity = TextEditingController();
  final prodQtySuffix = TextEditingController();
  final prodPrice = TextEditingController();
  final prodUnit = TextEditingController();

  @override
  void initState() {
    super.initState();
    prodName.text = widget.name.toString();
    prodQtySuffix.text = _findQty();
    prodPrice.text = widget.price.toString();
    prodUnit.text = widget.unit.toString();
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
             'Update Product',
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(             
                color: HexColor("#155293"),
                fontFamily: 'Cairo_Bold',
                fontSize: 30,
              ),
            ),

             Padding(
              padding: EdgeInsets.only(top: 25, left: 7),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Product Name',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                  left: 6.0, right: 6.0, bottom: 6.0, top: 1.0),
              child: TextField(
                controller: prodName,
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
            Padding(
              padding: EdgeInsets.only(left: 7),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text("Quantity Available: " + _findQty(),
                    style: TextStyle(fontSize: 11, color: HexColor("#155293"))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6.0, right: 6.0, bottom: 6.0, top: 1.0),
              child: TextField(
                controller: prodQuantity,
                // onChanged: (value) {
                //   //if value is empty then set the qty suffix to empty or 0
                //   if (value.isEmpty) {
                //     setState(() {
                //       prodQuantity.text = '0';
                //     });
                //   }
                // },
                decoration: InputDecoration(
                  hintText: 'Quantity',
                  filled: true,
                  fillColor: Colors.blueGrey[50],
                  labelStyle: TextStyle(fontSize: 12),
                  contentPadding: EdgeInsets.only(left: 15, right: 10),
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
                  'Unit',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 6.0, right: 6.0, bottom: 6.0, top: 1.0),
              child: TextField(
                controller: prodUnit,
                decoration: InputDecoration(
                  hintText: 'Unit',
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
                  'Price',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                  left: 6.0, right: 6.0, bottom: 6.0, top: 1.0),
              child: TextField(
                controller: prodPrice,
                decoration: InputDecoration(
                  hintText: 'Price',
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
                        padding: const EdgeInsets.only(top: 18, bottom: 18, left: 36, right: 36),
                        primary: Colors.white,
                        textStyle: TextStyle(
                          fontFamily: 'Cairo_SemiBold',
                          fontSize: 14,
                          color: Colors.white),
                      ),

                      child: const Text('UPDATE'),
                      onPressed: () {
                        operation
                            .updateProductDetails(
                          _findBarName(),
                          prodName.text,
                          _qtyIsEmpty(),
                          prodUnit.text,
                          double.parse(prodPrice.text),
                        )
                            .then((value) {
                          if (value) {
                            Navigator.pop(context);
                            SnackNotification.notif(
                              'Success',
                              "Product " + prodName.text + " is updated",
                              Colors.green.shade600,
                            );
                          }
                        });
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

  int _qtyIsEmpty() {
    if (prodQuantity.text.isEmpty) {
      return 0;
    } else {
      return int.parse(prodQuantity.text);
    }
  }

  String _findBarName() {
    String barcode = '';
    Mapping.productList
        .where((element) =>
            element.productName?.toLowerCase() == prodName.text.toLowerCase())
        .forEach((element) {
      barcode = element.getProductCode;
    });
    return barcode;
  }

  String _findQty() {
    int qty = 0;
    Mapping.productList
        .where((element) =>
            element.productName?.toLowerCase() == prodName.text.toLowerCase())
        .forEach((element) {
      qty = element.getProductQty;
    });
    return qty.toString();
  }
}
