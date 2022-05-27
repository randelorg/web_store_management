import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:printing/printing.dart';
import 'package:web_store_management/Backend/CashPaymentOperation.dart';
import 'package:web_store_management/Backend/GlobalController.dart';
import 'package:web_store_management/Backend/PurchasesOperation.dart';
import 'package:web_store_management/Helpers/PrintHelper.dart';
import 'package:web_store_management/Models/BorrowerModel.dart';
import 'package:web_store_management/Models/IncomingPurchasesModel.dart';
import 'package:web_store_management/Models/InvoiceModel.dart';
import 'package:web_store_management/Models/ProductModel.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Backend/ProductOperation.dart';

class CustomerBuy extends StatefulWidget {
  @override
  _CustomerBuy createState() => _CustomerBuy();
}

class _CustomerBuy extends State<CustomerBuy> {
  var _sortAscending = true;
  var controller = GlobalController();
  var prod = ProductOperation();
  var searchProduct = PurchasesOperation();
  late Future<List<ProductModel>> _products;
  late Future<List<IncomingPurchasesModel>> _purchases;
  late Future<List<IncomingPurchasesModel>> _items;
  String _orderId = '', pickedSupplier = '';
  bool show = false;
  var purchaseOrderId = CashPaymentOperation();
  TextEditingController productName = TextEditingController();
  TextEditingController barcode = TextEditingController();
  TextEditingController qty = TextEditingController();

  @override
  void initState() {
    //fetches the products
    _products = controller.fetchProducts();
    _purchases = Future.value([]);
    _items = Future.value([]);
    purchaseOrderId.getInvoiceNumber().then((value) {
      setState(() {
        _orderId = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: [
            Container(
              width: 400,
              child: Padding(
                //scan barcode or manually enter barcode
                padding: EdgeInsets.all(40),
                child: TextField(
                  controller: barcode,
                  decoration: InputDecoration(
                    hintText: 'Barcode',
                    filled: true,
                    fillColor: Colors.blueGrey[50],
                    labelStyle: TextStyle(fontSize: 10),
                    contentPadding: EdgeInsets.only(left: 15),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade50),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade50),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 40,
                bottom: 40,
                left: 20,
                right: 40,
              ),
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
                      child: const Text('Search product'),
                      onPressed: () async {
                        _items = searchProduct.getProductItems(barcode.text);

                        setState(() {
                          _items = _items;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        //the list of products
        _tablePurchases(),
      ],
    );
  }

  Widget _tablePurchases() {
    return Expanded(
      child: Container(
        width: (MediaQuery.of(context).size.width) / 1.2,
        height: (MediaQuery.of(context).size.height),
        child: ListView(
          children: [
            FutureBuilder<List<IncomingPurchasesModel>>(
              future: _purchases,
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
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(10),
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
                                child: const Text('PROCEED'),
                                onPressed: () async {
                                  //TODO: ADD TO PURCHASE ORDER HERE O THE DB
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return showInvoice(
                                          invoiceContent(_orderId));
                                    },
                                  );

                                  searchProduct
                                      .customerPurchase(
                                          _orderId, Mapping.dateToday())
                                      .then((value) {});
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
                          padding: const EdgeInsets.only(right: 40),
                          child: Text(_orderId.toUpperCase()),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 40),
                          child: Text('total qty of onhand products'),
                        ),
                        Text(Mapping.dateToday()),
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
    );
  }

  Invoice invoiceContent(String invoiceNumber) {
    return Invoice(
      customer: BorrowerModel.invoice(
        fname.text.trim(),
        lname.text.trim(),
        address.text.trim(),
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
        build: (format) => PrintHelper.generateLoanInvoice(
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
