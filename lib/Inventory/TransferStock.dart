import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TransferStock extends StatefulWidget {
  @override
  _TransferStock createState() => _TransferStock();
}

class _TransferStock extends State<TransferStock> {
  String originStore = 'One';
  String anotherBranch = 'One';
  String productName = 'One';
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
                  child: Text('Transfer products to another branch.'),
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text('From'),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[50],
                      border: Border.all(
                          color: Colors.blueGrey.shade50,
                          style: BorderStyle.solid,
                          width: 0.80),
                    ),
                    alignment: Alignment.topLeft,
                    width: 300,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: originStore,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.blue.shade700),
                        onChanged: (String? newValue) {
                          setState(() {
                            originStore = newValue!;
                          });
                        },
                        items: <String>['One', 'Two', 'Free', 'Four']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text('To'),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Container(
                    width: 300,
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[50],
                      border: Border.all(
                          color: Colors.blueGrey.shade50,
                          style: BorderStyle.solid,
                          width: 0.80),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: anotherBranch,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.blue.shade700),
                        onChanged: (String? newValue) {
                          setState(() {
                            anotherBranch = newValue!;
                          });
                        },
                        items: <String>['One', 'Two', 'Free', 'Four']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
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
              child: TextField(
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.scanner_sharp),
                    tooltip: 'Scan product barcode',
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
            ),
            Stack(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text('Quantity'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      child: Text('238'), //make this a bold font and
                      //change size to a smaller size
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child:
                          Text('  available'), //make this a lighther font and
                      //change size to a smaller size
                    ),
                  ],
                ),
              ],
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.blue,
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
                          onPressed: () {},
                          child: const Text('CONFIRM'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
