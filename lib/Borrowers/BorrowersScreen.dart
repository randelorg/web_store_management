import 'package:flutter/material.dart';
import 'ViewBorrowerProfile.dart';

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
        ),
      ),
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

List _borrowerProfile(BuildContext context) {
  List<_Row> _profiles;

  return _profiles = List.generate(50, (index) {
    int tot = index + 1;
    return new _Row(
      tot.toString(),
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
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ViewBorrowerProfile();
                    });
              },
              child: const Text('VIEW'),
            ),
          ],
        ),
      ),
    );
  });
}

class _DataSource extends DataTableSource {
  _DataSource(this.context) {
    _borrowerProfile(context);
  }

  final BuildContext context;

  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _borrowerProfile(context).length) return null;
    final row = _borrowerProfile(context)[index];
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
  int get rowCount => _borrowerProfile(context).length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
