import 'package:flutter/material.dart';
import 'package:web_store_management/Backend/HistoryOperation.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';

class PaymentHistory extends StatefulWidget {
  final String? id, borrowerName;
  PaymentHistory({this.id, this.borrowerName});

  @override
  _PaymentHistory createState() => _PaymentHistory();
}

class _PaymentHistory extends State<PaymentHistory> {
  var history = HistoryOperation();
  late Future _history;

  @override
  void initState() {
    super.initState();
    this._history = history.viewPaymentHistory(widget.id.toString());
  }

  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width),
      height: (MediaQuery.of(context).size.height),
      child: ListView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(10),
        children: [
          FutureBuilder(
            future: this._history,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                return PaginatedDataTable(
                  header: Text(
                    widget.borrowerName.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  showCheckboxColumn: false,
                  showFirstLastButtons: true,
                  rowsPerPage: 15,
                  columns: [
                    DataColumn(label: Text('COLLECTION ID')),
                    DataColumn(label: Text('AMOUNT PAID')),
                    DataColumn(label: Text('DATE GIVEN')),
                  ],
                  source: _DataSource(context),
                );
              }
              return Center(
                child: Center(
                  child: Text(
                    'No payment history for this borrower',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
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
