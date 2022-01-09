import 'package:flutter/material.dart';
import 'package:web_store_management/Models/SelectedProducts_model.dart';
import '../../Helpers/FilePicker_helper.dart';
import 'FinalizePage.dart';
import '../../Backend/Utility/Mapping.dart';
import '../../Backend/GlobalController.dart';

class SelectionOfProductsPage extends StatefulWidget {
  const SelectionOfProductsPage({Key? key}) : super(key: key);

  @override
  _SelectionOfProductsPage createState() => _SelectionOfProductsPage();
}

class _SelectionOfProductsPage extends State<SelectionOfProductsPage> {
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final mobileNumber = TextEditingController();
  final homeAddress = TextEditingController();
  //classess
  var pick = Picker();
  //display selected file name
  String fileName = 'UPLOAD CONTRACT';

  var controller = GlobalController();
  late Future _products;

  @override
  void initState() {
    super.initState();
    this._products = controller.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          margin: EdgeInsets.all(10),
          width: (MediaQuery.of(context).size.width) / 4,
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Borrower Details",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 20.0,
                      bottom: 10,
                      right: 10,
                      left: 10), //add padding to the textfields
                  child: TextField(
                    controller: firstname,
                    decoration: InputDecoration(
                      hintText: 'Firstname',
                      filled: true,
                      fillColor: Colors.blueGrey[50],
                      labelStyle: TextStyle(fontSize: 18),
                      contentPadding: EdgeInsets.only(left: 30),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey.shade50),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey.shade50),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: lastname,
                    decoration: InputDecoration(
                      hintText: 'Lastname',
                      filled: true,
                      fillColor: Colors.blueGrey[50],
                      labelStyle: TextStyle(fontSize: 18),
                      contentPadding: EdgeInsets.only(left: 30),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey.shade50),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey.shade50),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: mobileNumber,
                    decoration: InputDecoration(
                      hintText: 'Mobile number',
                      filled: true,
                      fillColor: Colors.blueGrey[50],
                      labelStyle: TextStyle(fontSize: 18),
                      contentPadding: EdgeInsets.only(left: 30),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey.shade50),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey.shade50),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: homeAddress,
                    decoration: InputDecoration(
                      hintText: 'Home address',
                      filled: true,
                      fillColor: Colors.blueGrey[50],
                      labelStyle: TextStyle(fontSize: 18),
                      contentPadding: EdgeInsets.only(left: 30),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey.shade50),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey.shade50),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.blue.shade400,
                    ),
                    label: Text(
                      fileName,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    icon: Icon(
                      Icons.attach_file,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      //get the filename and display it
                      pick.pickFile().then((value) {
                        setState(() {
                          fileName = value;
                        });
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const VerticalDivider(
          color: Colors.grey,
          thickness: 1,
          indent: 60,
          endIndent: 60,
          width: 10,
        ),
        Container(
          width: (MediaQuery.of(context).size.width) / 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  "SELECT PRODUCTS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 300,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Product',
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.scanner_sharp),
                          tooltip: 'Scan product barcode',
                        ),
                        filled: true,
                        fillColor: Colors.blueGrey[50],
                        labelStyle: TextStyle(fontSize: 10),
                        contentPadding: EdgeInsets.only(left: 10),
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
                  ),
                ],
              ),
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
                    return Container(
                      width: (MediaQuery.of(context).size.width) / 2,
                      child: PaginatedDataTable(
                        sortAscending: true,
                        showFirstLastButtons: true,
                        rowsPerPage: 9,
                        columns: [
                          DataColumn(label: Text('BARCODE')),
                          DataColumn(label: Text('PRODUCT NAME')),
                          DataColumn(label: Text('PRICE')),
                        ],
                        source: _SelectionOfProducts(context),
                      ),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 120,
              height: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade900,
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(25.0),
                        primary: Colors.white,
                        textStyle: const TextStyle(fontSize: 25),
                      ),
                      onPressed: () {
                        //push to second page
                        //which is the finalize order page
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SimpleDialog(
                              children: [
                                Container(
                                  width:
                                      (MediaQuery.of(context).size.width) / 2,
                                  height: 500,
                                  child: FinalizePage(),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('NEXT'),
                    ),
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

//selection of products
class _RowSelectProducts {
  _RowSelectProducts(
    this.valueA,
    this.valueB,
    this.valueC,
  );

  final String valueA;
  final String valueB;
  final String valueC;

  bool selected = false;
}

class _SelectionOfProducts extends DataTableSource {
  _SelectionOfProducts(this.context) {
    _rows = _selectionProducts();
  }

  int _selectedCount = 0;
  final BuildContext context;
  List<_RowSelectProducts> _rows = [];

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return null;
    final row = _rows[index];
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
            _selectedCount = 1;
          }

          assert(_selectedCount >= 0);
          row.selected = value;
          //add the checked product to the list
          //we will remove the duplicate products afterward
          Mapping.selectedProducts.add(
            SelectedProductsModel.full(
              row.valueA.toString(),
              row.valueB.toString(),
              double.parse(
                row.valueC.toString(),
              ),
            ),
          );

          //delete the uncheck product to the list
          if (value == false) {
            Mapping.selectedProducts.removeWhere(
                (element) => element.barcode == row.valueA.toString());
          }

          notifyListeners();
        }
      },
      cells: [
        DataCell(Text(row.valueA)),
        DataCell(Text(row.valueB)),
        DataCell(Text(row.valueC)),
      ],
    );
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  List<_RowSelectProducts> _selectionProducts() {
    try {
      return List.generate(
        Mapping.productList.length,
        (index) {
          return new _RowSelectProducts(
            Mapping.productList[index].getProductCode.toString(),
            Mapping.productList[index].getProductName.toString(),
            Mapping.productList[index].getProductPrice
                .toStringAsFixed(2)
                .toString(),
          );
        },
      );
    } catch (e) {
      //if product list is empty
      return List.generate(0, (index) {
        return _RowSelectProducts(
          '',
          '',
          '',
        );
      });
    }
  }
}
