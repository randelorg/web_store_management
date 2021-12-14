import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';

import 'MakePayment.dart';
import '../Borrowers/ViewBorrowerProfile.dart';
import '../../Backend/GlobalController.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreen createState() => _PaymentScreen();
}

class _PaymentScreen extends State<PaymentScreen> {
  int _currentSortColumn = 0;
  bool _isAscending = true;

  var controller = GlobalController();

  @override
  void initState() {
    super.initState();
  }

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
                    padding: const EdgeInsets.only(
                        bottom: 15, right: 100, left: 100),
                    children: [
                      PaginatedDataTable(
                        sortColumnIndex: _currentSortColumn,
                        sortAscending: _isAscending,
                        showCheckboxColumn: false,
                        rowsPerPage: 15,
                        columns: [
                          DataColumn(label: Text('BID')),
                          DataColumn(label: Text('NAME')),
                          DataColumn(label: Text('TOTAL DEBT')),
                          DataColumn(label: Text('PAYMENT')),
                          DataColumn(label: Text('VIEW')),
                        ],
                        source: _DataSource(context),
                      ),
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

  try {
    return _payments = List.generate(Mapping.borrowerList.length, (index) {
      return _Row(
        Mapping.borrowerList[index].getBorrowerId.toString(),
        Mapping.borrowerList[index].toString(),
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
                    EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
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
    });
  } catch (e) {
    //if borrowers list is empty
    return _payments = List.generate(0, (index) {
      return _Row(
        '',
        '',
        '',
        Text(''),
        Text(''),
      );
    });
  }
}
