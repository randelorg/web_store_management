import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Backend/GlobalController.dart';
import 'package:web_store_management/Models/IncomingPurchasesModel.dart';
import 'package:web_store_management/Models/ProductModel.dart';
import 'package:web_store_management/Notification/BannerNotif.dart';
import 'package:web_store_management/Backend/utility/Mapping.dart';
import 'package:web_store_management/Backend/ProductOperation.dart';

class IncomingPurchases extends StatefulWidget {
  @override
  _IncomingPurchases createState() => _IncomingPurchases();
}

class _IncomingPurchases extends State<IncomingPurchases> {
  var _sortAscending = true;
  var controller = GlobalController();
  var prod = ProductOperation();
  late Future<Set<String>> _futureTypes;
  late Future<List<IncomingPurchasesModel>> _incomingPurchases;
  late Future<bool> _supplierAddStatus;
  List<IncomingPurchasesModel> _incomingFiltered = [];
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
    _incomingPurchases = controller.fetchIncomingPurchases();
    _supplierAddStatus = Future.value(false);
    controller.fetchBranches();
    //fetch logged in branch
    _incomingPurchases.whenComplete(() {
      _incomingFiltered = Mapping.incomingPurchases;
    });
    //get product types
    _futureTypes = getTypes();
    super.initState();
  }

  //get the product types using SET
  Future<Set<String>> getTypes() async {
    Set<String> types = new Set<String>();
    await _incomingPurchases.whenComplete(() {
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
            Row(
              children: [
                FutureBuilder<Set<String>>(
                  future: _futureTypes,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    if (snapshot.hasData) {
                      if (snapshot.data!.length > 0) {
                        return Wrap(
                            children: productTypeWidget(snapshot.data!.toSet())
                                .toList());
                      }
                    }
                    return Text("No product type available");
                  },
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 15, left: 20, right: 5),
                  width: 350,
                  child: TextField(
                    controller: searchValue,
                    onChanged: (value) {
                      setState(() {
                        _searchResult = value;
                        _incomingFiltered = Mapping.incomingPurchases
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
            _tableProducts(_incomingFiltered),
          ],
        ),
      ],
    );
  }

  Iterable<Widget> productTypeWidget(Set<String> types) {
    return types.map((type) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: FilterChip(
          label: Text(type),
          selected: _filters.contains(type),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _filters.add(type);
                _incomingFiltered = Mapping.incomingPurchases
                    .where((product) => product.getProdType == type)
                    .toList();
              } else {
                _filters.removeWhere((name) {
                  _incomingFiltered = Mapping.incomingPurchases;
                  return name == type;
                });
              }
            });
          },
        ),
      );
    });
  }

  Widget _pickSupplier(context) {
    return Column(children: [
      //preview of product details
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(
          'Preview Product Details',
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
        padding: const EdgeInsets.all(6),
        child: TextField(
          controller: productTextfields[1],
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
        padding: const EdgeInsets.all(6),
        child: TextField(
          controller: productTextfields[3],
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
          controller: productTextfields[4],
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

      //Supplier Details
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(
          'Supplier Details',
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
        padding: EdgeInsets.only(top: 20, bottom: 10, left: 15),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
              "Type the supplier and click the suggested supplier if there is one"),
        ),
      ),
      FutureBuilder<Set<String>>(
        future: _futureTypes,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            return SizedBox(
              width: 400,
              child: Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text == '') {
                    return const Iterable<String>.empty();
                  }
                  return snapshot.data!.where((String option) {
                    return option
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase());
                  });
                },
                onSelected: (String selection) {
                  _prodSupplier = selection;
                },
              ),
            );
          }
          return Text("No product type available");
        },
      ),
      Padding(
        padding: EdgeInsets.only(top: 30, bottom: 10, left: 15),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text("If not exisiting, add new supplier"),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(6),
        child: TextField(
          controller: supplierTexFields[0],
          decoration: InputDecoration(
            hintText: 'Supplier preffered name',
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
          controller: supplierTexFields[1],
          decoration: InputDecoration(
            hintText: 'Mobile number',
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
          controller: supplierTexFields[2],
          decoration: InputDecoration(
            hintText: 'Website',
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
                child: const Text('ADD PRODUCT + SUPPLIER'),
                onPressed: () async {
                  if (_prodSupplier.trim().isEmpty) {
                    prod
                        .addSupplier(
                            supplierTexFields[0].text,
                            supplierTexFields[1].text,
                            supplierTexFields[2].text)
                        .then((value) {
                      if (value) {
                        proccessProduct();
                        return;
                      }
                    });
                  } else {
                    proccessProduct();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    ]);
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
        setState(() {
          this._incomingPurchases = controller.fetchIncomingPurchases();
          _incomingPurchases.whenComplete(() {
            _incomingFiltered = Mapping.incomingPurchases;
            _futureTypes = getTypes();
          });
        });
        Navigator.pop(context);
      }
    });
  }

  Widget _tableProducts(List<ProductModel> products) {
    return Expanded(
      child: Container(
        width: (MediaQuery.of(context).size.width) / 1.3,
        height: (MediaQuery.of(context).size.height),
        child: ListView(
          children: [
            FutureBuilder<List<IncomingPurchasesModel>>(
              future: this._incomingPurchases,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      semanticsLabel: 'Fetching incoming purchases',
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
                    columns: [
                      DataColumn(label: Text('PURCHASE DATE')),
                      DataColumn(label: Text('PRODUCT CODE')),
                      DataColumn(label: Text('NUMBER RECEIVED')),
                      DataColumn(label: Text('SUPPLIER ID')),
                    ],
                    source:
                        _DataSource(context, getLocations(), _incomingFiltered),
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
    this.valueE,
    this.valueF,
  );

  final String valueA; //purchase date
  final String valueB; //product name
  final int valueE; //number received of product
  final String valueF; //supplier name

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context, this._branches, this._incomingFiltered) {
    _products = _productList(_incomingFiltered);
    _branches = _branches;
  }

  final BuildContext context;
  int _selectedCount = 0;
  List<_Row> _products = [];
  List<String> _branches = [];
  List<IncomingPurchasesModel> _incomingFiltered = [];

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
        DataCell(Text(row.valueE.toString())),
        DataCell(Text(row.valueF)),
      ],
    );
  }

  @override
  int get rowCount => _products.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  List<_Row> _productList(List<IncomingPurchasesModel> incomingProducts) {
    try {
      return List.generate(incomingProducts.length, (index) {
        return _Row(
          incomingProducts[index].getDatePurchase,
          incomingProducts[index].getProductName,
          incomingProducts[index].getNumberReceived,
          incomingProducts[index].getSupplierName,
        );
      });
    } catch (e) {
      //if product list is empty
      return List.generate(0, (index) {
        return _Row(
          '',
          '',
          0,
          '',
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
