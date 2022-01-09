import 'package:flutter/material.dart';
import 'package:kt_dart/src/collection/interop.dart';
import 'package:kt_dart/src/collection/kt_iterable.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'TermsAndConditionsPage.dart';

class FinalizePage extends StatefulWidget {
  @override
  _FinalizePage createState() => _FinalizePage();
}

class _FinalizePage extends State<FinalizePage> {
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(5),
          child: Center(
            child: Text(
              'FINALIZE',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 2,
          child: PaginatedDataTable(
            showCheckboxColumn: false,
            rowsPerPage: 5,
            columns: [
              DataColumn(label: Text('PRODUCT NAME')),
              DataColumn(label: Text('PRICE')),
              DataColumn(label: Text('QTY')),
            ],
            source: _DataSource(context),
          ),
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
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '15000',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
                                return TermsAndConditionsPage();
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
  final Widget valueC;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context) {
    _selectedProducts = _finalizeProducts();
  }

  final BuildContext context;

  int _selectedCount = 0;
  List<_Row> _selectedProducts = [];

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _selectedProducts.length) return null;
    final row = _selectedProducts[index];
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
      ],
    );
  }

  @override
  int get rowCount => _selectedProducts.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  List<_Row> _finalizeProducts() {
    final _productsWithoutDuplicates =
        Mapping.selectedProducts.map((e) => e.getName).toSet();
    Mapping.selectedProducts
        .retainWhere((x) => _productsWithoutDuplicates.remove(x.getName));

    return List.generate(
      Mapping.selectedProducts.length,
      (index) {
        return new _Row(
          Mapping.selectedProducts[index].getName.toString(),
          Mapping.selectedProducts[index].getPrice.toString(),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.add_circle,
                  color: Colors.blue.shade400,
                ),
                onPressed: () {},
              ),
              Text('3'),
              IconButton(
                icon: Icon(
                  Icons.remove_circle,
                  color: Colors.red.shade400,
                ),
                onPressed: () {},
              )
            ],
          ),
        );
      },
    );
  }
}
