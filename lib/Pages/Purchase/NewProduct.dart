import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class NewProduct extends StatefulWidget {
  @override
  _NewProduct createState() => _NewProduct();
}

class _NewProduct extends State<NewProduct> {

  var productCode = new TextEditingController();
  var productName = new TextEditingController();
  var productPrice = new TextEditingController();
  var productUnit = new TextEditingController();
  var productLabel = new TextEditingController();


  String _appliances = 'Appliances';
  final String grocery= 'Grocery';
  final String ComputerAccessories = 'Computer Accessories';


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 120),
          child: Text(
            'New Product Details',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: HexColor("#155293"),
              fontFamily: 'Cairo_Bold',
              fontSize: 30,
              overflow: TextOverflow.fade,
            ),
            maxLines: 2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(6),
          child: TextField(
            controller: productCode,
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
        Padding(
          padding: const EdgeInsets.all(6),
          child: TextField(
            controller: productName,
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
          padding: const EdgeInsets.all(6),
          child: TextField(
            controller: productPrice,
            decoration: InputDecoration(
              hintText: 'Product Price',
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
          padding: const EdgeInsets.all(6),
          child: TextField(
            controller: productUnit,
            decoration: InputDecoration(
              hintText: 'Product Unit',
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
         Container(
            width: 405,
            decoration: BoxDecoration(
              color: Colors.blueGrey[50],
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.blueGrey.shade50,
                style: BorderStyle.solid,
                width: 0.80,
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value:_appliances,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: HexColor("#155293")),
                onChanged: (type) {
                  setState(() {
                    _appliances = type!;
                  });
                },
                items: <String>['Appliances', 'Grocery', 'Computer Accessories']
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
          Padding(
          padding: const EdgeInsets.all(6),
          child: TextField(
            controller: productLabel,
            decoration: InputDecoration(
              hintText: 'Product Label',
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
                      top: 18,
                      bottom: 18,
                      left: 36,
                      right: 36,
                    ),
                    primary: Colors.white,
                    textStyle: TextStyle(
                      fontFamily: 'Cairo_SemiBold',
                      fontSize: 14,
                    ),
                  ),
                  child: const Text('ADD PRODUCT'),
                  onPressed: () async {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
