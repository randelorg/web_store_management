import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Backend/GlobalController.dart';
import 'package:web_store_management/Backend/HistoryOperation.dart';
import 'package:web_store_management/Models/BorrowerModel.dart';
import 'package:web_store_management/Pages/Reports/GlobalHistoryScreens/PaymentHistoryScreen.dart';
import 'package:web_store_management/Pages/Reports/GlobalHistoryScreens/ProductHistoryScreen.dart';
import '../../Backend/Utility/Mapping.dart';

class HistoryScreen extends StatefulWidget {
  final Function? onUpdate;
  final String? id, name;
  HistoryScreen({this.onUpdate, this.id, this.name});

  @override
  _HistoryScreen createState() => _HistoryScreen();
}

class _HistoryScreen extends State<HistoryScreen> {
  var controller = GlobalController();
  var history = HistoryOperation();
  var _sortAscending = true;
  late Future<List<BorrowerModel>> borrowers;

  @override
  void initState() {
    super.initState();
    //fetches the borrowers from the database
    borrowers = controller.fetchBorrowers();
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: (MediaQuery.of(context).size.width) / 1.2,
            height: (MediaQuery.of(context).size.height),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: EdgeInsets.only(left: 25, right: 5),
                    width: 350,                
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Borrower',
                        filled: true,
                        fillColor: Colors.blueGrey[50],
                        labelStyle: TextStyle(fontSize: 12),
                        contentPadding: EdgeInsets.only(left: 15),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey.shade50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey.shade50),
                        ),
                      ),
                    ),
                  ),
                ),
                FutureBuilder<List<BorrowerModel>>(
                  future: borrowers,
                  builder: ((context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasData) {
                      return tableBorrowers(
                        snapshot.data ?? [],
                        _sortAscending,
                      );
                    } else {
                      return Center(child: Text('No Borrowers'));
                    }
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget tableBorrowers(List<BorrowerModel> borrowers, bool sortAscending) {
    return PaginatedDataTable(
      showCheckboxColumn: false,
      showFirstLastButtons: true,
      sortAscending: sortAscending,
      sortColumnIndex: 1,
      rowsPerPage: 12,
      columns: [
        DataColumn(label: Text('BID')),
        DataColumn(
          label: Text('BORROWER NAME'),
          onSort: (index, sortAscending) {
            setState(() {
              _sortAscending = sortAscending;
              if (sortAscending) {
                borrowers.sort((a, b) => a.toString().compareTo(b.toString()));
              } else {
                borrowers.sort((a, b) => b.toString().compareTo(a.toString()));
              }
            });
          },
        ),
        DataColumn(label: Text('PAYMENT HISTORY')),
        DataColumn(label: Text('LOANED PRODUCT HISTORY')),
      ],
      source: _DataSource(context),
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
  final String valueB;
  final Widget valueC;
  final Widget valueD;

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
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width) / 2,
                    height: (MediaQuery.of(context).size.height),
                    child: LocalPaymentHistory(
                      id: row.valueA,
                      borrowerName: row.valueB,
                    ),
                  ),
                ],
              );
            },
          );
        }),
        DataCell((row.valueD), onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width) / 2,
                    height: (MediaQuery.of(context).size.height),
                    child: ProductHistory(
                      borrowerId: row.valueA,
                      borrowerName: row.valueB,
                    ),
                  ),
                ],
              );
            },
          );
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
              Icons.payments,
              color: HexColor("#155293"),
              size: 25,
            ),
            Icon(
              Icons.inventory,
              color: HexColor("#155293"),
              size: 25,
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
            Text(''),
          );
        },
      );
    }
  }
}
