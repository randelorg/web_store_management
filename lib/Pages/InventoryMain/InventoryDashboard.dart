import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';
import 'package:web_store_management/Backend/GlobalController.dart';
import 'package:web_store_management/Backend/Session.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Models/ProductModel.dart';
import 'package:web_store_management/Backend/ProductOperation.dart';
import 'package:web_store_management/Notification/BannerNotif.dart';
import 'package:web_store_management/Pages/InventoryMain/InventoryBranch.dart';
import 'package:web_store_management/Pages/InventoryMain/TransferStock.dart';

class InventoryDashboard extends StatefulWidget {
  @override
  _InventoryDashboard createState() => _InventoryDashboard();

  final String mainBranchName = 'Dellrains Main';
}

class _InventoryDashboard extends State<InventoryDashboard> {
  var _sortAscending = true;
  var controller = GlobalController();
  var prod = ProductOperation();
  late Future<Set<String>> _futureTypes;
  late Future<List<ProductModel>> _products;
  late Future<bool> isMain;
  List<ProductModel> _productsFiltered = [];
  final List<String> _filters = [];
  String _searchResult = '', branchName = '';
  bool show = false;
  TextEditingController searchValue = TextEditingController();

  @override
  void initState() {
    isMain = Future.value(false);
    isMainBranch();

    _products = Future.value([]);
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

  Future<void> isMainBranch() async {
    await Session.getBranch().then((branch) {
      setState(() {
        branchName = branch;
        if (branch != widget.mainBranchName) {
          isMain = Future.value(false);
        } else {
          isMain = Future.value(true);
          _products = controller.fetchProducts();
        }
      });
    });
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
            FutureBuilder<bool>(
              future: isMain,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator.adaptive();
                }

                if (snapshot.hasData) {
                  if (snapshot.data == true) {
                    return _tableProducts(_productsFiltered);
                  } else {
                    return InventoryBranch();
                  }
                }

                return CircularProgressIndicator.adaptive();
              },
            ),
          ],
        ),
      ],
    );
  }

  Iterable<Widget> productTypeWidget(Set<String> types) {
    return types.map((type) {
      return Padding(
        padding: const EdgeInsets.only(right: 10),
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
                  if (snapshot.data!.isNotEmpty) {
                    return PaginatedDataTable(
                      columnSpacing: 45,
                      showCheckboxColumn: false,
                      showFirstLastButtons: true,
                      sortAscending: _sortAscending,
                      sortColumnIndex: 1,
                      rowsPerPage: 14,
                      header: Text(
                        'Product List',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontFamily: 'Cairo_Bold'),
                      ),
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
                                    children: productTypeWidget(
                                            snapshot.data!.toSet())
                                        .toList());
                              }
                            }
                            return Text("No product type available");
                          },
                        ),
                        //search button
                        Container(
                          padding: const EdgeInsets.only(left: 20, right: 5),
                          width: 300,
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
                              suffixIcon: Icon(Icons.search_rounded),
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
                      source: _DataSource(
                          context, getLocations(), _productsFiltered),
                    );
                  } else {
                    return Center(
                      child: Text("No products available"),
                    );
                  }
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
  final Widget valueG; //inventory sold
  final int valueH; //inventory receive
  final Widget valueI; //transfer button

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context, this._branches, this._productsFiltered) {
    _products = _productList(_productsFiltered, context);
    _branches = _branches;
  }

  final BuildContext context;
  int _selectedCount = 0;
  List<_Row> _products = [];
  List<String> _branches = [];
  List<ProductModel> _productsFiltered = [];
  var x = ProductOperation();

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
        DataCell(Text(row.valueA), showEditIcon: true, onTap: () {
          showModalSideSheet(
            context: context,
            width: MediaQuery.of(context).size.width / 4,
            body: ListView(
              children: [
                UpdateProduct(
                    supplierName: Mapping.productList
                        .firstWhere(
                            (product) => product.getProductName == row.valueA)
                        .getSupplierName,
                    supplierMobile: Mapping.productList
                        .firstWhere(
                            (product) => product.getProductName == row.valueA)
                        .getSupplierMobile,
                    supplierWebsite: Mapping.productList
                        .firstWhere(
                            (product) => product.getProductName == row.valueA)
                        .getSupplierWebsite,
                    barcode: Mapping.productList
                        .firstWhere(
                            (product) => product.getProductName == row.valueA)
                        .getProductCode,
                    name: row.valueA,
                    price: Mapping.productList
                        .firstWhere(
                            (product) => product.getProductName == row.valueA)
                        .getProductPrice
                        .toString(),
                    label: row.valueB,
                    unit: Mapping.productList
                        .firstWhere(
                            (product) => product.getProductName == row.valueA)
                        .getProductUnit),
              ],
            ),
          );
        }),
        DataCell(Text(row.valueB)),
        DataCell((row.valueF)),
        DataCell((row.valueG)),
        DataCell(Text(row.valueH.toString())),
        DataCell(row.valueI, onTap: () async {
          await getQty(row.valueA).then((value) {
            showModalSideSheet(
              context: context,
              width: MediaQuery.of(context).size.width / 4,
              body: ListView(
                children: [
                  TransferStock(
                    branches: _branches,
                    productName: row.valueA,
                    qty: value,
                  ),
                ],
              ),
            );
          });
        }),
      ],
    );
  }

  Future<String> getQty(String productname) async {
    String qty = '';
    await x.getBranchOnHandProducts(getBarcode(productname)).then((value) {
      qty = value.toString();
    });
    return qty;
  }

  String getBarcode(productname) {
    var barcode = '';
    _productsFiltered.forEach((element) {
      if (element.getProductName == productname) {
        barcode = element.getProductCode;
      }
    });

    return barcode;
  }

  @override
  int get rowCount => _products.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  List<_Row> _productList(List<ProductModel> products, BuildContext context) {
    try {
      return List.generate(products.length, (index) {
        return _Row(
          products[index].getProductName.toString(),
          products[index].getProductLabel.toString(),
          FutureBuilder(
            future: x.getBranchOnHandProducts(products[index].getProductCode),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                return _dangerStock(Text(snapshot.data.toString()));
              }
              return Text('0');
            },
          ),
          FutureBuilder(
            future: x.getBranchSoldProducts(products[index].getProductCode),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                return Text(snapshot.data.toString());
              }
              return Text('0');
            },
          ),
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
      print(e.toString());
      //if product list is empty
      return List.generate(0, (index) {
        return _Row(
          '',
          '',
          Text(''),
          Text(''),
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
Widget _dangerStock(widget) {
  Text txt = widget;
  final int dangerStock = 2;
  int qty = int.parse(txt.data.toString());

  if (qty > dangerStock) {
    return Text(qty.toString());
  }
  return Row(
    children: [
      Icon(Icons.warning, color: Colors.red),
      Text(qty.toString()),
    ],
  );
}

class UpdateProduct extends StatefulWidget {
  final String? barcode, name, price, unit, label;
  final String? supplierName, supplierMobile, supplierWebsite;
  UpdateProduct({
    Key? key,
    required this.barcode,
    required this.name,
    required this.price,
    required this.label,
    required this.unit,
    required this.supplierName,
    required this.supplierMobile,
    required this.supplierWebsite,
  }) : super(key: key);

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  var product = ProductOperation();
  var productName = TextEditingController();
  var productPrice = TextEditingController();
  var productLabel = TextEditingController();
  var productUnit = TextEditingController();
  var suppmobile = TextEditingController();
  var suppwebsite = TextEditingController();

  @override
  void initState() {
    productName.text = widget.name.toString();
    productPrice.text = widget.price.toString();
    productLabel.text = widget.label.toString();
    productUnit.text = widget.unit.toString();
    suppmobile.text = widget.supplierMobile.toString();
    suppwebsite.text = widget.supplierWebsite.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                'Update ${widget.name}',
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: HexColor("#155293"),
                  fontFamily: 'Cairo_Bold',
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 2),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Product Name',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: TextField(
                controller: productName,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.edit),
                  hintText: '',
                  filled: true,
                  fillColor: Colors.blueGrey[50],
                  labelStyle: TextStyle(fontSize: 10),
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
                  'Product Unit',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: TextField(
                controller: productUnit,
                maxLength: 12,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.edit),
                  counterText: '',
                  hintText: 'Mobile Number',
                  filled: true,
                  fillColor: Colors.blueGrey[50],
                  labelStyle: TextStyle(fontSize: 10),
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
                  'Product Label',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: TextField(
                controller: productLabel,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.edit),
                  hintText: '',
                  filled: true,
                  fillColor: Colors.blueGrey[50],
                  labelStyle: TextStyle(fontSize: 10),
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
                  'Product Price',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: TextField(
                controller: productPrice,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.edit),
                  hintText: '',
                  filled: true,
                  fillColor: Colors.blueGrey[50],
                  labelStyle: TextStyle(fontSize: 10),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 80),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Container(
                            decoration:
                                BoxDecoration(color: HexColor("#155293")),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 15, bottom: 15),
                            primary: Colors.white,
                            textStyle: TextStyle(
                              fontFamily: 'Cairo_SemiBold',
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          child: const Text('UPDATE'),
                          onPressed: () {
                            if (productName.text.isEmpty ||
                                productLabel.text.isEmpty ||
                                productPrice.text.isEmpty ||
                                productUnit.text.isEmpty) {
                              BannerNotif.notif(
                                  'Error',
                                  'Please fill all the fields',
                                  Colors.red.shade600);
                            } else {
                              product
                                  .updateProductDetails(
                                widget.barcode.toString(),
                                productName.text,
                                productLabel.text,
                                productUnit.text,
                                double.parse(productPrice.text),
                              )
                                  .then((value) {
                                if (value) {
                                  Navigator.pop(context);
                                  BannerNotif.notif(
                                    'Success',
                                    "Product " +
                                        productName.text +
                                        " is updated",
                                    Colors.green.shade600,
                                  );
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
            Text(
              'Update Supplier: ${widget.supplierName}',
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: HexColor("#155293"),
                fontFamily: 'Cairo_Bold',
                fontSize: 25,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 2),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Supplier Mobile',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: TextField(
                controller: suppmobile,
                maxLength: 12,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.edit),
                  counterText: '',
                  hintText: 'Mobile Number',
                  filled: true,
                  fillColor: Colors.blueGrey[50],
                  labelStyle: TextStyle(fontSize: 10),
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
                  'Supplier Website',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: TextField(
                controller: suppwebsite,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.edit),
                  hintText: '',
                  filled: true,
                  fillColor: Colors.blueGrey[50],
                  labelStyle: TextStyle(fontSize: 10),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Container(
                            decoration:
                                BoxDecoration(color: HexColor("#155293")),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 15, bottom: 15),
                            primary: Colors.white,
                            textStyle: TextStyle(
                              fontFamily: 'Cairo_SemiBold',
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          child: const Text('UPDATE'),
                          onPressed: () {
                            if (suppmobile.text.isEmpty ||
                                suppwebsite.text.isEmpty) {
                              BannerNotif.notif(
                                  'Error',
                                  'Please fill all the fields',
                                  Colors.red.shade600);
                            } else {
                              product
                                  .updateSupplier(
                                widget.supplierName.toString(),
                                suppmobile.text,
                                suppwebsite.text,
                              )
                                  .then((value) {
                                if (value) {
                                  Navigator.pop(context);
                                  BannerNotif.notif(
                                    'Success',
                                    "Supplier ${widget.supplierName} is updated",
                                    Colors.green.shade600,
                                  );
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
          ],
        ),
      ),
    );
  }
}
