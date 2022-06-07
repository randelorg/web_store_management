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
import 'package:web_store_management/Notification/BannerNotif.dart';

class CustomerBuy extends StatefulWidget {
  @override
  _CustomerBuy createState() => _CustomerBuy();

  final String sold = 'SOLD';
  final int dangerStock = 2;
}

class _CustomerBuy extends State<CustomerBuy> {
  late Future<List<ProductModel>> _products;
  late Future<List<IncomingPurchasesModel>> _purchases;
  late Future<List<IncomingPurchasesModel>> _items;

  String _orderId = '', pickedSupplier = '';
  bool show = false;
  int onhand = 0;
  double total = 0;

  var _sortAscending = true;
  var controller = GlobalController();
  var prod = ProductOperation();
  var searchProduct = PurchasesOperation();

  var purchaseOrderId = CashPaymentOperation();
  var productName = TextEditingController();
  var barcode = TextEditingController();
  var amountTendered = TextEditingController();
  var change = TextEditingController();
  var totalAmount = TextEditingController();

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
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 400,
                padding: const EdgeInsets.only(
                  top: 50,
                  bottom: 10,
                  left: 135,
                  right: 5,
                ),
                child: TextField(
                  controller: barcode,
                  decoration: InputDecoration(
                    hintText: 'Product Barcode',
                    filled: true,
                    fillColor: Colors.blueGrey[50],
                    labelStyle: TextStyle(fontSize: 12),
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
                  top: 50, bottom: 10, left: 5, right: 40),
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
                      child: const Text('Search'),
                      onPressed: () async {
                        if (barcode.text.isEmpty) {
                          BannerNotif.notif(
                              "Error",
                              "Please fill the product barcode field",
                              Colors.red.shade600);
                        } else {
                          _items = searchProduct.getProductItems(barcode.text);

                          _items.whenComplete(() {
                            setState(() {
                              _items = _items;
                              onhand = Mapping.productItems.length;
                              if (onhand <= widget.dangerStock) {
                                BannerNotif.notif(
                                  'SOLD OUT',
                                  'Product is sold out',
                                  Colors.orange,
                                );
                              }
                            });
                          });
                        }
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

        Text('Total: $total'),
      ],
    );
  }

  double getPrice() {
    for (var i in Mapping.productList) {
      if (i.getProductCode == barcode.text) {
        return i.getProductPrice;
      }
    }
    return 0;
  }

  double getTotal() {
    double total = 0;
    for (var i in Mapping.invoice) {
      total += i.currentPrice;
    }
    return total;
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
                                child: const Text('PROCEED'),
                                onPressed: () async {
                                  //show payment and change or paying window
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return paymentAndChange();
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
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
                                child: const Text('CANCEL'),
                                onPressed: () async {
                                  //reset all in the page
                                  barcode.clear();
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
                          child: Text("Invoice #: ${_orderId.toUpperCase()}"),
                        ),
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
                    source: _DataSource(context, barcode.text, getPrice()),
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

  Widget paymentAndChange() {
    return AlertDialog(
      actionsPadding: EdgeInsets.only(bottom: 5, left: 5, right: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actions: <Widget>[
        Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(
                  Icons.cancel,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Text(
              'Make Payment',
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: HexColor("#155293"),
                fontFamily: 'Cairo_Bold',
                fontSize: 30,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 2),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Total Amount',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 2, bottom: 5),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  getTotal().toString(),
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Cairo_Bold',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 2),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Amount Tendered',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: TextField(
                controller: amountTendered,
                decoration: InputDecoration(
                  hintText: 'Enter Amount',
                  filled: true,
                  fillColor: Colors.blueGrey[50],
                  labelStyle: TextStyle(fontSize: 8),
                  contentPadding: EdgeInsets.only(left: 10),
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
            Padding(
              padding: EdgeInsets.only(left: 2),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Change Amount',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: TextField(
                controller: change,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Change Amount',
                  filled: true,
                  fillColor: Colors.blueGrey[50],
                  labelStyle: TextStyle(fontSize: 8),
                  contentPadding: EdgeInsets.only(left: 10),
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
            Padding(
              padding: const EdgeInsets.only(top: 20),
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
                            left: 36, right: 36, top: 18, bottom: 18),
                        primary: Colors.white,
                        textStyle: TextStyle(
                          fontFamily: 'Cairo_SemiBold',
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      child: const Text('PAY'),
                      onPressed: () {
                        if (double.parse(amountTendered.text) < getTotal())
                          return;

                        if (amountTendered.text.isEmpty) {
                          BannerNotif.notif(
                              "Error",
                              "Please fill the amount field",
                              Colors.red.shade600);
                        } else if (amountTendered.text.isEmpty) {
                          BannerNotif.notif(
                            "Error",
                            "Please fill all the fields",
                            Colors.red.shade600,
                          );
                        } else {
                          double left =
                              double.parse(amountTendered.text) - getTotal();
                          setState(() {
                            change.text = left.toString();
                          });

                          //TODO: ADD TO PURCHASE ORDER HERE O THE DB
                          //delay show of receipt to view change
                          Future.delayed(const Duration(seconds: 5), () {
                            searchProduct
                                .customerPurchase(_orderId, widget.sold)
                                .then((value) {
                              //after sending the data print the invoice
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return showInvoice(invoiceContent(_orderId));
                                },
                              );
                            });
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Invoice invoiceContent(String invoiceNumber) {
    return Invoice(
      customer: BorrowerModel.invoice(
        'DELLRAINS',
        'STORE',
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
