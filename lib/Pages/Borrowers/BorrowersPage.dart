import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';
import 'package:web_store_management/Models/BorrowerModel.dart';
import 'package:web_store_management/Pages/Borrowers/ViewBrwProfile.dart';
import 'package:web_store_management/Pages/Payment/MakePayment.dart';
import '../../Backend/Utility/Mapping.dart';
import '../../Backend/GlobalController.dart';

class BorrowersPage extends StatefulWidget {
  @override
  _BorrowersPage createState() => _BorrowersPage();
}

class _BorrowersPage extends State<BorrowersPage> {
  var controller = GlobalController();
  late Future<List<BorrowerModel>> borrowers;
  List<BorrowerModel> _borrowerFiltered = [];
  TextEditingController searchValue = TextEditingController();
  String _searchResult = '';
  var _sortAscending = true;

  @override
  void initState() {
    borrowers = controller.fetchBorrowers();

    //fill the list with all the borrowers
    //to have a init state of filled table
    borrowers.whenComplete(() => _borrowerFiltered = Mapping.borrowerList);

    super.initState();
  }

  @override
  void dispose() {
    searchValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 20, top: 10),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: const Text(
                  'Borrowers',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontFamily: 'Cairo_Bold',
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            width: (MediaQuery.of(context).size.width),
            height: (MediaQuery.of(context).size.height),
            child: FutureBuilder<List<BorrowerModel>>(
              future: borrowers,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      semanticsLabel: 'Fetching borrowers',
                    ),
                  );
                }
                if (snapshot.hasData) {
                  return ListView(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.only(right: 100, left: 100),
                    children: [
                      PaginatedDataTable(
                        showCheckboxColumn: false,
                        showFirstLastButtons: true,
                        sortAscending: _sortAscending,
                        sortColumnIndex: 1,
                        rowsPerPage: 14,
                        header: Text(''),
                        actions: [
                          Container(
                            padding: const EdgeInsets.only(
                                top: 20, left: 20, right: 5),
                            width: 350,
                            child: TextField(
                              controller: searchValue,
                              onChanged: (value) {
                                setState(() {
                                  _searchResult = value;
                                  _borrowerFiltered = Mapping.borrowerList
                                      .where((brw) => brw
                                          .toString()
                                          .toLowerCase()
                                          .contains(
                                              _searchResult.toLowerCase()))
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
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey.shade50),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey.shade50),
                                ),
                              ),
                            ),
                          ),
                        ],
                        columns: [
                          DataColumn(label: Text('BID')),
                          DataColumn(
                            label: Text('NAME'),
                            onSort: (index, sortAscending) {
                              setState(() {
                                _sortAscending = sortAscending;
                                if (sortAscending) {
                                  _borrowerFiltered.sort((a, b) =>
                                      a.getFirstname.compareTo(b.getFirstname));
                                } else {
                                  _borrowerFiltered.sort((a, b) =>
                                      b.getFirstname.compareTo(a.getFirstname));
                                }
                              });
                            },
                          ),
                          DataColumn(label: Text('BALANCE')),
                          DataColumn(label: Text('PAY')),
                          DataColumn(label: Text('VIEW')),
                        ],
                        source: _DataSource(context, _borrowerFiltered),
                      )
                    ],
                  );
                }
                return Center(
                  child: CircularProgressIndicator(
                    semanticsLabel: 'Fetching borrowers',
                  ),
                );
              },
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

  get getValueA => this.valueA;
  get getValueB => this.valueB;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context, this.brw) {
    brw = brw;
    _borrowers = _borrowerProfile(brw);
  }

  final BuildContext context;
  List<BorrowerModel> brw = [];
  List<_Row> _borrowers = [];
  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _borrowers.length) return null;
    final row = _borrowers[index];
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
        DataCell((row.valueD), onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return MakePayment(
                id: row.valueA,
                name: row.valueB,
                debt: row.valueC,
              );
            },
          );
        }),
        DataCell((row.valueE), onTap: () {
          showModalSideSheet(
            context: context,
            width: MediaQuery.of(context).size.width / 4,
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ViewBrwProfile(
                    id: int.parse(row.valueA),
                    name: row.valueB,
                    number: row.valueC,
                    balance: double.parse(row.valueC),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  @override
  int get rowCount => _borrowers.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

List<_Row> _borrowerProfile(List<BorrowerModel> brw) {
  try {
    return List.generate(
      brw.length,
      (index) {
        return new _Row(
          brw[index].getBorrowerId.toString(),
          brw[index].toString(),
          brw[index].getBalance.toStringAsFixed(2).toString(),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: HexColor("#155293"),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
                  child: Text(
                    'PAY',
                    style: TextStyle(
                      fontFamily: 'Cairo_SemiBold',
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: HexColor("#155293"),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
                  child: Text(
                    'VIEW',
                    style: TextStyle(
                      fontFamily: 'Cairo_SemiBold',
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
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
          "",
          Text(''),
          Text(''),
        );
      },
    );
  }
}
