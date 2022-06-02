import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:printing/printing.dart';
import 'package:web_store_management/Backend/GlobalController.dart';
import 'package:web_store_management/Backend/PurchasesOperation.dart';
import 'package:web_store_management/Helpers/PrintHelper.dart';
import 'package:web_store_management/Models/BorrowerModel.dart';
import 'package:web_store_management/Models/IncomingPurchasesModel.dart';
import 'package:web_store_management/Models/InvoiceModel.dart';
import 'package:web_store_management/Models/ProductModel.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Backend/ProductOperation.dart';

class ReleaseItems extends StatefulWidget {
  final String? barcode;
  ReleaseItems({required this.barcode});

  @override
  _ReleaseItems createState() => _ReleaseItems();
}

class _ReleaseItems extends State<ReleaseItems> {
  late Future<List<ProductModel>> _products;
  late Future<List<IncomingPurchasesModel>> _purchases;
  late Future<List<IncomingPurchasesModel>> _items;

  String _orderId = '', pickedSupplier = '';
  bool show = false;
  int onhand = 0;
  double total = 0;
  final int dangerStock = 2;

  var _sortAscending = true;
  var controller = GlobalController();
  var prod = ProductOperation();
  var releaseItem = PurchasesOperation();

  @override
  void initState() {
    //fetches the products
    _products = controller.fetchProducts();
    _purchases = Future.value([]);
    _items = releaseItem.getProductItems(widget.barcode.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        //the list of products
        Expanded(
          child: Container(
            child: ListView(
              children: [
                FutureBuilder<List<IncomingPurchasesModel>>(
                  future: _items,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          semanticsLabel: 'Fetching purchases products',
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      return PaginatedDataTable(
                        columnSpacing: 20,
                        actions: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: ClipRRect(
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
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.only(
                                        top: 18,
                                        bottom: 18,
                                        left: 36,
                                        right: 36,
                                      ),
                                      primary: Colors.white,
                                      textStyle: TextStyle(
                                        fontFamily: 'Cairo_SemiBold',
                                        fontSize: 14,
                                      ),
                                    ),
                                    child: const Text('RELEASE'),
                                    onPressed: () async {
                                      //reset all in the page
                                      //barcode.clear();
                                      Mapping.productItems.clear();
                                      Mapping.invoice.clear();

                                      setState(() {
                                        onhand = 0;
                                        _items = Future.value([]);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                        header: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 50),
                              child: Text('ON HAND: $onhand'),
                            ),
                            Text("Date Today: ${Mapping.dateToday()}"),
                          ],
                        ),
                        showCheckboxColumn: true,
                        showFirstLastButtons: true,
                        sortAscending: _sortAscending,
                        sortColumnIndex: 1,
                        rowsPerPage: 9,
                        columns: [
                          DataColumn(label: Text('Item Code')),
                          DataColumn(label: Text('Remarks')),
                        ],
                        source: _DataSource(context),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        semanticsLabel: 'Fetching on hand products',
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Invoice invoiceContent(String invoiceNumber) {
    return Invoice(
      customer: BorrowerModel.invoice(
        'RANDEL',
        'REYES',
        'Mabolo',
      ),
      info: InvoiceInfo(
        date: DateTime.now(),
        description: 'This will serve as your Unofficial Receipt. Thank you!',
        number: invoiceNumber,
      ),
      items: Mapping.invoice,
    );
  }

  Widget showInvoice(Invoice invoice) {
    return Container(
      child: PdfPreview(
        padding: EdgeInsets.all(10),
        build: (format) => PrintHelper.generateInvoice(
          format,
          invoice,
        ),
      ),
    );
  }
}

class _Row {
  _Row(
    this.valueA,
    this.valueB,
  );

  final String valueA;
  final String valueB;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context) {
    _products = _productList();
  }

  final BuildContext context;
  int _selectedCount = 0;
  List<_Row> _products = [];
  String barcode = '';
  double price = 0.0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _products.length) return null;
    final row = _products[index];
    return DataRow.byIndex(
      index: index,
      selected: row.selected,
      onSelectChanged: (value) {
        if (row.selected) {
          value = false;
        } else {
          value = true;
        }

        if (row.selected != value) {
          if (value) {
            _selectedCount += 1;
          }

          //add the checked product to the list
          //we will remove the duplicate products afterward
          Mapping.invoice.add(
            InvoiceProductItem(
              remarks: row.valueB,
              itemCode: row.valueA,
              prodCode: barcode,
              currentPrice: price,
              vat: 0,
              qty: 1,
            ),
          );

          //delete the uncheck product to the list
          if (value == false) {
            _selectedCount -= 1;
            Mapping.invoice.removeWhere(
              (element) => element.itemCode == row.valueA.toString(),
            );
          }

          notifyListeners();
        }

        assert(_selectedCount >= 0);
        row.selected = value;
      },
      cells: [
        DataCell(Text(row.valueA)),
        DataCell(Text(row.valueB)),
      ],
    );
  }

  @override
  int get rowCount => _products.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  List<_Row> _productList() {
    try {
      print(Mapping.productItems.length);
      return List.generate(Mapping.productItems.length, (index) {
        return _Row(
          Mapping.productItems[index].getProductItemCode,
          Mapping.productItems[index].getRemarks,
        );
      });
    } catch (e) {
      //if product list is empty
      return List.generate(0, (index) {
        return _Row(
          '',
          '',
        );
      });
    }
  }
}
