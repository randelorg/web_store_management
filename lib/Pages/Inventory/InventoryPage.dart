import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Backend/GlobalController.dart';
import 'package:web_store_management/Backend/ProductOperation.dart';
import 'package:web_store_management/Notification/Snack_notification.dart';
import 'TransferStock.dart';
import 'UpdateProduct.dart';
import '../../Backend/Utility/Mapping.dart';

class InventoryPage extends StatefulWidget {
  @override
  _InventoryPage createState() => _InventoryPage();
}

class _InventoryPage extends State<InventoryPage> {
  var controller = GlobalController();
  var product = ProductOperation();
  late Future _products;

  final TextEditingController barcode = TextEditingController();
  final TextEditingController prodName = TextEditingController();
  final TextEditingController quantity = TextEditingController();
  final TextEditingController unit = TextEditingController();
  final TextEditingController price = TextEditingController();

  @override
  void initState() {
    super.initState();
    //fetches the products from the database
    this._products = controller.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: (MediaQuery.of(context).size.width) / 5,
          height: (MediaQuery.of(context).size.height) / 1.5,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
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
                padding: EdgeInsets.all(6.0),
                child: TextField(
                  controller: barcode,
                  decoration: InputDecoration(
                    hintText: 'Barcode',
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.scanner_sharp),
                      tooltip: 'Scan product barcode',
                    ),
                    filled: true,
                    fillColor: Colors.blueGrey[50],
                    labelStyle: TextStyle(fontSize: 10),
                    contentPadding: EdgeInsets.only(left: 30),
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
                padding: const EdgeInsets.all(6.0),
                child: TextField(
                  controller: prodName,
                  decoration: InputDecoration(
                    hintText: 'Product Name',
                    filled: true,
                    fillColor: Colors.blueGrey[50],
                    labelStyle: TextStyle(fontSize: 12),
                    contentPadding: EdgeInsets.only(left: 30),
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
                padding: const EdgeInsets.all(6.0),
                child: TextField(
                  controller: quantity,
                  decoration: InputDecoration(
                    hintText: 'Quantity',
                    filled: true,
                    fillColor: Colors.blueGrey[50],
                    labelStyle: TextStyle(fontSize: 12),
                    contentPadding: EdgeInsets.only(left: 30),
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
                padding: const EdgeInsets.all(6.0),
                child: TextField(
                  controller: unit,
                  decoration: InputDecoration(
                    hintText: 'Unit',
                    filled: true,
                    fillColor: Colors.blueGrey[50],
                    labelStyle: TextStyle(fontSize: 12),
                    contentPadding: EdgeInsets.only(left: 30),
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
                padding: const EdgeInsets.all(6.0),
                child: TextField(
                  controller: price,
                  decoration: InputDecoration(
                    hintText: 'Price',
                    filled: true,
                    fillColor: Colors.blueGrey[50],
                    labelStyle: TextStyle(fontSize: 12),
                    contentPadding: EdgeInsets.only(left: 30),
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
                padding: const EdgeInsets.all(10.0),
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
                          padding: const EdgeInsets.only(top: 15, bottom: 15, left: 30, right: 30),
                          primary: Colors.white,
                          textStyle: TextStyle(
                              fontFamily: 'Cairo_SemiBold', fontSize: 14),
                        ),
                        child: const Text('ADD'),
                        onPressed: () {
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
                              SnackNotification.notif(
                                'Error',
                                "Product " + prodName.text + " is now added",
                                Colors.green.shade600,
                              );
                              setState(() {
                                this._products = controller.fetchProducts();
                              });
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Stack(
              children: [
                Row( 
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10, left:750),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
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
                              message: 'Transfer Stocks',
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.all(20),
                                  primary: Colors.white,
                                  textStyle: TextStyle(fontSize: 18),
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return TransferStock();
                                    },
                                  );
                                },
                                child: const Text('TRANSFER'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 750),
                      padding: EdgeInsets.only(top: 10, left: 150),
                      width: 500,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search product',
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
                            borderSide:
                                BorderSide(color: Colors.blueGrey.shade50),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueGrey.shade50),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            //the list of products
            tableProducts(),
          ],
        ),
      ],
    );
  }

  Widget tableProducts() {
    return Expanded(
      child: Container(
        width: (MediaQuery.of(context).size.width) / 1.5,
        height: (MediaQuery.of(context).size.height),
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            FutureBuilder(
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
                    rowsPerPage: 15,
                    columns: [
                      DataColumn(label: Text('PRODUCT NAME')),
                      DataColumn(label: Text('QTY')),
                      DataColumn(label: Text('UNIT')),
                      DataColumn(label: Text('PRICE')),
                      DataColumn(label: Text('ACTION')),
                    ],
                    source: _DataSource(context),
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
  );

  final String valueA;
  final Widget valueB;
  final String valueC;
  final String valueD;
  final Widget valueE;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context) {
    _products = _productList(context);
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
                //quantity: row.valueB,
                unit: row.valueC,
                price: row.valueD,
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

  List<_Row> _productList(BuildContext context) {
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
                  padding: EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
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
        );
      });
    }
  }
}

//this will identify if stock is <= 2
//if it reacher 2 stock this will return an icon
//else it will return the stock number
Widget _dangerStock(String stuff) {
  if (int.parse(stuff) > 2) {
    return _parseString(stuff);
  } else {
    return Icon(Icons.warning, color: Colors.red);
  }
}

//this will parse the string and convert
//it to Text Widget
Widget _parseString(String stuff) {
  return Text(stuff);
}
