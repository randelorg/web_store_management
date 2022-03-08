import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CashPaymentPage extends StatefulWidget {

  @override
  _CashPaymentPage createState() => _CashPaymentPage();
}

class _CashPaymentPage extends State<CashPaymentPage> {

  Widget build(BuildContext context) {
    return Column(
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
         'Cash Payment',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle( 
            color: HexColor("#155293"),
            fontFamily: 'Cairo_Bold',
            fontSize: 30,
          ),
        ),

        Row(
          children: [
            Container(
              width: (MediaQuery.of(context).size.width) / 2,
              child: FutureBuilder(
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  if (snapshot.data == true) {             
                    return PaginatedDataTable(
                      showCheckboxColumn: true,
                      showFirstLastButtons: true,
                      rowsPerPage: 10,
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
              }),
            ),
          ],
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
  );

  final String valueA;
  final String valueB;
  final String valueC;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context) {}

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
}
