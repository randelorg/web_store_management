import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Backend/GlobalController.dart';
import 'package:web_store_management/Backend/ProductOperation.dart';
import 'package:web_store_management/Backend/Session.dart';
import 'package:web_store_management/Models/ProductModel.dart';
import 'package:web_store_management/Notification/BannerNotif.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'TransferStock.dart';
import 'UpdateProduct.dart';
import '../../Backend/Utility/Mapping.dart';

class InventoryPage extends StatefulWidget {
  @override
  _InventoryPage createState() => _InventoryPage();
}

class _InventoryPage extends State<InventoryPage> {
  var _sortAscending = true;
  var controller = GlobalController();
  var product = ProductOperation();
  late Future<List<ProductModel>> _products;

  final TextEditingController barcode = TextEditingController();
  final TextEditingController prodName = TextEditingController();
  final TextEditingController quantity = TextEditingController();
  final TextEditingController unit = TextEditingController();
  final TextEditingController price = TextEditingController();

  @override
  void initState() {
    //fetches the products from the database
    this._products = controller.fetchProducts();
    controller.fetchBranches();
    super.initState();
  }

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
                  'Add Product',
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
                padding: EdgeInsets.all(6),
                child: TextField(
                  controller: barcode,
                  decoration: InputDecoration(
                    hintText: 'Barcode',
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.scanner_sharp),
                      tooltip: 'Scan Product Barcode',
                    ),
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
                  controller: prodName,
                  decoration: InputDecoration(
                    hintText: 'Product Name',
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
                padding: const EdgeInsets.all(6),
                child: TextField(
                  controller: quantity,
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
                padding: const EdgeInsets.all(6),
                child: TextField(
                  controller: unit,
                  decoration: InputDecoration(
                    hintText: 'Unit',
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
                padding: const EdgeInsets.all(6),
                child: TextField(
                  controller: price,
                  decoration: InputDecoration(
                    hintText: 'Price',
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
                        child: const Text('ADD'),
                        onPressed: () {
                          if (barcode.text.isEmpty ||
                              prodName.text.isEmpty ||
                              quantity.text.isEmpty ||
                              unit.text.isEmpty ||
                              price.text.isEmpty) {
                            BannerNotif.notif(
                                "Error",
                                "Please fill all the fields",
                                Colors.red.shade600);
                          } else {
                            product
                                .addProduct(
                              barcode.text,
                              prodName.text,
                              quantity.text,
                              unit.text,
                              double.parse(price.text),
                            )
                                .then((value) {
                              if (value) {
                                BannerNotif.notif(
                                  'Success',
                                  "Product " + prodName.text + " is now added",
                                  Colors.green.shade600,
                                );
                                setState(() {
                                  this._products = controller.fetchProducts();
                                });
                              }
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
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: HexColor("#155293"),
                            ),
                          ),
                        ),
                        Tooltip(
                          message: 'not available',
                          child: TextButton.icon(
                            icon: Icon(
                              Icons.transfer_within_a_station,
                              color: Colors.white,
                            ),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(14),
                              primary: Colors.white,
                              onSurface:
                                  Colors.white, //remove it if enable the button
                              textStyle: TextStyle(
                                  fontSize: 18, fontFamily: 'Cairo_SemiBold'),
                            ),
                            label: Text('TRANSFER'),
                            onPressed: null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 15, left: 20, right: 5),
                  width: 350,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search Product',
                      suffixIcon: InkWell(
                        child: IconButton(
                          icon: Icon(Icons.search_sharp),
                          color: Colors.grey,
                          tooltip: 'Search by Name',
                          onPressed: () {},
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.blueGrey[50],
                      labelStyle: TextStyle(fontSize: 12),
                      contentPadding: EdgeInsets.only(left: 30),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey.shade50),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey.shade50),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //the list of products
            _tableProducts(),
          ],
        ),
      ],
    );
  }

  Widget _tableProducts() {
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
                      DataColumn(label: Text('PRODUCT NAME')),
                      DataColumn(
                        label: Text('QTY'),
                        onSort: (index, sortAscending) {
                          setState(() {
                            _sortAscending = sortAscending;
                            if (sortAscending) {
                              snapshot.data!.sort((a, b) =>
                                  a.getProductQty.compareTo(b.getProductQty));
                            } else {
                              snapshot.data!.sort((a, b) =>
                                  b.getProductQty.compareTo(a.getProductQty));
                            }
                          });
                        },
                      ),
                      DataColumn(label: Text('UNIT')),
                      DataColumn(label: Text('PRICE')),
                      DataColumn(label: Text('ACTION')),
                      DataColumn(
                        label: Text(
                          'TRANSFER \n STOCKS',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                    source: _DataSource(context, getLocations()),
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
  _DataSource(this.context, List<String> branches) {
    _products = _productList();
    _branches = branches;
  }

  final BuildContext context;
  int _selectedCount = 0;
  List<_Row> _products = [];
  List<String> _branches = [];

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
        DataCell((row.valueE), onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return UpdateProduct(
                name: row.valueA,
                quantity: determineWidget(row.valueB),
                unit: row.valueC,
                price: row.valueD,
              );
            },
          );
        }),
        DataCell((row.valueF), onTap: () async {
          String branch = '';
          await Session.getBranch().then((branchName) {
            branch = branchName;
          });

          if (branch != 'Main') {
            BannerNotif.notif(
              'Invalid Action',
              'Main branch has the ability to transfer product',
              Colors.red.shade600,
            );
            return;
          }

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return TransferStock(
                branches: _branches,
                productName: row.valueA,
                qty: determineWidget(row.valueB),
              );
            },
          );
        }),
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
      return List.generate(Mapping.productList.length, (index) {
        return _Row(
          Mapping.productList[index].getProductName.toString(),
          _dangerStock(Mapping.productList[index].getProductQty.toString()),
          Mapping.productList[index].getProductUnit.toString(),
          Mapping.productList[index].getProductPrice
              .toStringAsFixed(2)
              .toString(),
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

//this will identify if stock is <= 2
//if it reacher 2 stock this will return an icon
//else it will return the stock number
Widget _dangerStock(String qty) {
  String temp = qty;
  if (int.parse(qty) > 2) {
    return Text(qty);
  }

  return Row(
    children: [
      Text(qty),
      Icon(Icons.warning, color: Colors.red),
    ],
  );
}

String determineWidget(widget) {
  if (widget is Row) {
    return '<= 2';
  }
  //get data from the TEXT widget
  Text txt = widget;

  return txt.data.toString();
}
