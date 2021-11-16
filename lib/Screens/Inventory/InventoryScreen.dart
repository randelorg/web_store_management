import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Backend/GlobalController.dart';
import 'TransferStock.dart';
import 'UpdateProduct.dart';
import '../../Backend/Utility/Mapping.dart';

class InventoryScreen extends StatefulWidget {
  @override
  _InventoryScreen createState() => _InventoryScreen();
}

class _InventoryScreen extends State<InventoryScreen> {
  var controller = GlobalController();

  @override
  void initState() {
    super.initState();
    //get all the admin account and compare
    //in-app authentication of users
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: (MediaQuery.of(context).size.width) / 5,
          height: (MediaQuery.of(context).size.height) / 2,
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
                      overflow: TextOverflow.fade),
                  maxLines: 2,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(6.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Barcode',
                    suffixIcon: IconButton(
                      onPressed: () {
                        // showDialog(
                        //   context: context,
                        //   builder: (BuildContext context) {
                        //     return BarcodeReader();
                        //   },
                        // );
                      },
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
                padding: const EdgeInsets.all(6.0),
                child: TextField(
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
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
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
                          padding: const EdgeInsets.all(13.0),
                          primary: Colors.white,
                          textStyle: TextStyle(
                              fontFamily: 'Cairo_SemiBold', fontSize: 14),
                        ),
                        onPressed: () {},
                        child: const Text('ADD'),
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
                      padding: EdgeInsets.only(top: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey.shade50,
                                ),
                              ),
                            ),
                            Tooltip(
                              message: 'Transfer Stocks',
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.all(20),
                                  primary: Colors.black,
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
            Expanded(
              child: Container(
                width: (MediaQuery.of(context).size.width) / 1.5,
                height: (MediaQuery.of(context).size.height),
                child: ListView(
                  padding: const EdgeInsets.all(10),
                  children: [
                    PaginatedDataTable(
                      showCheckboxColumn: false,
                      rowsPerPage: 15,
                      columns: [
                        DataColumn(label: Text('PRODUCT NAME')),
                        DataColumn(label: Text('QTY')),
                        DataColumn(label: Text('PRICE')),
                        DataColumn(label: Text('ACTION')),
                      ],
                      source: _DataSource(context),
                    )
                  ],
                ),
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
    this.valueD,
  );

  final String valueA;
  final Widget valueB;
  final String valueC;
  final Widget valueD;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context) {
    _productList(context);
  }

  final BuildContext context;
  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _productList(context).length) return null;
    final row = _productList(context)[index];
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
        DataCell((row.valueD)),
      ],
    );
  }

  @override
  int get rowCount => _productList(context).length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
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

List _productList(BuildContext context) {
  List<_Row> _products;

  return _products = List.generate(Mapping.productList.length, (index) {
    return _Row(
      Mapping.productList[index].getProductName.toString(),
      _dangerStock(Mapping.productList[index].getProductQty.toString()),
      Mapping.productList[index].getProductPrice.toStringAsFixed(2).toString(),
      ClipRRect(
        borderRadius: BorderRadius.circular(18),
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
                padding: const EdgeInsets.all(13.0),
                primary: Colors.white,
                textStyle:
                    TextStyle(fontFamily: 'Cairo_SemiBold', fontSize: 14),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return UpdateProduct();
                    });
              },
              child: const Text('UPDATE'),
            ),
          ],
        ),
      ),
    );
  });
}
