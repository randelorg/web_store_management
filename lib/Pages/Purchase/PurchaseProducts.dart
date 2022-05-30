import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';
import 'package:web_store_management/Backend/CashPaymentOperation.dart';
import 'package:web_store_management/Backend/GlobalController.dart';
import 'package:web_store_management/Backend/PurchasesOperation.dart';
import 'package:web_store_management/Models/IncomingPurchasesModel.dart';
import 'package:web_store_management/Models/ProductModel.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Backend/ProductOperation.dart';
import 'package:web_store_management/Notification/BannerNotif.dart';
import 'package:web_store_management/Pages/Purchase/NewProduct.dart';
import 'package:web_store_management/Pages/Purchase/NewSupplier.dart';

class PurchaseProducts extends StatefulWidget {
  @override
  _PurchaseProducts createState() => _PurchaseProducts();
}

class _PurchaseProducts extends State<PurchaseProducts> {
  var _sortAscending = true;
  var controller = GlobalController();
  var prod = ProductOperation();
  var searchProduct = PurchasesOperation();
  late Future<String> _productName;
  late Future<List<ProductModel>> _products;
  late Future _suppliers;
  late Future<List<IncomingPurchasesModel>> _purchases;
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
    _suppliers = controller.fetchSuppliers();
    _productName = Future.value("");
    _purchases = Future.value([]);
    _suppliers.whenComplete(() => pickedSupplier = getSupplierNames()[0]);
    purchaseOrderId.getInvoiceNumber().then((value) {
      setState(() {
        _orderId = value;
      });
    });
    super.initState();
  }

  //get store available branches
  List<String> getSupplierNames() {
    List<String> suppliers = [];
    suppliers.addAll(Mapping.suppliersList.map((e) => e.getSupplierName));
    return suppliers;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          width: (MediaQuery.of(context).size.width) / 5,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 160, left: 15),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Choose Supplier',
                    style: TextStyle(
                      fontFamily: 'Cairo_Bold',
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              FutureBuilder(
                future: _suppliers,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        semanticsLabel: 'Fetching Suppliers',
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    return Container(
                      width: 350,
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[50],
                        border: Border.all(
                            color: Colors.blueGrey.shade50,
                            style: BorderStyle.solid,
                            width: 0.80),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: pickedSupplier,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: HexColor("#155293")),
                          onChanged: (String? newValue) {
                            setState(() {
                              pickedSupplier = newValue!;
                            });
                          },
                          items: getSupplierNames()
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: Text(
                      'Cant fetch suppliers',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontFamily: 'Cairo_SemiBold',
                        fontSize: 20,
                      ),
                    ),
                  );
                },
              ),
              Center(
                child: TextButton(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 215),
                    child: Text(
                      'New Supplier? Add here.',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Cairo_SemiBold',
                        color: HexColor("#155293"),
                      ),
                    ),
                  ),
                  onPressed: () {
                    showModalSideSheet(
                      context: context,
                      width: MediaQuery.of(context).size.width / 4,
                      body: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: NewSupplier(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              //search products
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Purchase Product',
                    style: TextStyle(
                      fontFamily: 'Cairo_Bold',
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              Container(
                width: 350,
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
              Center(
                child: TextButton(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 215),
                    child: Text(
                      'New Product? Add here.',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Cairo_SemiBold',
                        color: HexColor("#155293"),
                      ),
                    ),
                  ),
                  onPressed: () {
                    showModalSideSheet(
                      context: context,
                      width: MediaQuery.of(context).size.width / 4,
                      body: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: NewProduct(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
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
                              top: 18, bottom: 18, left: 36, right: 36),
                          primary: Colors.white,
                          textStyle: TextStyle(
                              fontFamily: 'Cairo_SemiBold', fontSize: 14),
                        ),
                        child: const Text('Search'),
                        onPressed: () async {
                          if (barcode.text.isEmpty) {
                            BannerNotif.notif(
                                "Error",
                                "Please fill the product barcode field",
                                Colors.red.shade600);
                          } else {
                            searchProduct
                                .getProductInfo(barcode.text)
                                .then((value) {
                              setState(() {
                                _productName = Future.value(value);
                              });
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              FutureBuilder<String>(
                future: _productName,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        semanticsLabel: 'Fetching product name',
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    productName.text = snapshot.data.toString();
                    return Container(
                      padding: const EdgeInsets.only(top: 30, bottom: 10),
                      width: 350,
                      child: TextField(
                        controller: productName,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: 'Product Name',
                          filled: true,
                          fillColor: Colors.blueGrey[50],
                          labelStyle: TextStyle(fontSize: 12),
                          contentPadding: EdgeInsets.only(left: 15),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueGrey.shade50),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueGrey.shade50),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    );
                  }
                  return Center(child: Text("Product name"));
                },
              ),
              Container(
                width: 350,
                child: TextField(
                  controller: qty,
                  decoration: InputDecoration(
                    hintText: 'Product Quantity',
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
              Padding(
                padding: const EdgeInsets.all(15),
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
                              top: 18, bottom: 18, left: 36, right: 36),
                          primary: Colors.white,
                          textStyle: TextStyle(
                              fontFamily: 'Cairo_SemiBold', fontSize: 14),
                        ),
                        child: const Text('Add'),
                        onPressed: () async {
                          if (barcode.text.isEmpty || qty.text.isEmpty) {
                            BannerNotif.notif(
                              "Error",
                              "Please fill all the fields",
                              Colors.red.shade600);
                          } else {
                            _purchases = searchProduct.addToPurchaseTable(
                              barcode.text,
                              int.parse(qty.text),
                              Mapping.dateToday(),
                            );

                            _purchases.whenComplete(() {
                              setState(() {
                                _purchases = _purchases;
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
        ),
        Container(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: const VerticalDivider(
                  color: Colors.grey,
                  thickness: 1,
                  indent: 80,
                  endIndent: 80,
                  width: 10,
                ),
              ),
            ],
          ),
        ),

        //the list of products
        Column(
          children: [_tablePurchases()],
        ),
      ],
    );
  }

  Widget _tablePurchases() {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: (MediaQuery.of(context).size.width / 1.4),
          height: (MediaQuery.of(context).size.height / 1.5),
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
                                        right: 36),
                                    primary: Colors.white,
                                    textStyle: TextStyle(
                                        fontFamily: 'Cairo_SemiBold',
                                        fontSize: 14),
                                  ),
                                  child: const Text('ADD TO PURCHASE ORDER'),
                                  onPressed: () async {
                                    //TODO: ADD TO PURCHASE ORDER HERE O THE DB
                                    searchProduct
                                        .sendToIncomingProducts(
                                            _orderId, pickedSupplier)
                                        .then((value) {
                                      BannerNotif.notif(
                                        'Success',
                                        'New order added',
                                        Colors.green.shade600,
                                      );
                                      Mapping.purchases.clear();
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
                            padding: const EdgeInsets.only(right: 40),
                            child: Text(_orderId.toUpperCase()),
                          ),
                          Text(Mapping.dateToday()),
                        ],
                      ),
                      showCheckboxColumn: false,
                      showFirstLastButtons: true,
                      sortAscending: _sortAscending,
                      sortColumnIndex: 1,
                      rowsPerPage: 10,
                      columns: [
                        DataColumn(label: Text('BARCODE')),
                        DataColumn(label: Text('PRODUCT NAME')),
                        DataColumn(label: Text('QTY')),
                      ],
                      source: _DataSource(context, snapshot.data!.toList()),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      semanticsLabel: 'Fetching products',
                    ),
                  );
                },
              ),
            ],
          ),
        ),
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
  final int valueC;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context, this._purchasesProducts) {
    _products = _productList(_purchasesProducts);
  }

  final BuildContext context;
  int _selectedCount = 0;
  List<_Row> _products = [];
  List<IncomingPurchasesModel> _purchasesProducts = [];

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _products.length) return null;
    final row = _products[index];
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
      ],
    );
  }

  @override
  int get rowCount => _products.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  List<_Row> _productList(List<IncomingPurchasesModel> _purchasesProducts) {
    try {
      print(_purchasesProducts.length);
      return List.generate(_purchasesProducts.length, (index) {
        return _Row(
          _purchasesProducts[index].getProductCode,
          _purchasesProducts[index].getProductName,
          _purchasesProducts[index].getQty,
        );
      });
    } catch (e) {
      //if product list is empty
      return List.generate(0, (index) {
        return _Row(
          '',
          '',
          0,
        );
      });
    }
  }
}
