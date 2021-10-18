import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';

import 'package:web_store_management/Inventory/TransferStock.dart';
import 'UpdateProduct.dart';

class InventoryScreen extends StatefulWidget {
  @override
  _InventoryScreen createState() => _InventoryScreen();
}

class _InventoryScreen extends State<InventoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: (MediaQuery.of(context).size.width) / 5,
          height: (MediaQuery.of(context).size.height) / 2,
          child: Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Add Product',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.blue.shade900,
                        overflow: TextOverflow.fade),
                    maxLines: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Product Name',
                      filled: true,
                      fillColor: Colors.blueGrey[50],
                      labelStyle: TextStyle(fontSize: 12),
                      contentPadding: EdgeInsets.only(left: 30),
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
                  padding: const EdgeInsets.all(6.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Quantity',
                      filled: true,
                      fillColor: Colors.blueGrey[50],
                      labelStyle: TextStyle(fontSize: 12),
                      contentPadding: EdgeInsets.only(left: 30),
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
                  padding: const EdgeInsets.all(6.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Price',
                      filled: true,
                      fillColor: Colors.blueGrey[50],
                      labelStyle: TextStyle(fontSize: 12),
                      contentPadding: EdgeInsets.only(left: 30),
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
                  padding: const EdgeInsets.all(6.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Unit',
                      filled: true,
                      fillColor: Colors.blueGrey[50],
                      labelStyle: TextStyle(fontSize: 12),
                      contentPadding: EdgeInsets.only(left: 30),
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
                    borderRadius: BorderRadius.circular(10),
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
                            padding: const EdgeInsets.all(20),
                            primary: Colors.white,
                            textStyle: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {},
                          child: const Text('ADD'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade50,
                          ),
                        ),
                      ),
                      Tooltip(
                        message: 'Transfer Stocks',
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(20),
                            primary: Colors.black,
                            textStyle: TextStyle(fontSize: 18),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return TransferStock();
                                });
                          },
                          child: const Text('TRANSFER'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                padding: EdgeInsets.only(top: 10, right: 60),
                width: (MediaQuery.of(context).size.width) / 5,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search product',
                    suffixIcon: InkWell(
                      child: IconButton(
                        icon: Icon(Icons.search_sharp),
                        color: Colors.grey,
                        tooltip: 'Search by Name',
                        onPressed: () {},
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.blueGrey[50],
                    labelStyle: TextStyle(fontSize: 12),
                    contentPadding: EdgeInsets.only(left: 30),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade50),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade50),
                    ),
                  ),
                ),
              ),
            ]),
            Container(
              width: (MediaQuery.of(context).size.width) / 1.5,
              height: (MediaQuery.of(context).size.height) / 1.3,
              child: ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  PaginatedDataTable(
                    showCheckboxColumn: false,
                    rowsPerPage: 10,
                    columns: [
                      DataColumn(label: Text('PRODUCT NAME')),
                      DataColumn(label: Text('QTY')),
                      DataColumn(label: Text('PRICE')),
                      DataColumn(label: Text('ACTION')),
                    ],
                    source: _DataSource(context),
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}

class _Row {
  _Row(
    this.valueA,
    this.valueB,
    this.valueC,
    this.valueD,
  );

  final String valueA;
  final Widget valueB;
  final String valueC;
  final Widget valueD;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context) {
    _productList(context);
  }

  final BuildContext context;
  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _productList(context).length) return null;
    final row = _productList(context)[index];
    return DataRow.byIndex(
      index: index,
      selected: row.selected,
      onSelectChanged: (value) {
        if (row.selected != value) {
          var value = false;
          _selectedCount += value ? 1 : -1;
          assert(_selectedCount >= 0);
          row.selected = value;
          notifyListeners();
        }
      },
      cells: [
        DataCell(Text(row.valueA)),
        DataCell((row.valueB)),
        DataCell(Text(row.valueC)),
        DataCell((row.valueD)),
      ],
    );
  }

  @override
  int get rowCount => _productList(context).length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

//this will identify if stock is <= 2
//if it reacher 2 stock this will return an icon
//else it will return the stock number
Widget _dangerStock(String stuff) {
  if (int.parse(stuff) > 2) {
    return _parseString(stuff);
  } else {
    return Icon(Icons.warning, color: Colors.red);
  }
}

//this will parse the string and convert
//it to Text Widget
Widget _parseString(String stuff) {
  return Text(stuff);
}

List _productList(BuildContext context) {
  List<_Row> _products;

  return _products = List.generate(50, (index) {
    Random random = new Random();
    int randomQty = random.nextInt(10) + 1;
    double randomPrice = random.nextDouble() + 2000.00;

    return _Row(
      'CellB1',
      _dangerStock(randomQty.toString()),
      double.parse(randomPrice.toStringAsFixed(2)).toString(),
      ClipRRect(
        borderRadius: BorderRadius.circular(6),
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
                padding: const EdgeInsets.all(16.0),
                primary: Colors.white,
                textStyle: const TextStyle(fontSize: 15),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return UpdateProduct();
                    });
              },
              child: const Text('UPDATE'),
            ),
          ],
        ),
      ),
    );
  });
}
