import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:web_store_management/Backend/PurchasesOperation.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Models/IncomingPurchasesModel.dart';
import 'package:web_store_management/Notification/BannerNotif.dart';

class ReceiveOrders extends StatefulWidget {
  final String? supplierBarcode;
  final int? qty;
  ReceiveOrders({required this.supplierBarcode, required this.qty});

  @override
  _ReceiveOrders createState() => _ReceiveOrders();
}

class _ReceiveOrders extends State<ReceiveOrders> {
  var purchase = PurchasesOperation();
  var itemCode = TextEditingController();
  var dateinput = TextEditingController();
  var description = TextEditingController();
  int qtyToReceive = 0, recieved = 0, count = 0;
  final int max = 999999, min = 100000;
  late Future<List<IncomingPurchasesModel>> _recieveOrders;

  int random(min, max) {
    return min + Random().nextInt(max - min);
  }

  @override
  void initState() {
    dateinput.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    qtyToReceive = widget.qty!.toInt();
    itemCode.text = "${random(min, max)}-${widget.supplierBarcode}";
    _recieveOrders = Future.value([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
          'Receive orders from product code ${widget.supplierBarcode.toString()}'),
      content: Container(
        width: (MediaQuery.of(context).size.width) / 2,
        height: (MediaQuery.of(context).size.height) / 1.5,
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Column(
                  children: [
                    const Text('Enter item code here'),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 400,
                        child: Padding(
                          //scan barcode or manually enter barcode
                          padding: EdgeInsets.all(6),
                          child: TextField(
                            controller: itemCode,
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: 'Enter item code  Here',
                              filled: true,
                              fillColor: Colors.blueGrey[50],
                              labelStyle: TextStyle(fontSize: 10),
                              contentPadding: EdgeInsets.only(left: 15),
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
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text('Received Date'),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 200,
                        child: Padding(
                          //scan barcode or manually enter barcode
                          padding: EdgeInsets.all(6),
                          child: TextField(
                            controller: dateinput,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(fontSize: 12),
                              contentPadding: EdgeInsets.only(left: 15),
                              filled: true,
                              hintText: 'Recived Date',
                              fillColor: Colors.blueGrey[50],
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
                                          primary:
                                              Colors.black, //Button Text Color
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('dd-MM-yyyy').format(pickedDate);
                                setState(() {
                                  dateinput.text = formattedDate;
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                      Padding(
                        padding: EdgeInsets.only(
                            top: 8, bottom: 8, left: 16, right: 16),
                        child: TextButton(
                          child: Text(
                            'ADD',
                            style: TextStyle(
                              fontFamily: 'Cairo_SemiBold',
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            _recieveOrders = purchase.addToReceiveTable(
                              itemCode.text,
                              widget.supplierBarcode.toString(),
                              description.text,
                            );

                            _recieveOrders.whenComplete(() {
                              setState(() {
                                description.clear();
                                //refresh table
                                _recieveOrders = _recieveOrders;

                                recieved += 1;
                                qtyToReceive -= 1;

                                //reset the item code
                                itemCode.text =
                                    "${random(min, max)}-${widget.supplierBarcode}";
                              });
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              //scan barcode or manually enter barcode
              padding: EdgeInsets.all(6),
              child: TextField(
                controller: description,
                decoration: InputDecoration(
                  hintText: 'Description',
                  filled: true,
                  fillColor: Colors.blueGrey[50],
                  labelStyle: TextStyle(fontSize: 10),
                  contentPadding: EdgeInsets.only(left: 15),
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
            _tablePurchases(),
          ],
        ),
      ),
    );
  }

  Widget _tablePurchases() {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: (MediaQuery.of(context).size.width) / 2,
          height: (MediaQuery.of(context).size.height),
          child: ListView(
            children: [
              FutureBuilder<List<IncomingPurchasesModel>>(
                future: _recieveOrders,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        semanticsLabel: 'Fetching purchases products',
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    return PaginatedDataTable(
                      actions: [
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
                                        right: 36),
                                    primary: Colors.white,
                                    textStyle: TextStyle(
                                      fontFamily: 'Cairo_SemiBold',
                                      fontSize: 14,
                                    ),
                                  ),
                                  child: const Text('Receive Items'),
                                  onPressed: () async {
                                    //TODO: ADD TO PURCHASE ORDER HERE O THE DB
                                    purchase.receivedItems().then((value) {
                                      BannerNotif.notif(
                                        'Success',
                                        'Item Added',
                                        Colors.green.shade200,
                                      );
                                      Mapping.purchases.clear();
                                      Mapping.receiverOrders.clear();
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
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
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 8, bottom: 8, left: 16, right: 16),
                                child: TextButton(
                                  child: Text(
                                    'CANCEL',
                                    style: TextStyle(
                                      fontFamily: 'Cairo_SemiBold',
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () async {
                                    Mapping.receiverOrders.clear();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      header: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child: Text('Number to be receive: $qtyToReceive'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child: Text('Number received: $recieved'),
                          ),
                        ],
                      ),
                      showCheckboxColumn: false,
                      showFirstLastButtons: true,
                      sortColumnIndex: 1,
                      rowsPerPage: 5,
                      columns: [
                        DataColumn(label: Text('Item Code')),
                        DataColumn(label: Text('Description')),
                      ],
                      source: _DataSource(context),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      semanticsLabel: 'Fetching products',
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Row {
  _Row(
    this.valueA,
    this.valueB,
  );

  final String valueA;
  final String valueB;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context) {
    _payHistory = _orders();
  }

  final BuildContext context;

  int _selectedCount = 0;
  List<_Row> _payHistory = [];

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _payHistory.length) return null;
    final row = _payHistory[index];
    return DataRow.byIndex(
      index: index,
      selected: row.selected,
      cells: [
        DataCell(Text(row.valueA)),
        DataCell(Text(row.valueB)),
      ],
    );
  }

  @override
  int get rowCount => _payHistory.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  List<_Row> _orders() {
    try {
      return List.generate(
        Mapping.receiverOrders.length,
        (index) {
          return _Row(
            Mapping.receiverOrders[index].getProductItemCode,
            Mapping.receiverOrders[index].getRemarks,
          );
        },
      );
    } catch (e) {
      return List.generate(
        0,
        (index) {
          return _Row(
            '',
            '',
          );
        },
      );
    }
  }
}
