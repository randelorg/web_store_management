import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';
import 'package:web_store_management/Backend/GlobalController.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Models/ProductModel.dart';
import 'package:web_store_management/Backend/ProductOperation.dart';
import 'package:web_store_management/Pages/Inventory/TransferStock.dart';

class InventoryDashboard extends StatefulWidget {
  @override
  _InventoryDashboard createState() => _InventoryDashboard();
}

class _InventoryDashboard extends State<InventoryDashboard> {
  var _sortAscending = true;
  var controller = GlobalController();
  var prod = ProductOperation();
  late Future<Set<String>> _futureTypes;
  late Future<List<ProductModel>> _products;
  List<ProductModel> _productsFiltered = [];
  final List<String> _filters = [];
  String _searchResult = '';
  bool show = false;
  TextEditingController searchValue = TextEditingController();

  @override
  void initState() {
    //fetches the products
    _products = controller.fetchProducts();
    controller.fetchBranches();
    //fetch logged in branch
    _products.whenComplete(() {
      _productsFiltered = Mapping.productList;
    });
    //get product types
    _futureTypes = getTypes();
    super.initState();
  }

  @override
  void dispose() {
    _filters;
    _products;
    _productsFiltered;
    searchValue.dispose();
    super.dispose();
  }

  //get the product types using SET
  Future<Set<String>> getTypes() async {
    Set<String> types = new Set<String>();
    await _products.whenComplete(() {
      for (ProductModel product in Mapping.productList) {
        types.add(product.getProdType);
      }
    });
    return types;
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
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            //the list of products
            _tableProducts(_productsFiltered),
          ],
        ),
      ],
    );
  }

  Iterable<Widget> productTypeWidget(Set<String> types) {
    return types.map((type) {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ChoiceChip(
          label: Text(type),
          selected: _filters.contains(type),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _filters.add(type);
                _productsFiltered = Mapping.productList
                    .where((product) => product.getProdType == type)
                    .toList();
              } else {
                _filters.removeWhere((name) {
                  _productsFiltered = Mapping.productList;
                  return name == type;
                });
              }
            });
          },
        ),
      );
    });
  }

  Widget _tableProducts(List<ProductModel> products) {
    return Expanded(
      child: Container(
        width: (MediaQuery.of(context).size.width) / 1.3,
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
                    columnSpacing: 45,
                    showCheckboxColumn: false,
                    showFirstLastButtons: true,
                    sortAscending: _sortAscending,
                    sortColumnIndex: 1,
                    rowsPerPage: 14,
                    header: Text('Products'),
                    actions: [
                      //choice chips
                      FutureBuilder<Set<String>>(
                        future: _futureTypes,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          }
                          if (snapshot.hasData) {
                            if (snapshot.data!.length > 0) {
                              return Wrap(
                                  children:
                                      productTypeWidget(snapshot.data!.toSet())
                                          .toList());
                            }
                          }
                          return Text("No product type available");
                        },
                      ),
                      //search button
                      Container(
                        padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 5),
                        width: 350,
                        child: TextField(
                          controller: searchValue,
                          onChanged: (value) {
                            setState(() {
                              _searchResult = value;
                              _productsFiltered = Mapping.productList
                                  .where((product) => product.getProductName
                                      .toLowerCase()
                                      .contains(_searchResult.toLowerCase()))
                                  .toList();
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Search Product',
                            filled: true,
                            fillColor: Colors.blueGrey[50],
                            labelStyle: TextStyle(fontSize: 12),
                            contentPadding: EdgeInsets.only(left: 15),
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
                    columns: [
                      DataColumn(label: Text('PRODUCT \n NAME')),
                      DataColumn(label: Text('PRODUCT \n LABEL')),
                      DataColumn(label: Text('QUANTITY \n ON HAND')),
                      DataColumn(label: Text('QUANTITY \n SOLD')),
                      DataColumn(label: Text('QUANTITY \n RECEIVED')),
                      DataColumn(label: Text('TRANSFER')),
                    ],
                    source:
                        _DataSource(context, getLocations(), _productsFiltered),
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
    this.valueF,
    this.valueG,
    this.valueH,
    this.valueI,
  );

  final String valueA; //product name
  final String valueB; //label
  final Widget valueF; //inventory on hand
  final int valueG; //inventory sol
  final int valueH; //inventory receive
  final Widget valueI; //transfer button

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context, this._branches, this._productsFiltered) {
    _products = _productList(_productsFiltered);
    _branches = _branches;
  }

  final BuildContext context;
  int _selectedCount = 0;
  List<_Row> _products = [];
  List<String> _branches = [];
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
        DataCell(Text(row.valueB)),
        DataCell((row.valueF)),
        DataCell(Text(row.valueG.toString())),
        DataCell(Text(row.valueH.toString())),
        DataCell(row.valueI, onTap: () {
          showModalSideSheet(
            context: context,
            width: MediaQuery.of(context).size.width / 4,
            body: ListView(
              children: [
                TransferStock(
                  branches: _branches,
                  productName: row.valueA,
                  qty: determineWidget(row.valueF),
                ),
              ],
            ),
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

  List<_Row> _productList(List<ProductModel> products) {
    try {
      return List.generate(products.length, (index) {
        return _Row(
          products[index].getProductName.toString(),
          products[index].getProductLabel.toString(),
          _dangerStock(products[index].getInventoryOnHand),
          products[index].getInventorySold,
          products[index].getInventoryReceived,
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
          '',
          Text(''),
          0,
          0,
          Text(''),
        );
      });
    }
  }
}

//this will identify if stock is <= 2
//if it reacher 2 stock this will return an icon
//else it will return the stock number
Widget _dangerStock(int qty) {
  if (qty > 2) {
    return Text(qty.toString());
  }
  return Row(
    children: [
      Icon(Icons.warning, color: Colors.red),
      Text(qty.toString()),
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
