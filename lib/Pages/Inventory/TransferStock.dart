import 'package:camcode/cam_code_scanner.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Backend/BranchOperation.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Notification/Snack_notification.dart';

class TransferStock extends StatefulWidget {
  final List<String>? branches;
  final String? productName;
  final Widget? qty;
  TransferStock({required this.branches, this.productName, this.qty});
  @override
  _TransferStock createState() => _TransferStock();
}

class _TransferStock extends State<TransferStock> {
  String originStore = 'One';
  String destinationBranch = 'One';

  final TextEditingController productName = TextEditingController();
  final TextEditingController maxqty = TextEditingController();
  final TextEditingController qty = TextEditingController();

  var transfer = BranchOperation();

  @override
  void initState() {
    setState(() {
      originStore = widget.branches![0].toString();
      destinationBranch = originStore;
      productName.text = widget.productName.toString();
      maxqty.text = widget.qty.toString();
    });
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
              padding: EdgeInsets.only(top: 20, left: 3),
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
                        items: widget.branches!
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(         
                              padding: EdgeInsets.only(left: 10),
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
                        items: widget.branches!
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(         
                              padding: EdgeInsets.only(left: 10),
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
                ),
              ],
            ),
           
            Padding(
              padding: EdgeInsets.only(left: 3),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Product Name',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: TextField(
                controller: productName,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.scanner_sharp),
                    tooltip: 'Scan product barcode',
                    onPressed: () {
                      try {
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
                      } catch (e) {
                        print('Error');
                      }
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
                      child: Text(maxqty.text), //make this a bold font and
                      //change size to a smaller size
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text(' available'), //make this a lighther font and
                      //change size to a smaller size
                    ),
                  ],
                ),
              ],
            ),
            TextField(
              controller: qty,
              decoration: InputDecoration(
                suffixIcon: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: TextStyle(fontSize: 15),
                  ),
                  child: Text(
                    'MAX',
                    style: TextStyle(fontSize: 15, color: HexColor("#155293")),
                  ),
                  onPressed: () {
                    setState(() {
                      qty.text = maxqty.text;
                    });
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
                          child: const Text('CONFIRM'),
                          onPressed: () {
                            transfer
                                .transferStock(
                              _findProdBarcode(productName.text),
                              int.parse(qty.text),
                              _findBranchCode(destinationBranch),
                            )
                                .then((value) {
                              if (value) {
                                Navigator.pop(context);
                                SnackNotification.notif(
                                  'Success',
                                  "Product ${productName.text} is transfered",
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
            ),
          ],
        )
      ],
    );
  }

  String _findBranchCode(String destination) {
    String code = '';
    Mapping.branchList
        .where((element) =>
            element.branchName?.toLowerCase() == destination.toLowerCase())
        .forEach((element) {
      code = element.branchCode;
    });
    return code;
  }

  String _findProdBarcode(String productName) {
    String name = '';
    Mapping.productList
        .where((element) =>
            element.productName?.toLowerCase() == productName.toLowerCase())
        .forEach((element) {
      name = element.getProductCode;
    });
    return name;
  }
}
