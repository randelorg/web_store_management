import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'ViewBorrowerProfile.dart';
import '../../Backend/Utility/Mapping.dart';
import '../../Backend/GlobalController.dart';

class BorrowersScreen extends StatefulWidget {
  @override
  _BorrowersScreen createState() => _BorrowersScreen();
}

class _BorrowersScreen extends State<BorrowersScreen> {
  var controller = GlobalController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.only(top: 15, bottom: 15, right: 100),
              width: 400,
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
        FutureBuilder(
          future: controller.fetchBorrowers(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  semanticsLabel: 'Fetching borrowers',
                ),
              );
            }
            if (snapshot.hasData) {
              return Expanded(
                child: Container(
                  width: (MediaQuery.of(context).size.width),
                  height: (MediaQuery.of(context).size.height),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.only(right: 100, left: 100),
                    children: [
                      PaginatedDataTable(
                        showCheckboxColumn: false,
                        rowsPerPage: 15,
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
              );
            }
            return Center(
              child: CircularProgressIndicator(
                semanticsLabel: 'Fetching borrowers',
              ),
            );
          },
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
  final String valueD;
  final Widget valueE;

  bool selected = false;
}

List _borrowerProfile(BuildContext context) {
  List<_Row> _profiles;

  try {
    return _profiles = List.generate(
      Mapping.borrowerList.length,
      (index) {
        return new _Row(
          Mapping.borrowerList[index].getBorrowerId.toString(),
          Mapping.borrowerList[index].toString(),
          Mapping.borrowerList[index].getMobileNumber.toString(),
          Mapping.borrowerList[index].getBalance.toStringAsFixed(2).toString(),
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
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
                      EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
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
    return _profiles = List.generate(
      0,
      (index) {
        return new _Row(
          "",
          "",
          "",
          "",
          Text(''),
        );
      },
    );
  }
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
        DataCell((row.valueE), onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ViewBorrowerProfile(
                id: row.valueA,
                name: row.valueB,
                number: row.valueC,
                balance: double.parse(row.valueD),
              );
            },
          );
        }),
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
