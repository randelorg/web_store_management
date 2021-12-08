import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';

class PaymentHistory extends StatefulWidget {
  final String? borrowerName;
  PaymentHistory({this.borrowerName});

  @override
  _PaymentHistory createState() => _PaymentHistory();
}

class _PaymentHistory extends State<PaymentHistory> {
  var _borrowerName;
  @override
  void initState() {
    super.initState();
    
  }

  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width),
      height: (MediaQuery.of(context).size.height),
      child: ListView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(10),
        children: [
          PaginatedDataTable(
            header: Text(
             _borrowerName,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            showCheckboxColumn: false,
            rowsPerPage: 15,
            columns: [
              DataColumn(label: Text('LOAN ID')),
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
  );

  final String valueA;
  final String valueB;
  final String valueC;

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

  try {
    return _paymentsHistory = List.generate(
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
    return _paymentsHistory = List.generate(
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
