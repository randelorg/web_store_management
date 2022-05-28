import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';
import 'package:web_store_management/Backend/GlobalController.dart';
import 'package:web_store_management/Models/IncomingPurchasesModel.dart';
import 'package:web_store_management/Models/ProductModel.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Backend/ProductOperation.dart';
import 'package:web_store_management/Pages/InventoryMain/ViewOrders/ViewOrdersList.dart';

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
  List<IncomingPurchasesModel> _incomingFiltered = [];
  final List<String> _filters = [];
  String _searchResult = '';
  bool show = false;
  var searchValue = TextEditingController();

  @override
  void initState() {
    //fetches the products
    _incomingPurchases = controller.fetchIncomingPurchases();
    controller.fetchBranches();
    //fetch logged in branch
    _incomingPurchases.whenComplete(() {
      _incomingFiltered = Mapping.groupedPurchase;
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
                Container(
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 15, left: 20, right: 5),
                  width: 350,
                  child: TextField(
                    controller: searchValue,
                    // onChanged: (value) {
                    //   setState(() {
                    //     _searchResult = value;
                    //     _incomingFiltered = Mapping.groupedPurchase
                    //         .where((product) => product.getProductName
                    //             .toLowerCase()
                    //             .contains(_searchResult.toLowerCase()))
                    //         .toList();
                    //   });
                    // },
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
                      DataColumn(label: Text('Order Slip ID')),
                      DataColumn(label: Text('Supplier Name')),
                      DataColumn(label: Text('Date Purchased')),
                      DataColumn(label: Text('Action'))
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
    this.valueD,
  );

  final String valueA; //order slip id
  final String valueB; //supplier name
  final String valueE; //purchase date
  final Widget valueD; //view button

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
          DataCell((row.valueD), onTap: () {
            showModalSideSheet(
              context: context,
              width: MediaQuery.of(context).size.width / 1.5,
              body: Padding(
                padding: const EdgeInsets.all(30.0),
                child: ViewOrderList(
                  orderSlipId: row.valueA,
                  datePurchase: row.valueE,
                  supplierName: row.valueB,
                ),
              ),
            );
          }),
        ]);
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
          incomingProducts[index].getPurchaseOrderSlip,
          incomingProducts[index].getSupplierName,
          incomingProducts[index].getDatePurchase,
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
                    'VIEW',
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
          '',
          '',
          Text(''),
        );
      });
    }
  }
}
