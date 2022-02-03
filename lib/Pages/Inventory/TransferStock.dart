import 'package:camcode/cam_code_scanner.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';

class TransferStock extends StatefulWidget {
  @override
  _TransferStock createState() => _TransferStock();
}

class _TransferStock extends State<TransferStock> {
  List<String> fromLocation = [];
  List<String> toLocation = [];

  String originStore = 'One';
  String destinationBranch = 'One';

  @override
  void initState() {
    super.initState();
    //fill the locations
    getLocations();
  }

  void getLocations() {
    Mapping.branchList.forEach((element) {
      fromLocation.add(element.branchName);
    });
    toLocation.addAll(fromLocation);

    originStore = fromLocation[0];
    destinationBranch = toLocation[0];
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
              'Transfer Stock',
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: HexColor("#155293"),
                fontFamily: 'Cairo_Bold',
                fontSize: 30,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 25, bottom: 10),
              child: Container(
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Transfer Products to Another Branch.',
                    style: TextStyle(
                      fontFamily: 'Cairo_SemiBold',
                      fontSize: 16,
                      color: HexColor("#155293"),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 3),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'From',
                  style: TextStyle(fontSize: 10),
                ),
              ),
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
                        width: 0.80,
                      ),
                    ),
                    alignment: Alignment.topLeft,
                    width: 300,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: originStore,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: HexColor("#155293")),
                        onChanged: (String? newValue) {
                          setState(() {
                            originStore = newValue!;
                          });
                        },
                        items: fromLocation
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
            Padding(
              padding: EdgeInsets.only(left: 3),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'To',
                  style: TextStyle(fontSize: 10),
                ),
              ),
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
                        value: destinationBranch,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: HexColor("#155293")),
                        onChanged: (String? newValue) {
                          setState(() {
                            destinationBranch = newValue!;
                          });
                        },
                        items: toLocation
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
              padding: EdgeInsets.only(left: 3),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Product',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: TextField(
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.scanner_sharp),
                    tooltip: 'Scan product barcode',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => CamCodeScanner(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          refreshDelayMillis: 200,
                          onBarcodeResult: (barcode) {
                            print('object ' + barcode.toString());
                          },
                        ),
                      );
                    },
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
                Padding(
                  padding: EdgeInsets.only(left: 3),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Quantity',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
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
                    textStyle: TextStyle(fontSize: 15),
                  ),
                  onPressed: () {},
                  child: Text(
                    'MAX',
                    style: TextStyle(fontSize: 15, color: HexColor("#155293")),
                  ),
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
