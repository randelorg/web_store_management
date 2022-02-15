import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Models/ProductModel.dart';
import 'package:web_store_management/Notification/Snack_notification.dart';
import '../../Helpers/FilePickerHelper.dart';
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
  var image;
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
                  "Step 1",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  "BORROWER DETAILS",
                  style: TextStyle(fontFamily: 'Cairo_Bold', fontSize: 30),
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
                      hintText: 'Mobile Number',
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
                      hintText: 'Home Address',
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
                  padding: EdgeInsets.only(top: 3),
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
                        TextButton.icon(
                          icon: Icon(Icons.attach_file, color: Colors.white),
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            textStyle: TextStyle(
                                fontSize: 18, fontFamily: 'Cairo_SemiBold'),
                          ),
                          label: Text(fileName),
                          onPressed: () {
                            //get the filename and display it
                            pick.pickFile().then((value) {
                              setState(() {
                                fileName = value;
                              });
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
              Text(
                "Step 2",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text(
                  "SELECT PRODUCTS",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'Cairo_Bold', fontSize: 30),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5, right: 20),
                    child: Container(
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
                        rowsPerPage: 10,
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
              alignment: Alignment.center,
              width: 120,
              height: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
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
                        padding: const EdgeInsets.all(15),
                        primary: Colors.white,
                        textStyle: TextStyle(
                            fontSize: 25, fontFamily: 'Cairo_SemiBold'),
                      ),
                      onPressed: () {
                        //push to second page
                        //which is the finalize order page
                        if (firstname.text.isEmpty || lastname.text.isEmpty ||
                            mobileNumber.text.isEmpty || homeAddress.text.isEmpty) {                        
                              SnackNotification.notif(                                                                                  
                                "Error",
                                "Please fill all the fields",
                               Colors.red.shade600);
                        } else if (pick.image == null) {                                                           
                          SnackNotification.notif(                        
                            "Error",
                            "Please upload a file (jpg, png, jpeg, or pdf)",
                            Colors.red.shade600);                                                                                                                                      
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SimpleDialog(
                                children: [
                                  Container(
                                    width:
                                        (MediaQuery.of(context).size.width) / 2,
                                    height: 555,
                                    child: FinalizePage(
                                      firstname: firstname.text,
                                      lastname: lastname.text,
                                      mobile: mobileNumber.text,
                                      address: homeAddress.text,
                                      total: _getTotal(),
                                      contract: pick.getImageBytes(),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
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

  num _getTotal() {
    num balance = 0;
    num temp = 0;
    Mapping.selectedProducts.forEach((e) {
      temp = e.getPrice * e.getProductQty;
      balance += temp;
    });
    return balance;
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
            ProductModel.selectedProduct(
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
                (element) => element.productCode == row.valueA.toString());
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
