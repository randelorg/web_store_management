import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Backend/PurchasesOperation.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Models/IncomingPurchasesModel.dart';
import 'package:web_store_management/Pages/InventoryMain/ViewOrders/ReceiveOrders.dart';

class ViewOrderList extends StatefulWidget {
  final String? orderSlipId, datePurchase, supplierName;
  ViewOrderList(
      {required this.orderSlipId,
      required this.datePurchase,
      required this.supplierName});

  @override
  _ViewOrderList createState() => _ViewOrderList();
}

class _ViewOrderList extends State<ViewOrderList> {
  var orders = PurchasesOperation();

  late Future<List<IncomingPurchasesModel>> _order;
  var _sortAscending = true;

  @override
  void initState() {
    super.initState();
    this._order = orders.getOrders(widget.orderSlipId.toString(),
        widget.supplierName.toString(), widget.datePurchase.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Order Slip ID: ${widget.orderSlipId} ordered from ${widget.supplierName!.toUpperCase()}',
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
                widget.orderSlipId.toString().toUpperCase(),
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Cairo_SemiBold',
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        FutureBuilder<List<IncomingPurchasesModel>>(
          future: this._order,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  semanticsLabel: 'Fetching order list',
                ),
              );
            }
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                return Padding(
                  padding: EdgeInsets.only(top: 5, left: 15, right: 15),
                  child: PaginatedDataTable(
                    showCheckboxColumn: false,
                    showFirstLastButtons: true,
                    sortAscending: _sortAscending,
                    sortColumnIndex: 0,
                    rowsPerPage: 8,
                    columns: [
                      DataColumn(
                        label: Text('BARCODE'),
                        onSort: (index, sortAscending) {
                          setState(() {
                            _sortAscending = sortAscending;
                            if (sortAscending) {
                              snapshot.data!.sort((a, b) =>
                                  a.getProductCode.compareTo(b.getProductCode));
                            } else {
                              snapshot.data!.sort((a, b) =>
                                  b.getProductCode.compareTo(a.getProductCode));
                            }
                          });
                        },
                      ),
                      DataColumn(label: Text('PNAME')),
                      DataColumn(label: Text('TYPE')),
                      DataColumn(label: Text('QUANTITY ORDERED')),
                      DataColumn(label: Text('ACTIION')),
                    ],
                    source: _DataSource(context),
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    'NO ORDER DETAILS FOUND',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontFamily: 'Cairo_SemiBold',
                      fontSize: 20,
                    ),
                  ),
                );
              }
            }
            return Center(
              child: Center(
                child: Text(
                  'NO ORDER DETAILS FOUND',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontFamily: 'Cairo_SemiBold',
                    fontSize: 20,
                  ),
                ),
              ),
            );
          },
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
    this.valueD,
    this.valueE,
  );

  final String valueA;
  final String valueB;
  final String valueC;
  final int valueD;
  final Widget valueE;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context) {
    _payHistory = _orders();
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
        DataCell(Text(row.valueD.toString())),
        DataCell((row.valueE), onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ReceiveOrders(
                supplierBarcode: row.valueA,
                qty: int.parse(row.valueD.toString()),
              );
            },
          );
        }),
      ],
    );
  }

  @override
  int get rowCount => _payHistory.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  List<_Row> _orders() {
    try {
      return List.generate(
        Mapping.ordersList.length,
        (index) {
          return _Row(
            Mapping.ordersList[index].getProductCode,
            Mapping.ordersList[index].getProductName,
            Mapping.ordersList[index].getProdType,
            Mapping.ordersList[index].getNumberReceived,
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: HexColor("#155293"),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
                    child: Text(
                      'RECEIEVE',
                      style: TextStyle(
                        fontFamily: 'Cairo_SemiBold',
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
            0,
            Text(''),
          );
        },
      );
    }
  }
}
