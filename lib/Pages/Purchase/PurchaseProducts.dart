import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';
import 'package:web_store_management/Backend/GlobalController.dart';
import 'package:web_store_management/Backend/Session.dart';
import 'package:web_store_management/Models/ProductModel.dart';
import 'package:web_store_management/Notification/BannerNotif.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Backend/ProductOperation.dart';
import 'package:web_store_management/Pages/Inventory/UpdateProduct.dart';
import '../../Backend/Utility/Mapping.dart';

class PurchaseProducts extends StatefulWidget {
  @override
  _PurchaseProducts createState() => _PurchaseProducts();
}

class _PurchaseProducts extends State<PurchaseProducts> {
  var _sortAscending = true;
  var controller = GlobalController();
  var prod = ProductOperation();
  late Future<Set<String>> _futureTypes;
  late Future<List<ProductModel>> _products;
  late Future<bool> _supplierAddStatus;
  List<ProductModel> _productsFiltered = [];
  final List<String> _filters = [];
  String _searchResult = '', _prodType = '', _prodSupplier = '';
  bool show = false;
  TextEditingController searchValue = TextEditingController();
  List<TextEditingController> productTextfields =
      List.generate(5, (i) => TextEditingController());
  List<TextEditingController> supplierTexFields =
      List.generate(3, (i) => TextEditingController());

  @override
  void initState() {
    //fetches the products
    _products = controller.fetchProducts();
    _supplierAddStatus = Future.value(false);
    controller.fetchBranches();
    //fetch logged in branch
    _products.whenComplete(() {
      _productsFiltered = Mapping.productList;
    });
    super.initState();
  }

  //get store available branches
  List<String> getLocations() {
    List<String> branches = [];
    branches.addAll(Mapping.branchList.map((e) => e.branchName));
    return branches;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: (MediaQuery.of(context).size.width) / 5,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 120),
                child: Text(
                  'Purchase product',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: HexColor("#155293"),
                    fontFamily: 'Cairo_Bold',
                    fontSize: 30,
                    overflow: TextOverflow.fade,
                  ),
                  maxLines: 2,
                ),
              ),
              Padding(
                //scan barcode or manually enter barcode
                padding: EdgeInsets.all(6),
                child: TextField(
                  controller: productTextfields[0],
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
              Padding(
                padding: const EdgeInsets.all(6),
                child: TextField(
                  controller: productTextfields[2],
                  decoration: InputDecoration(
                    hintText: 'Quantity',
                    filled: true,
                    fillColor: Colors.blueGrey[50],
                    labelStyle: TextStyle(fontSize: 12),
                    contentPadding: EdgeInsets.only(left: 15),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade50),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade50),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
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
                              top: 18, bottom: 18, left: 36, right: 36),
                          primary: Colors.white,
                          textStyle: TextStyle(
                              fontFamily: 'Cairo_SemiBold', fontSize: 14),
                        ),
                        child: const Text('NEXT'),
                        onPressed: () async {
                          for (var x in productTextfields) {
                            if (x.text.isEmpty) {
                              BannerNotif.notif(
                                "Error",
                                "Please fill all the fields",
                                Colors.red.shade600,
                              );
                              return;
                            }
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
                padding: const EdgeInsets.only(left: 25, right: 25),
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
        _tableProducts(_productsFiltered),
      ],
    );
  }

  void proccessProduct() {
    prod
        .addProduct(
      productTextfields[0].text,
      productTextfields[1].text,
      productTextfields[2].text,
      productTextfields[3].text,
      double.parse(productTextfields[4].text),
      _prodType,
      supplierTexFields[0].text,
    )
        .then((value) {
      if (value) {
        BannerNotif.notif(
          'Success',
          "Product " + productTextfields[1].text + " is now added",
          Colors.green.shade600,
        );
        Navigator.pop(context);
      }
    });
  }

  Widget _tableProducts(List<ProductModel> products) {
    return Expanded(
      child: Container(
        width: (MediaQuery.of(context).size.width) / 1.5,
        height: (MediaQuery.of(context).size.height),
        child: ListView(
          children: [
            FutureBuilder<List<ProductModel>>(
              future: this._products,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      semanticsLabel: 'Fetching products',
                    ),
                  );
                }
                if (snapshot.hasData) {
                  return PaginatedDataTable(
                    showCheckboxColumn: false,
                    showFirstLastButtons: true,
                    sortAscending: _sortAscending,
                    sortColumnIndex: 1,
                    rowsPerPage: 14,
                    columns: [
                      DataColumn(label: Text('BARCODE')),
                      DataColumn(label: Text('SUPPLIER NAME')),
                      DataColumn(label: Text('PRODUCT NAME')),
                      DataColumn(label: Text('QTY')),
                      DataColumn(label: Text('UNIT')),
                      DataColumn(label: Text('PRICE')),
                    ],
                    source: _DataSource(context, _productsFiltered),
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
  );

  final String valueA;
  final valueB;
  final String valueC;
  final String valueD;
  final Widget valueE;
  final Widget valueF;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context, this._productsFiltered) {
    _products = _productList(_productsFiltered);
  }

  final BuildContext context;
  int _selectedCount = 0;
  List<_Row> _products = [];
  List<ProductModel> _productsFiltered = [];

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
        DataCell((row.valueB)),
        DataCell(Text(row.valueC)),
        DataCell(Text(row.valueD)),
        DataCell((row.valueE)),
        DataCell((row.valueF)),
      ],
    );
  }

  @override
  int get rowCount => _products.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  List<_Row> _productList(List<ProductModel> products) {
    try {
      return List.generate(products.length, (index) {
        return _Row(
          products[index].getProductName.toString(),
          2.toString(),
          products[index].getProductUnit.toString(),
          products[index].getProductPrice.toStringAsFixed(2).toString(),
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
                    'UPDATE',
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
                  child: Icon(
                    Icons.transfer_within_a_station,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ],
            ),
          ),
        );
      });
    } catch (e) {
      //if product list is empty
      return List.generate(0, (index) {
        return _Row(
          '',
          Text(''),
          '',
          '',
          Text(''),
          Text(''),
        );
      });
    }
  }
}
