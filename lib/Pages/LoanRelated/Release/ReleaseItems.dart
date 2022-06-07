import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:printing/printing.dart';
import 'package:web_store_management/Backend/CashPaymentOperation.dart';
import 'package:web_store_management/Backend/LoanOperation.dart';
import 'package:web_store_management/Backend/PurchasesOperation.dart';
import 'package:web_store_management/Helpers/PrintHelper.dart';
import 'package:web_store_management/Models/BorrowerModel.dart';
import 'package:web_store_management/Models/IncomingPurchasesModel.dart';
import 'package:web_store_management/Models/InvoiceModel.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Backend/ProductOperation.dart';

class ReleaseItems extends StatefulWidget {
  final String? name, address, barcode, borrowerId, investigationId;
  ReleaseItems({
    required this.name,
    required this.address,
    required this.barcode,
    required this.borrowerId,
    required this.investigationId,
  });

  @override
  _ReleaseItems createState() => _ReleaseItems();

  final int dangerStock = 2;
  final String released = 'RELEASED';
}

class _ReleaseItems extends State<ReleaseItems> {
  late Future<List<IncomingPurchasesModel>> _items;
  String invoiceNumber = '';
  int onhand = 0;
  double total = 0;

  var _sortAscending = true;
  var prod = ProductOperation();
  var releaseItem = PurchasesOperation();
  var loan = LoanOperation();
  var purchaseOrderId = CashPaymentOperation();

  @override
  void initState() {
    //fetches the products
    _items = releaseItem.getProductItems(widget.barcode.toString());
    _items.whenComplete(() => onhand = Mapping.productItems.length);
    purchaseOrderId.getInvoiceNumber().then((value) {
      setState(() {
        invoiceNumber = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 160),
            child: Text(
              'Release Product to ${widget.name!.toUpperCase()}',
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: HexColor("#155293"),
                fontFamily: 'Cairo_Bold',
                fontSize: 25,
              ),
            ),
          ),
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
                if (snapshot.data!.isEmpty) {
                  return Center(
                    child: Text('No items found'),
                  );
                }
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
                                await loan
                                    .approvedCredit(
                                  int.parse(widget.investigationId.toString()),
                                  int.parse(widget.borrowerId.toString()),
                                  widget.released,
                                  invoiceNumber,
                                )
                                    .then((value) {
                                  //reset all in the page
                                  //barcode.clear();
                                  Mapping.productItems.clear();
                                  Mapping.invoice.clear();

                                  setState(() {
                                    onhand = 0;
                                    _items = Future.value([]);
                                  });

                                  Navigator.pop(context);
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
                  source: _DataSource(
                      context, widget.barcode.toString(), getPrice()),
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
    );
  }

  double getPrice() {
    for (var i in Mapping.productList) {
      if (i.getProductCode == widget.barcode) {
        return i.getProductPrice;
      }
    }
    return 0;
  }

  Invoice invoiceContent(String invoiceNumber) {
    return Invoice(
      customer: BorrowerModel.invoice(
        widget.name.toString(),
        widget.address.toString(),
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
  _DataSource(this.context, this.barcode, this.price) {
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
              itemCode: row.valueA,
              remarks: row.valueB,
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
