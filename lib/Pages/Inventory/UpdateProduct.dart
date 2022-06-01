import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Notification/BannerNotif.dart';
import '../../Backend/ProductOperation.dart';
import '../../Backend/Utility/Mapping.dart';

class UpdateProduct extends StatefulWidget {
  final String? name, price, unit, quantity;
  UpdateProduct({this.name, this.quantity, this.price, this.unit});

  @override
  _UpdateProduct createState() => _UpdateProduct();
}

class _UpdateProduct extends State<UpdateProduct> {
  var operation = ProductOperation();
  final prodName = TextEditingController();
  final prodQuantity = TextEditingController();
  final prodQtySuffix = TextEditingController();
  final prodPrice = TextEditingController();
  final prodUnit = TextEditingController();

  @override
  void initState() {
    super.initState();
    prodName.text = widget.name.toString();
    prodQtySuffix.text = widget.quantity.toString();
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
              padding: EdgeInsets.only(top: 20, left: 2),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Product Name',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
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
              padding: EdgeInsets.only(left: 2),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Quantity Available: ' + prodQtySuffix.text,
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: TextField(
                controller: prodQuantity,
                onChanged: (value) {
                  //if value is empty then set the qty suffix to empty or 0
                  if (value.isEmpty) {
                    setState(() {
                      prodQuantity.text = '0';
                    });
                  }
                },
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
              padding: EdgeInsets.only(left: 2),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Unit',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
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
              padding: EdgeInsets.only(left: 2),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Price',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
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
                        padding: const EdgeInsets.only(
                            left: 36, right: 36, top: 18, bottom: 18),
                        primary: Colors.white,
                        textStyle: TextStyle(
                          fontFamily: 'Cairo_SemiBold',
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      child: const Text('UPDATE'),
                      onPressed: () {
                        if (prodName.text.isEmpty ||
                            prodQuantity.text.isEmpty ||
                            prodUnit.text.isEmpty ||
                            prodPrice.text.isEmpty) {
                          BannerNotif.notif(
                              "Error",
                              "Please fill all the fields",
                              Colors.red.shade600);
                        } else {
                          operation
                              .updateProductDetails(
                            _findBarCode(),
                            prodName.text,
                            _qtyIsEmpty(),
                            prodUnit.text,
                            double.parse(prodPrice.text),
                          )
                              .then((value) {
                            if (value) {
                              Navigator.pop(context);
                              BannerNotif.notif(
                                'Success',
                                "Product " + prodName.text + " is updated",
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

  int _qtyIsEmpty() {
    if (prodQuantity.text.isEmpty) {
      return 0;
    } else {
      return int.parse(prodQuantity.text);
    }
  }

  String _findBarCode() {
    String barcode = '';
    Mapping.productList
        .where((element) =>
            element.productName?.toLowerCase() ==
            widget.name.toString().toLowerCase())
        .forEach((element) {
      barcode = element.getProductCode;
    });
    return barcode;
  }
}
