import 'package:flutter/material.dart';
import '../../Helpers/FilePicker_helper.dart';

import 'Finalize.dart';

class HomeNewLoan extends StatefulWidget {
  @override
  _HomeNewLoan createState() => _HomeNewLoan();
}

class _HomeNewLoan extends State<HomeNewLoan> {
  //classess
  var pick = Picker();
  //display selected file name
  String fileName = 'UPLOAD \n CONTRACT';
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: (MediaQuery.of(context).size.width) / 6,
          height: (MediaQuery.of(context).size.height),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Borrower Details",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Container(
                    child: Image.asset(
                      'assets/images/outline_qr_code_scanner_black.png',
                      fit: BoxFit.fill,
                      width: 150,
                      height: 150,
                    ),
                  ),
                ),
                TextButton.icon(
                  icon: Icon(
                    Icons.print,
                    size: 15,
                  ),
                  label: Text(
                    'Print QR',
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      fontSize: 10,
                    ),
                  ),
                  onPressed: () {}, //pwdeng refresh button
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 5.0, right: 5, left: 5),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Firstname',
                      filled: true,
                      fillColor: Colors.blueGrey[50],
                      labelStyle: TextStyle(fontSize: 10),
                      contentPadding: EdgeInsets.only(left: 30),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey.shade50),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey.shade50),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Lastname',
                      filled: true,
                      fillColor: Colors.blueGrey[50],
                      labelStyle: TextStyle(fontSize: 10),
                      contentPadding: EdgeInsets.only(left: 30),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey.shade50),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey.shade50),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Mobile number',
                      filled: true,
                      fillColor: Colors.blueGrey[50],
                      labelStyle: TextStyle(fontSize: 10),
                      contentPadding: EdgeInsets.only(left: 30),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey.shade50),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey.shade50),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Home address',
                      filled: true,
                      fillColor: Colors.blueGrey[50],
                      labelStyle: TextStyle(fontSize: 10),
                      contentPadding: EdgeInsets.only(left: 30),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey.shade50),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey.shade50),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.blue.shade400,
                    ),
                    onPressed: () {
                      pick.pickFile().then((value) {
                        setState(() {
                          fileName = value;
                        });
                      });
                    },
                    child: Text(
                      fileName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                //buttons
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.blue.shade400,
                    ),
                    onPressed: () {},
                    child: const Text(
                      'SAVE',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: (MediaQuery.of(context).size.width) / 2.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  "SELECT PRODUCTS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 300,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Product',
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
                ],
              ),
              Expanded(
                child: Container(
                  width: (MediaQuery.of(context).size.width) / 2.5,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      PaginatedDataTable(
                        showCheckboxColumn: false,
                        rowsPerPage: 14,
                        columns: [
                          DataColumn(label: Text('PRODUCT NAME')),
                          DataColumn(label: Text('PRICE')),
                          DataColumn(label: Text('ACTION')),
                        ],
                        source: _SelectionOfProducts(context),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: (MediaQuery.of(context).size.width) / 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "SELECTED PRODUCTS",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: (MediaQuery.of(context).size.width) / 5,
                child: PaginatedDataTable(
                  showCheckboxColumn: false,
                  rowsPerPage: 6,
                  columns: [
                    DataColumn(label: Text('#')),
                    DataColumn(label: Text('PRICE')),
                  ],
                  source: _SelectedProducts(context),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 120,
                    height: 60,
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
                              padding: const EdgeInsets.all(25.0),
                              primary: Colors.white,
                              textStyle: const TextStyle(fontSize: 25),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return SimpleDialog(
                                    children: [
                                      Container(
                                        width: (MediaQuery.of(context)
                                                .size
                                                .width) /
                                            2,
                                        height: 500,
                                        child: Finalize(),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Text('NEXT'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//selection of products
class _RowSelectProducts {
  _RowSelectProducts(
    this.valueA,
    this.valueB,
    this.valueC,
  );

  final String valueA;
  final String valueB;
  final Widget valueC;

  bool selected = false;
}

class _SelectionOfProducts extends DataTableSource {
  _SelectionOfProducts(this.context) {
    _selectionProducts(context);
  }

  final BuildContext context;

  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _selectionProducts(context).length) return null;
    final row = _selectionProducts(context)[index];
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
        DataCell(Text(row.valueB)),
        DataCell((row.valueC)),
      ],
    );
  }

  @override
  int get rowCount => _selectionProducts(context).length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

List _selectionProducts(BuildContext context) {
  List<_RowSelectProducts> _selectionProducts;

  return _selectionProducts = List.generate(
    50,
    (index) {
      return new _RowSelectProducts(
        'Product A',
        'CellB2',
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
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
                  padding: const EdgeInsets.all(12.0),
                  primary: Colors.white,
                  textStyle: const TextStyle(fontSize: 10),
                ),
                onPressed: () {},
                child: const Text('SELECT'),
              ),
            ],
          ),
        ),
      );
    },
  );
}

// selected products
class _RowSelectedProducts {
  _RowSelectedProducts(
    this.valueA,
    this.valueB,
  );

  final String valueA;
  final String valueB;

  bool selected = false;
}

class _SelectedProducts extends DataTableSource {
  _SelectedProducts(this.context) {
    _selectedProducts(context);
  }

  final BuildContext context;

  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _selectedProducts(context).length) return null;
    final row = _selectedProducts(context)[index];
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
        DataCell(Text(row.valueB)),
      ],
    );
  }

  @override
  int get rowCount => _selectedProducts(context).length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

List _selectedProducts(BuildContext context) {
  List<_RowSelectedProducts> _selectedProducts;

  return _selectedProducts = List.generate(5, (index) {
    int tot = index + 1;
    return new _RowSelectedProducts(
      tot.toString(),
      'CellB2',
    );
  });
}
