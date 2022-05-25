import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'PaymentPlan.dart';

class FinalizePage extends StatefulWidget {
  final String? action, firstname, lastname, mobile, address;
  final num? total;
  final int? id;
  final Uint8List contract;
  FinalizePage({
    this.action,
    this.id,
    required this.firstname,
    required this.lastname,
    required this.mobile,
    required this.address,
    this.total,
    required this.contract,
  });

  @override
  _FinalizePage createState() => _FinalizePage();
}

class _FinalizePage extends State<FinalizePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 5, left: 5, right: 5),
          child: Align(
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
        ),
        Center(
          child: Text(
            "Step 3",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 3),
          child: Center(
            child: Text(
              'FINALIZE',
              style: TextStyle(fontFamily: 'Cairo_Bold', fontSize: 30),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 2,
          child: PaginatedDataTable(
            showCheckboxColumn: false,
            rowsPerPage: 5,
            columns: [
              DataColumn(label: Text('PRODUCT NAME')),
              DataColumn(label: Text('PRICE')),
              DataColumn(label: Text(' ')),
              DataColumn(label: Text('QTY')),
              DataColumn(label: Text(' ')),
            ],
            source: _DataSource(context),
          ),
        ),
        Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red.shade700,
                            ),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(20.0),
                            primary: Colors.white,
                            textStyle: const TextStyle(fontSize: 18),
                          ),
                          child: const Text('CLEAR'),
                          onPressed: () {
                            Mapping.selectedProducts.clear();
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(20.0),
                              primary: Colors.white,
                              textStyle: const TextStyle(fontSize: 18),
                            ),
                            child: const Text('NEXT'),
                            onPressed: () {
                              Navigator.pop(context, true);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return PaymentPlanPage(
                                    action: widget.action,
                                    id: widget.id,
                                    firstname: widget.firstname.toString(),
                                    lastname: widget.lastname.toString(),
                                    mobile: widget.mobile.toString(),
                                    address: widget.address.toString(),
                                    total: _getTotal(),
                                    contract: widget.contract,
                                  );
                                },
                              );
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
        ),
      ],
    );
  }

  num _getTotal() {
    num balance = 0;
    num temp = 0;
    Mapping.selectedProducts.forEach((e) {
      //temp = e.getPrice * e.getProductQty;
      balance += temp;
    });
    return balance;
  }
}

class _Row {
  _Row(
    this.valueA,
    this.valueB,
    this.valueC,
    this.valueD,
    this.valueE,
  );

  final String valueA;
  final String valueB;
  final Widget valueC;
  String valueD;
  final Widget valueE;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context) {
    _selectedProducts = _finalizeProducts();
  }

  final BuildContext context;
  int _selectedCount = 0;
  List<_Row> _selectedProducts = [];

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _selectedProducts.length) return null;
    final row = _selectedProducts[index];
    return DataRow.byIndex(
      index: index,
      selected: row.selected,
      cells: [
        DataCell(Text(row.valueA)),
        DataCell(Text(row.valueB)),
        //add quantity
        DataCell((row.valueC), onTap: () {
          int qty = int.parse(row.valueD);

          //add to cart
          if (qty >= 0) {
            qty++;
            row.valueD = qty.toString();
            //Mapping.selectedProducts[index].setProductQty = qty;
            notifyListeners();
          }
        }),
        DataCell(Text(row.valueD)),
        //deduct quantity
        DataCell((row.valueE), onTap: () {
          int qty = int.parse(row.valueD);
          if (qty <= 1) return;

          //deduct from cart
          qty--;
          row.valueD = qty.toString();
          //Mapping.selectedProducts[index].setProductQty = qty;
          notifyListeners();
        }),
      ],
    );
  }

  @override
  int get rowCount => _selectedProducts.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  List<_Row> _finalizeProducts() {
    return List.generate(
      Mapping.selectedProducts.length,
      (index) {
        return new _Row(
          Mapping.selectedProducts[index].getProductName.toString(),
          // Mapping.selectedProducts[index].getPrice.toString(),
          30.toString(),
          Icon(Icons.add_circle, color: HexColor("#155293")),
          // Mapping.selectedProducts[index].getProductQty.toString(),
          4.toString(),
          Icon(Icons.remove_circle, color: HexColor("#EA1C24")),
        );
      },
    );
  }
}
