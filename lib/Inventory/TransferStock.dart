import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TransferStock extends StatefulWidget {
  @override
  _TransferStock createState() => _TransferStock();
}

class _TransferStock extends State<TransferStock> {
  String originStore = 'One';
  String anotherBranch = 'One';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.all(20),
      title: Text(
        'Transfer Stock',
        softWrap: true,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35,
            color: Colors.blue,
            overflow: TextOverflow.fade),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actions: <Widget>[
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Container(
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text('Transfer products in another branch.'),
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text('From'),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 0.80),
                ),
                width: 250,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: 'This branch',
                    isDense: true,
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(child: Text("This branch"), value: ""),
                      DropdownMenuItem(child: Text("Male"), value: "Male"),
                      DropdownMenuItem(child: Text("Female"), value: "Female"),
                    ],
                    onChanged: (newValue) {
                      setState(() {});
                    },
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text('To'),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Container(
                width: 250,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 0.80),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: 'Another branch',
                    isDense: true,
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(
                          child: Text("Another branch"), value: ""),
                      DropdownMenuItem(child: Text("Male"), value: "Male"),
                      DropdownMenuItem(child: Text("Female"), value: "Female"),
                    ],
                    onChanged: (newValue) {
                      setState(() {});
                    },
                  ),
                ),
              ),
            ),
            Divider(
              thickness: 3,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text('Product'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 250,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 0.80),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: 'Product',
                        isDense: true,
                        isExpanded: true,
                        items: [
                          DropdownMenuItem(child: Text("Product"), value: ""),
                          DropdownMenuItem(child: Text("Male"), value: "Male"),
                          DropdownMenuItem(
                              child: Text("Female"), value: "Female"),
                        ],
                        onChanged: (newValue) {
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.scanner_sharp),
                    tooltip: 'Scan product barcode',
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text('Quantity'),
            ),
            TextField(
              decoration: InputDecoration(
                suffixIcon: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 15),
                  ),
                  onPressed: () {},
                  child: const Text('MAX'),
                ),
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
          ],
        )
      ],
    );
  }
}
