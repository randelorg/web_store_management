import 'package:flutter/material.dart';
import 'package:web_store_management/Backend/HistoryOperation.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';

class ProductHistory extends StatefulWidget {
  final String? borrowerId, borrowerName;
  ProductHistory({this.borrowerId, this.borrowerName});

  @override
  _ProductHistory createState() => _ProductHistory();
}

class _ProductHistory extends State<ProductHistory> {
  var history = HistoryOperation();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width),
      height: (MediaQuery.of(context).size.height),
      child: ListView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(10),
        children: [
          FutureBuilder(
            future: history.viewLoanHistory(widget.borrowerId.toString()),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
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
                    DataColumn(label: Text('LOANID')),
                    DataColumn(label: Text('PRODUCT \n NAME')),
                    DataColumn(label: Text('PRICE')),
                    DataColumn(label: Text('QTY')),
                    DataColumn(label: Text('PAYMENT \n PLAN')),
                    DataColumn(label: Text('DATE \n ADDED')),
                    DataColumn(label: Text('DUE \n DATE')),
                    DataColumn(label: Text('TERM')),
                  ],
                  source: _DataSource(context),
                );
              }
              return Center(
                child: Text(
                  'No loan history for this borrower',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
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
    this.valueD,
    this.valueE,
    this.valueF,
    this.valueG,
    this.valueH,
  );

  final String valueA;
  final String valueB;
  final double valueC; //price
  final int valueD; //quantity
  final String valueE;
  final String valueF;
  final String valueG;
  final String valueH;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context) {
    _productsHistory = _products();
  }

  final BuildContext context;

  int _selectedCount = 0;

  List<_Row> _productsHistory = [];

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _productsHistory.length) return null;
    final row = _productsHistory[index];
    return DataRow.byIndex(
      index: index,
      selected: row.selected,
      cells: [
        DataCell(Text(row.valueA)),
        DataCell(Text(row.valueB)),
        DataCell(Text(row.valueC.toString())),
        DataCell(Text(row.valueD.toString())),
        DataCell(Text(row.valueE)),
        DataCell(Text(row.valueF)),
        DataCell(Text(row.valueG)),
        DataCell(Text(row.valueH)),
      ],
    );
  }

  @override
  int get rowCount => _productsHistory.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  List<_Row> _products() {
    try {
      return List.generate(
        Mapping.productHistoryList.length,
        (index) {
          return _Row(
            Mapping.productHistoryList[index].getLoanId.toString(),
            Mapping.productHistoryList[index].getProductName,
            Mapping.productHistoryList[index].getPrice,
            Mapping.productHistoryList[index].getQty,
            Mapping.productHistoryList[index].getPaymentPlan,
            Mapping.productHistoryList[index].getDateAdded,
            Mapping.productHistoryList[index].getDueDate,
            Mapping.productHistoryList[index].getTerm,
          );
        },
      );
    } catch (e) {
      return List.generate(
        0,
        (index) {
          return _Row('', '', 0, 0, '', '', '', '');
        },
      );
    }
  }
}
