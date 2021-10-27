import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductHistory extends StatefulWidget {
  @override
  _ProductHistory createState() => _ProductHistory();
}

class _ProductHistory extends State<ProductHistory> {
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
              DataColumn(label: Text('PRODID')),
              DataColumn(label: Text('PRODUCT \n NAME')),
              DataColumn(label: Text('PRICE')),
              DataColumn(label: Text('QTY')),
              DataColumn(label: Text('PAYMENT \n PLAN')),
              DataColumn(label: Text('DATE \n ADDED')),
              DataColumn(label: Text('DUE \n DATE')),
              DataColumn(label: Text('TERM')),
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
    _productHistory(context);
  }

  final BuildContext context;

  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _productHistory(context).length) return null;
    final row = _productHistory(context)[index];
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
  int get rowCount => _productHistory(context).length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

List _productHistory(BuildContext context) {
  List<_Row> _productHistory;

  return _productHistory = List.generate(
    25,
    (index) {
      return _Row('0120', 'camel stand fan', 20000, 1, 'Daily', '03/31/21',
          '10,31,21', 'NONE');
    },
  );
}
