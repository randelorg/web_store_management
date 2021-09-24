import 'package:flutter/material.dart';

class BorrowersScreen extends StatefulWidget {
  @override
  _BorrowersScreen createState() => _BorrowersScreen();
}

class _BorrowersScreen extends State<BorrowersScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.only(top: 50, right: 20),
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
        ],
      ),
      Container(
          width: (MediaQuery.of(context).size.width),
          height: (MediaQuery.of(context).size.height) / 1.5,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              PaginatedDataTable(
                showCheckboxColumn: false,
                rowsPerPage: 10,
                columns: [
                  DataColumn(label: Text('BID')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Number')),
                  DataColumn(label: Text('Balance')),
                  DataColumn(label: Text('Action')),
                ],
                source: _DataSource(context),
              )
            ],
          ))
    ]);
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
  final String valueD;
  final Widget valueE;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context) {
    _rows;
  }

  final BuildContext context;
  List<_Row> _rows = List.generate(50, (index) {
    return _Row(
      'Cell A2',
      'CellB2',
      'CellC2',
      "CellC1",
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
              onPressed: () {},
              child: const Text('VIEW'),
            ),
          ],
        ),
      ),
    );
  });

  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return null;
    final row = _rows[index];
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
        DataCell(Text(row.valueD)),
        DataCell((row.valueE)),
      ],
    );
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
