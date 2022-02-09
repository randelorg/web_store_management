import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
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
  late Future paymentHistory;

  @override
  void initState() {
    super.initState();
    this.paymentHistory = history.viewPaymentHistory(widget.id.toString());
  }

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
          FutureBuilder(
            future: this.paymentHistory,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                if (snapshot.data == true) {
                  return PaginatedDataTable(
                    header: Text(
                      widget.borrowerName.toString().toUpperCase(),
                      style: TextStyle(
                        color: HexColor("#155293"),
                        fontFamily: 'Cairo_Bold',
                        fontSize: 20,
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
                } else {
                  return Center(
                    child: Text('No Payment History'),
                  );
                }
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