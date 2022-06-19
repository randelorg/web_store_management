import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';
import 'package:web_store_management/Backend/GlobalController.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Pages/Branch/AddBranch.dart';
import 'package:web_store_management/Pages/Branch/UpdateBranch.dart';
import 'package:web_store_management/Models/BranchModel.dart';

class BranchPage extends StatefulWidget {
  @override
  _BranchPage createState() => _BranchPage();
}

class _BranchPage extends State<BranchPage> {
  var controller = GlobalController();
  var _sortAscending = true;
  late Future<List<BranchModel>> branches;
  List<BranchModel> _branchFiltered = [];
  TextEditingController searchValue = TextEditingController();
  String _searchResult = '';

  @override
  void initState() {
    branches = controller.fetchBranches();
    branches.whenComplete(() => _branchFiltered = Mapping.branchList);
    super.initState();
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
                alignment: Alignment.topLeft,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: HexColor("#155293"),
                          ),
                        ),
                      ),
                      TextButton.icon(
                        icon: Icon(MdiIcons.storePlusOutline, color: Colors.white),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                          primary: Colors.white,
                          textStyle: TextStyle(
                              fontSize: 18, fontFamily: 'Cairo_SemiBold'),
                        ),
                        label: Text('NEW BRANCH'),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AddBranch();
                            },
                          );
                        },
                      ),
                    ],
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
            child: FutureBuilder<List<BranchModel>>(
              future: branches,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      semanticsLabel: 'Fetching branches',
                    ),
                  );
                }
                if (snapshot.hasData) {
                  return ListView(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.only(top: 5, right: 100, left: 100),
                    children: [
                      PaginatedDataTable(
                        showCheckboxColumn: false,
                        showFirstLastButtons: true,
                        sortAscending: _sortAscending,
                        sortColumnIndex: 0,
                        rowsPerPage: 14,
                        header: Text('Branch List', 
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontFamily: 'Cairo_Bold'),
                        ),
                        actions: [
                          Container(
                            padding: const EdgeInsets.only(left: 20, right: 5),
                            width: 300,
                            child: TextField(
                              controller: searchValue,
                              onChanged: (value) {
                                setState(() {
                                  _searchResult = value;                          
                                  _branchFiltered = Mapping.branchList
                                      .where((branch) => branch.branchName
                                           .toLowerCase()
                                           .contains(_searchResult.toLowerCase()))
                                      .toList();
                                });
                              },
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.search_rounded),
                                hintText: 'Search Branch', 
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
                          DataColumn(
                            label: Text('BCODE'),
                            onSort: (index, sortAscending) {
                              setState(() {
                                _sortAscending = sortAscending;
                                if (sortAscending) {
                                  _branchFiltered.sort((a, b) =>
                                      a.branchCode.compareTo(b.branchCode));
                                } else {
                                  _branchFiltered.sort((a, b) =>
                                      b.branchCode.compareTo(a.branchCode));
                                }
                              });
                            },
                          ),
                          DataColumn(label: Text('NAME')),
                          DataColumn(label: Text('ADDRESS')),
                          DataColumn(label: Text('UPDATE')),
                        ],
                        source: _DataSource(context, _branchFiltered),
                      )
                    ],
                  );
                }
                return Center(
                  child: CircularProgressIndicator(
                    semanticsLabel: 'Fetching branches',
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
  );

  final String valueA;
  final String valueB;
  final String valueC;
  final Widget valueD;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context, this._branchesFiltered) {
    _branchesFiltered = _branchesFiltered;
    _branch = _borrowerProfile(_branchesFiltered);
  }

  final BuildContext context;

  int _selectedCount = 0;
  List<_Row> _branch = [];
  List<BranchModel> _branchesFiltered = [];

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _branch.length) return null;
    final row = _branch[index];
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
           showModalSideSheet(
            context: context,
            width: MediaQuery.of(context).size.width / 4,
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: UpdateBranch(
                    branchCode: row.valueA,
                    branchName: row.valueB,
                    branchAddress: row.valueC,     
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
  int get rowCount => _branch.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  List<_Row> _borrowerProfile(List<BranchModel> branch) {
    try {
      return List.generate(branch.length, (index) {
        return new _Row(
          branch[index].branchCode.toString(),
          branch[index].branchName.toString(),
          branch[index].branchAddress.toString(),
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
                  padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
                  child: Icon(MdiIcons.storeEditOutline, color: Colors.white),
                ),
              ],
            ),
          ),
        );
      });
    } catch (e) {
      //if employees list is empty
      return List.generate(0, (index) {
        return _Row(
          '',
          '',
          '',
          Text(''),
        );
      });
    }
  }
}
