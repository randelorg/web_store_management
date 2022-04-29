import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Models/ProductModel.dart';
import 'package:web_store_management/Notification/BannerNotif.dart';
import '../../Helpers/FilePickerHelper.dart';
import '../../Backend/Utility/Mapping.dart';
import '../../Backend/GlobalController.dart';
import '../NewLoan/FinalizePage.dart';

class AddLoanPage extends StatefulWidget {
  final int? id;
  final String? action, firstname, lastname, number, address;
  AddLoanPage({
    required this.action,
    this.id,
    this.firstname,
    this.lastname,
    this.number,
    this.address,
  });

  @override
  _AddLoanPage createState() => _AddLoanPage();
}

class _AddLoanPage extends State<AddLoanPage> {
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final mobileNumber = TextEditingController();
  final homeAddress = TextEditingController();
  //classess
  var pick = Picker();
  var image;
  //display selected file name
  String fileName = 'UPLOAD NEW CONTRACT';

  var controller = GlobalController();
  late Future _products;

  @override
  void initState() {
    super.initState();
    this._products = controller.fetchProducts();
    firstname.text = widget.firstname.toString();
    lastname.text = widget.lastname.toString();
    mobileNumber.text = widget.number.toString();
    homeAddress.text = widget.address.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: (MediaQuery.of(context).size.width) / 4,
          height: (MediaQuery.of(context).size.height) / 1.5,
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
                      top: 20,
                      bottom: 6,
                      right: 6,
                      left: 6), //add padding to the textfields
                  child: TextField(
                    controller: firstname,
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: 'Firstname',
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
                  padding: EdgeInsets.all(6),
                  child: TextField(
                    controller: lastname,
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: 'Lastname',
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
                  padding: EdgeInsets.all(6),
                  child: TextField(
                    controller: mobileNumber,
                    enabled: false,
                    maxLength: 12,
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: 'Mobile Number',
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
                  padding: EdgeInsets.all(6),
                  child: TextField(
                    controller: homeAddress,
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: 'Home Address',
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
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Text(
                  "Step 2",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
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
                            tooltip: 'Scan Product Barcode',
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
              Expanded(
                child: Container(
                  width: (MediaQuery.of(context).size.width) / 1.5,
                  height: (MediaQuery.of(context).size.height),
                  child: ListView(
                    children: [
                      FutureBuilder(
                        future: this._products,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasData) {
                            return PaginatedDataTable(
                              sortAscending: true,
                              showCheckboxColumn: true,
                              showFirstLastButtons: true,
                              rowsPerPage: 10,
                              columns: [
                                DataColumn(label: Text('BARCODE')),
                                DataColumn(label: Text('PRODUCT NAME')),
                                DataColumn(label: Text('PRICE')),
                              ],
                              source: _SelectionOfProducts(context),
                            );
                          }
                          return Center(
                            child: Center(
                              child: Text(
                                'No Data',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
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
                            fontSize: 25,
                            fontFamily: 'Cairo_SemiBold',
                          ),
                        ),
                        onPressed: () {
                          //push to second page
                          //which is the finalize order page
                          if (pick.image == null) {
                            BannerNotif.notif(
                              "Error",
                              "Please upload a file (jpg, png, jpeg)",
                              Colors.red.shade600,
                            );
                          } else {
                            //exit
                            Navigator.pop(context);
                            //show dialog
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SimpleDialog(
                                  children: [
                                    Container(
                                      width:
                                          (MediaQuery.of(context).size.width) /
                                              2,
                                      height: 555,
                                      child: FinalizePage(
                                        action: widget.action,
                                        id: widget.id,
                                        firstname: firstname.text,
                                        lastname: lastname.text,
                                        mobile: mobileNumber.text,
                                        address: homeAddress.text,
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
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 5, right: 8),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
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
            ProductModel.selectedProduct(
              row.valueA.toString(), //code
              row.valueB.toString(), //name
              double.parse(
                row.valueC.toString(), //price
              ),
            ),
          );

          //delete the uncheck product to the list
          if (value == false) {
            Mapping.selectedProducts.removeWhere(
              (element) => element.productCode == row.valueA.toString(),
            );
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
