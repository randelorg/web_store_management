import 'package:flutter/material.dart';

import 'HistoryScreens/PaymentHistoryScreen.dart';
import 'HistoryScreens/ProductHistoryScreen.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreen createState() => _HistoryScreen();
}

class _HistoryScreen extends State<HistoryScreen> {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Payment History'),
    Tab(text: 'Product Loaned History'),
  ];

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Container(
            width: (MediaQuery.of(context).size.width) / 4,
            height: (MediaQuery.of(context).size.height),
            child: ListView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.only(bottom: 15),
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  width: (MediaQuery.of(context).size.width) / 4,
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
                PaginatedDataTable(
                  showCheckboxColumn: false,
                  rowsPerPage: 10,
                  columns: [
                    DataColumn(label: Text('BID')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('ACTION')),
                  ],
                  source: _DataSource(context),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: (MediaQuery.of(context).size.width),
              height: (MediaQuery.of(context).size.height),
              child: DefaultTabController(
                length: myTabs.length,
                child: Scaffold(
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(50),
                    child: AppBar(
                      bottom: TabBar(
                        tabs: myTabs,
                      ),
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      Center(child: PaymentHistory()),
                      Center(child: ProductHistory()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Row {
  _Row(
    this.valueA,
    this.valueB,
    this.valueC,
  );

  final String valueA;
  final String valueB;
  final Widget valueC;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context) {
    _Borrowers(context);
  }

  final BuildContext context;

  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _Borrowers(context).length) return null;
    final row = _Borrowers(context)[index];
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
  int get rowCount => _Borrowers(context).length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

List _Borrowers(BuildContext context) {
  List<_Row> _Borrowers;

  return _Borrowers = List.generate(
    50,
    (index) {
      return _Row(
        '1',
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
                  // showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return ViewBorrowerProfile();
                  //   },
                  // );
                },
                child: const Text('SELECT'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
