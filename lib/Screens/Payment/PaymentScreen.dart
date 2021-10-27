import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'MakePayment.dart';
import '../Borrowers/ViewBorrowerProfile.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreen createState() => _PaymentScreen();
}

class _PaymentScreen extends State<PaymentScreen> {
  int _currentSortColumn = 0;
  bool _isAscending = true;

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.only(top: 15, bottom: 15, right: 100),
              alignment: Alignment.topLeft,
              width: (MediaQuery.of(context).size.width) / 4.5,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search borrower',
                  suffixIcon: InkWell(
                    child: IconButton(
                      icon: Icon(Icons.qr_code_scanner_outlined),
                      color: Colors.grey,
                      tooltip: 'Search by QR',
                      onPressed: () {},
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.blueGrey[50],
                  labelStyle: TextStyle(fontSize: 10),
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
          ],
        ),
        Expanded(
          child: Container(
            width: (MediaQuery.of(context).size.width),
            height: (MediaQuery.of(context).size.height),
            child: ListView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.only(bottom: 15, right: 100, left: 100),
              children: [
                PaginatedDataTable(
                  sortColumnIndex: _currentSortColumn,
                  sortAscending: _isAscending,
                  showCheckboxColumn: false,
                  rowsPerPage: 15,
                  columns: [
                    DataColumn(
                      label: Text('BID'),
                      // SORTING **** FIX THE LIST METHOD
                      // onSort: (columnIndex, _) {
                      //   setState(() {
                      //     _currentSortColumn = columnIndex;
                      //     if (_isAscending == true) {
                      //       _isAscending = false;
                      //       // sort the product list in Ascending, order by Price
                      //       _payments.sort((productA, productB) =>
                      //           productB['price'].compareTo(productA['price']));
                      //     } else {
                      //       _isAscending = true;
                      //       // sort the product list in Descending, order by Price
                      //       _payments.sort((productA, productB) =>
                      //           productA['price'].compareTo(productB['price']));
                      //     }
                      //   });
                      // }
                    ),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('TOTAL DEBT')),
                    DataColumn(label: Text('PAYMENT')),
                    DataColumn(label: Text('VIEW')),
                  ],
                  source: _DataSource(context),
                ),
              ],
            ),
          ),
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
    this.valueE,
  );

  final String valueA;
  final String valueB;
  final String valueC;
  final Widget valueD;
  final Widget valueE;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context) {
    _paymentsList(context);
  }

  final BuildContext context;

  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _paymentsList(context).length) return null;
    final row = _paymentsList(context)[index];
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
        DataCell(Text(row.valueC)),
        DataCell((row.valueD)),
        DataCell((row.valueE)),
      ],
    );
  }

  @override
  int get rowCount => _paymentsList(context).length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

List _paymentsList(BuildContext context) {
  List<_Row> _payments;

  return _payments = List.generate(50, (index) {
    int tot = index + 1;

    return _Row(
      tot.toString(),
      'CellB2',
      'CellC2',
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
                    return MakePayment();
                  },
                );
              },
              child: const Text('PAY'),
            ),
          ],
        ),
      ),
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
                    return ViewBorrowerProfile();
                  },
                );
              },
              child: const Text('VIEW'),
            ),
          ],
        ),
      ),
    );
  });
}
