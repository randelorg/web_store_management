import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PaymentHistory extends StatefulWidget {
  @override
  _PaymentHistory createState() => _PaymentHistory();
}

class _PaymentHistory extends State<PaymentHistory> {
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width),
      height: (MediaQuery.of(context).size.height),
      child: ListView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(10),
        children: [
          PaginatedDataTable(
            showCheckboxColumn: false,
            rowsPerPage: 15,
            columns: [
              DataColumn(label: Text('LOAN ID')),
              DataColumn(label: Text('COLLECTOR NAME')),
              DataColumn(label: Text('AMOUNT PAID')),
              DataColumn(label: Text('DATE GIVEN')),
            ],
            source: _DataSource(context),
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
  );

  final String valueA;
  final String valueB;
  final String valueC;
  final String valueD;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context) {
    _paymentsHistory(context);
  }

  final BuildContext context;

  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _paymentsHistory(context).length) return null;
    final row = _paymentsHistory(context)[index];
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
      ],
    );
  }

  @override
  int get rowCount => _paymentsHistory(context).length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

List _paymentsHistory(BuildContext context) {
  List<_Row> _paymentsHistory;

  return _paymentsHistory = List.generate(
    25,
    (index) {
      int tot = index + 1;
      return _Row(
        'BID',
        'Randel Reyes',
        '20,000',
        '10/31/21',
      );
    },
  );
}
