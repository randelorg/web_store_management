import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Backend/HistoryOperation.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Models/PaymentHistoryModel.dart';

class LocalPaymentHistory extends StatefulWidget {
  final String? id, borrowerName;
  LocalPaymentHistory({required this.id, this.borrowerName});

  @override
  _LocalPaymentHistory createState() => _LocalPaymentHistory();
}

class _LocalPaymentHistory extends State<LocalPaymentHistory> {
  var history = HistoryOperation();
  late Future<List<PaymentHistoryModel>> _paymentHistory;
  var _sortAscending = true;

  @override
  void initState() {
    super.initState();
    this._paymentHistory = history.viewPaymentHistory(widget.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width),
      height: (MediaQuery.of(context).size.height),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 5, right: 8),
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(
                  Icons.cancel,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          Text(
            'Payment History',
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: HexColor("#155293"),
              fontFamily: 'Cairo_Bold',
              fontSize: 30,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20, top: 50),
                child: Text(
                  widget.borrowerName.toString().toUpperCase(),
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Cairo_SemiBold',
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          FutureBuilder<List<PaymentHistoryModel>>(
            future: this._paymentHistory,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    semanticsLabel: 'Fetching borrowers',
                  ),
                );
              }
              if (snapshot.hasData) {
                if (snapshot.data!.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
                    child: PaginatedDataTable(
                      showCheckboxColumn: false,
                      showFirstLastButtons: true,
                      sortAscending: _sortAscending,
                      sortColumnIndex: 0,
                      rowsPerPage: 12,
                      columns: [
                        DataColumn(
                          label: Text('COLLECTION ID'),
                          onSort: (index, sortAscending) {
                            setState(() {
                              _sortAscending = sortAscending;
                              if (sortAscending) {
                                snapshot.data!.sort((a, b) => a.getCollectionID
                                    .compareTo(b.getCollectionID));
                              } else {
                                snapshot.data!.sort((a, b) => b.getCollectionID
                                    .compareTo(a.getCollectionID));
                              }
                            });
                          },
                        ),
                        DataColumn(label: Text('AMOUNT PAID')),
                        DataColumn(label: Text('DATE GIVEN')),
                      ],
                      source: _DataSource(context),
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      'NO PAYMENT HISTORY',
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontFamily: 'Cairo_SemiBold',
                          fontSize: 20),
                    ),
                  );
                }
              }
              return Center(
                child: Center(
                  child: Text(
                    'NO PAYMENT HISTORY FOR THIS BORROWER',
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontFamily: 'Cairo_SemiBold',
                        fontSize: 20),
                  ),
                ),
              );
            },
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
  final String valueC;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context) {
    _payHistory = _paymentsHistory();
  }

  final BuildContext context;

  int _selectedCount = 0;
  List<_Row> _payHistory = [];

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _payHistory.length) return null;
    final row = _payHistory[index];
    return DataRow.byIndex(
      index: index,
      selected: row.selected,
      cells: [
        DataCell(Text(row.valueA)),
        DataCell(Text(row.valueB)),
        DataCell(Text(row.valueC)),
      ],
    );
  }

  @override
  int get rowCount => _payHistory.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  List<_Row> _paymentsHistory() {
    try {
      return List.generate(
        Mapping.paymentList.length,
        (index) {
          return _Row(
            Mapping.paymentList[index].getCollectionID.toString(),
            Mapping.paymentList[index].getCollectionAmount.toString(),
            Mapping.paymentList[index].getGivenDate.toString(),
          );
        },
      );
    } catch (e) {
      return List.generate(
        0,
        (index) {
          return _Row(
            '',
            '',
            '',
          );
        },
      );
    }
  }
}
