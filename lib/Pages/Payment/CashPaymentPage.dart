import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:printing/printing.dart';
import 'package:web_store_management/Backend/GlobalController.dart';
import 'package:web_store_management/Backend/ProductOperation.dart';
import 'package:web_store_management/Models/BorrowerModel.dart';
import 'package:web_store_management/Models/InvoiceModel.dart';
import 'package:web_store_management/Models/ProductModel.dart';
import 'package:web_store_management/Backend/CashPaymentOperation.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Helpers/PrintHelper.dart';
import 'package:web_store_management/Notification/BannerNotif.dart';

class CashPaymentPage extends StatefulWidget {
  @override
  _CashPaymentPage createState() => _CashPaymentPage();
}

class _CashPaymentPage extends State<CashPaymentPage> {
  var keyInvoice = CashPaymentOperation();
  var controller = GlobalController();
  var product = ProductOperation();
  final fname = TextEditingController();
  final lname = TextEditingController();
  final address = TextEditingController();
  final searchValue = TextEditingController();
  final List<String> _filters = [];
  late Future<Set<String>> _futureTypes;
  String _searchResult = '';
  List<ProductModel> _productsFiltered = [];
  List<InvoiceItem> items = [];
  late Future _products;

  @override
  void initState() {
    //fetches the products from the database
    _products = controller.fetchProducts();
    //fetch logged in branch
    _products.whenComplete(() {
      _productsFiltered = Mapping.productList;
    });
    _futureTypes = getTypes();
    super.initState();
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

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: (MediaQuery.of(context).size.width) / 5,
          height: (MediaQuery.of(context).size.height) / 1.5,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 160),
                child: Text(
                  "Step 1",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Text(
                "CUSTOMER DETAILS",
                style: TextStyle(fontFamily: 'Cairo_Bold', fontSize: 30),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 6, right: 6, left: 6),
                child: TextField(
                  controller: fname,
                  decoration: InputDecoration(
                    hintText: 'Firstname',
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
                padding: EdgeInsets.all(6),
                child: TextField(
                  controller: lname,
                  decoration: InputDecoration(
                    hintText: 'Lastname',
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
                  controller: address,
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
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: const VerticalDivider(
            color: Colors.grey,
            thickness: 1,
            indent: 60,
            endIndent: 60,
            width: 10,
          ),
        ),
        Column(
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
            Text(
              "SELECT PRODUCTS",
              style: TextStyle(fontFamily: 'Cairo_Bold', fontSize: 30),
            ),
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
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 15, left: 20, right: 5),
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
                ),
              ],
            ),
            Expanded(
              child: Container(
                padding:
                    EdgeInsets.only(top: 20, bottom: 10, right: 10, left: 10),
                width: (MediaQuery.of(context).size.width) / 1.5,
                height: (MediaQuery.of(context).size.height),
                child: ListView(
                  children: [
                    FutureBuilder(
                      future: _products,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasData) {
                          return PaginatedDataTable(
                            showCheckboxColumn: true,
                            showFirstLastButtons: true,
                            rowsPerPage: 10,
                            columns: [
                              DataColumn(label: Text('CODE')),
                              DataColumn(label: Text('NAME')),
                              DataColumn(label: Text('PRICE')),
                              DataColumn(label: Text('QTY')),
                            ],
                            source: _DataSource(context, _productsFiltered),
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
            SizedBox(
              height: 5,
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
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(
                          left: 36, right: 36, top: 18, bottom: 18),
                      primary: Colors.white,
                      textStyle: TextStyle(
                        fontFamily: 'Cairo_SemiBold',
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    child: const Text('DONE'),
                    onPressed: () async {
                      String invoiceNumber = "";
                      await keyInvoice
                          .getInvoiceNumber()
                          .then((value) => invoiceNumber = value);

                      if (fname.text.isEmpty ||
                          lname.text.isEmpty ||
                          address.text.isEmpty) {
                        BannerNotif.notif(
                          "Error",
                          "Please fill all the fields",
                          Colors.red.shade600,
                        );

                        return;
                      }

                      Navigator.pop(context);
                      //show the print screen
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return showInvoice(invoiceContent(invoiceNumber));
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
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
                Mapping.invoice.clear();
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ],
    );
  }

  Invoice invoiceContent(String invoiceNumber) {
    return Invoice(
      customer: BorrowerModel.invoice(
        fname.text.trim(),
        lname.text.trim(),
        address.text.trim(),
      ),
      info: InvoiceInfo(
        date: DateTime.now(),
        description: 'This will serve as your Unofficial Receipt. Thank you!',
        number: invoiceNumber,
      ),
      items: Mapping.invoice,
    );
  }

  Widget showInvoice(Invoice invoice) {
    return Container(
      child: PdfPreview(
        padding: EdgeInsets.all(10),
        build: (format) => PrintHelper.generateLoanInvoice(
          format,
          invoice,
        ),
      ),
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
}

class _Row {
  _Row(
    this.valueA,
    this.valueB,
    this.valueC,
    this.valueD,
  );

  final String valueA;
  final String valueB;
  final String valueC;
  final TextFormField valueD;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context, this._productsFiltered) {
    _productsFiltered = _productsFiltered;
    _products = _productList(_productsFiltered);
  }

  final BuildContext context;
  int _selectedCount = 0;
  List<ProductModel> _productsFiltered = [];
  static List<_Row> _products = [];

  List<TextEditingController> qty = List<TextEditingController>.generate(
    Mapping.productList.length,
    (index) => TextEditingController(),
  );

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _products.length) return null;
    final row = _products[index];
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

          //add the checked product to the list
          //we will remove the duplicate products afterward
          Mapping.invoice.add(
            InvoiceItem(
              description: row.valueB.toString(),
              quantity: int.parse(qty[index].text),
              vat: 0,
              unitPrice: double.parse(row.valueC.toString()),
            ),
          );

          //delete the uncheck product to the list
          if (value == false) {
            Mapping.invoice.removeWhere(
              (element) => element.description == row.valueA.toString(),
            );
          }

          notifyListeners();
        }

        assert(_selectedCount >= 0);
        row.selected = value;
      },
      cells: [
        DataCell(Text(row.valueA)),
        DataCell(Text(row.valueB)),
        DataCell(Text(row.valueC)),
        DataCell((row.valueD), showEditIcon: true),
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
          products[index].getProductCode.toString(),
          products[index].getProductName.toString(),
          products[index].getProductPrice.toStringAsFixed(2).toString(),
          TextFormField(
            controller: qty[index],
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
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
          '',
          TextFormField(
            initialValue: '0',
          ),
        );
      });
    }
  }
}
