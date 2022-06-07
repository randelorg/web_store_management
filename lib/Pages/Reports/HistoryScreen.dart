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
  List<BorrowerModel> _borrowerFiltered = [];

  var searchValue = TextEditingController();
  String _searchResult = '';

  @override
  void initState() {
    super.initState();
    //fetches the borrowers from the database
    borrowers = controller.fetchBorrowers();
    borrowers.whenComplete(() => _borrowerFiltered = Mapping.borrowerList);
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
                FutureBuilder<List<BorrowerModel>>(
                  future: borrowers,
                  builder: ((context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasData) {
                      return tableBorrowers(_borrowerFiltered, _sortAscending);
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
      header: Text('Borrower List', 
      style: TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontFamily: 'Cairo_Bold'),
      ),                  
      actions: [
        Container(
            padding: EdgeInsets.only(left: 25, right: 5),
            width: 300,
            child: TextField(
              controller: searchValue,
              onChanged: (value) {
                setState(() {
                  _searchResult = value;
                  _borrowerFiltered = Mapping.borrowerList
                      .where((brw) => brw
                          .toString()
                          .toLowerCase()
                          .contains(_searchResult.toLowerCase()))
                      .toList();
                });
              },
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
      ],
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
      source: _DataSource(context, _borrowerFiltered),
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

  _DataSource(this.context, this.brw) {
    brw = brw;
    _borrowersList(brw);
  }

  final BuildContext context;
  List<BorrowerModel> brw = [];

  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _borrowersList(brw).length) return null;
    final row = _borrowersList(brw)[index];
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
  int get rowCount => _borrowersList(brw).length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  List _borrowersList(List<BorrowerModel> brw) {
    try {
      return List.generate(
        brw.length,
        (index) {
          return _Row(
            brw[index].getBorrowerId.toString(),
            brw[index].toString(),
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
