import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:printing/printing.dart';
import 'package:web_store_management/Backend/GlobalController.dart';
import 'package:web_store_management/Backend/ProductOperation.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Helpers/PrintHelper.dart';
import 'package:web_store_management/Models/BorrowerModel.dart';
import 'package:web_store_management/Models/InvoiceModel.dart';

import '../../Notification/BannerNotif.dart';

class CashPaymentPage extends StatefulWidget {
  @override
  _CashPaymentPage createState() => _CashPaymentPage();
}

class _CashPaymentPage extends State<CashPaymentPage> {
  var controller = GlobalController();
  var product = ProductOperation();
  final fname = TextEditingController();
  final lname = TextEditingController();
  final address = TextEditingController();
  List<InvoiceItem> items = [];
  late Future _products;

  @override
  void initState() {
    //fetches the products from the database
    this._products = controller.fetchProducts();
    super.initState();
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
            Expanded(
              child: Container(
                padding:
                    EdgeInsets.only(top: 20, bottom: 10, right: 10, left: 10),
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
                            showCheckboxColumn: true,
                            showFirstLastButtons: true,
                            rowsPerPage: 10,
                            columns: [
                              DataColumn(label: Text('CODE')),
                              DataColumn(label: Text('NAME')),
                              DataColumn(label: Text('PRICE')),
                              DataColumn(label: Text('QTY')),
                            ],
                            source: _DataSource(context),
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
                      if (fname.text.isEmpty ||
                          lname.text.isEmpty ||
                          address.text.isEmpty) {
                        BannerNotif.notif("Error", "Please fill all the fields",
                            Colors.red.shade600);
                      } else {
                        final date = DateTime.now();
                        final dueDate = date.add(Duration(days: 7));

                        final invoice = Invoice(
                          customer: BorrowerModel.invoice(
                            fname.text.trim(),
                            lname.text.trim(),
                            address.text.trim(),
                          ),
                          info: InvoiceInfo(
                            date: date,
                            description:
                                'This will serve as your Unofficial Receipt. Thank you!',
                            number: '${DateTime.now().year}-9999',
                            dueDate: dueDate,
                          ),
                          items: Mapping.invoice,
                        );

                        Navigator.pop(context);
                        //show the print screen
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return showInvoice(invoice);
                          },
                        );
                      }
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
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget showInvoice(Invoice invoice) {
    return Container(
      child: PdfPreview(
        padding: EdgeInsets.all(10),
        build: (format) => PrintHelper.generateInvoice(
          format,
          invoice,
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
  );

  final String valueA;
  final String valueB;
  final String valueC;
  final TextFormField valueD;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context) {
    _products = _productList(context);
  }

  final BuildContext context;
  int _selectedCount = 0;
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

  List<_Row> _productList(BuildContext context) {
    try {
      return List.generate(Mapping.productList.length, (index) {
        return _Row(
          Mapping.productList[index].getProductCode.toString(),
          Mapping.productList[index].getProductName.toString(),
          Mapping.productList[index].getProductPrice
              .toStringAsFixed(2)
              .toString(),
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
