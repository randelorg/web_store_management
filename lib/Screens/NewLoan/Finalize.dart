import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'TermsAndConditions.dart';

class Finalize extends StatefulWidget {
  @override
  _Finalize createState() => _Finalize();
}

class _Finalize extends State<Finalize> {
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(10),
        children: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Center(
              child: Text(
                'FINALIZE',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
          PaginatedDataTable(
            showCheckboxColumn: false,
            rowsPerPage: 5,
            columns: [
              DataColumn(label: Text('PRODUCT NAME')),
              DataColumn(label: Text('PRICE')),
              DataColumn(label: Text('QTY')),
              DataColumn(label: Text('ACTTION')),
            ],
            source: _DataSource(context),
          ),
          Divider(
            thickness: 2,
          ),
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'TOTAL:  ',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '15000',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(20.0),
                              primary: Colors.white,
                              textStyle: const TextStyle(fontSize: 18),
                            ),
                            onPressed: () {
                              Navigator.pop(context, true);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return TermsAndConditions();
                                },
                              );
                            },
                            child: const Text('NEXT'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
  final Widget valueC;
  final Widget valueD;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context) {
    _finalizeProducts(context);
  }

  final BuildContext context;

  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _finalizeProducts(context).length) return null;
    final row = _finalizeProducts(context)[index];
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
        DataCell((row.valueC)),
        DataCell((row.valueD)),
      ],
    );
  }

  @override
  int get rowCount => _finalizeProducts(context).length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

List _finalizeProducts(BuildContext context) {
  List<_Row> _finalizeProducts;

  return _finalizeProducts = List.generate(
    5,
    (index) {
      return new _Row(
        'Hanabishi Blender',
        '3000',
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add_circle,
                color: Colors.blue.shade400,
              ),
            ),
            Text('3'),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.remove_circle,
                color: Colors.red.shade400,
              ),
            )
          ],
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red.shade400,
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(15.0),
                  primary: Colors.white,
                  textStyle: const TextStyle(fontSize: 15),
                ),
                onPressed: () {},
                child: const Text('DELETE'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
