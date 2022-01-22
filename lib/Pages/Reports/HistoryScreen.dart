import 'package:flutter/material.dart';
import 'package:web_store_management/Backend/GlobalController.dart';
import 'package:web_store_management/Backend/HistoryOperation.dart';

import 'HistoryScreens/PaymentHistoryScreen.dart';
import 'HistoryScreens/ProductHistoryScreen.dart';
import '../../Backend/Utility/Mapping.dart';

class HistoryScreen extends StatefulWidget {
  final Function? onUpdate;
  HistoryScreen({this.onUpdate});

  @override
  _HistoryScreen createState() => _HistoryScreen();
}

class _HistoryScreen extends State<HistoryScreen> {
  var controller = GlobalController();

  @override
  void initState() {
    super.initState();
    //fetches the borrowers from the database
    controller.fetchBorrowers();
  }

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
                    DataColumn(label: Icon(Icons.visibility)),
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
  var history = HistoryOperation();

  _DataSource(this.context) {
    _borrowersList();
  }

  final BuildContext context;

  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _borrowersList().length) return null;
    final row = _borrowersList()[index];
    return DataRow.byIndex(
      index: index,
      selected: row.selected,
      cells: [
        DataCell(Text(row.valueA)),
        DataCell(Text(row.valueB)),
        DataCell((row.valueC), onTap: () {
          Mapping.borrowerId = row.valueA;
        }),
      ],
    );
  }

  @override
  int get rowCount => _borrowersList().length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  List _borrowersList() {
    try {
      return List.generate(
        Mapping.borrowerList.length,
        (index) {
          return _Row(
            Mapping.borrowerList[index].getBorrowerId.toString(),
            Mapping.borrowerList[index].toString(),
            Icon(
              Icons.history,
              color: Colors.blue,
              size: 30,
            ),
          );
        },
      );
    } catch (e) {
      //if list borrowers is empty
      return List.generate(
        0,
        (index) {
          return new _Row(
            "",
            "",
            Text(''),
          );
        },
      );
    }
  }
}
