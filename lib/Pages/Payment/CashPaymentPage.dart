import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Backend/GlobalController.dart';
import 'package:web_store_management/Backend/ProductOperation.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Pages/Payment/Invoice/pdf_invoice_page.dart';

class CashPaymentPage extends StatefulWidget {
  @override
  _CashPaymentPage createState() => _CashPaymentPage();
}

class _CashPaymentPage extends State<CashPaymentPage> {
  var controller = GlobalController();
  var product = ProductOperation();
  late Future _products;

  @override
  void initState() {
    //fetches the products from the database
    this._products = controller.fetchProducts();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Column(
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
        Text(
          'Cash Payment',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: HexColor("#155293"),
            fontFamily: 'Cairo_Bold',
            fontSize: 30,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Expanded(
            child: Container(
              width: (MediaQuery.of(context).size.width) / 1.5,
              child: FutureBuilder(
                  future: this._products,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasData) {
                      return PaginatedDataTable(
                        showCheckboxColumn: true,
                        showFirstLastButtons: true,
                        rowsPerPage: 6,
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
                  }),
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
                    left: 36,
                    right: 36,
                    top: 18,
                    bottom: 18,
                  ),
                  primary: Colors.white,
                  textStyle: TextStyle(
                    fontFamily: 'Cairo_SemiBold',
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                child: const Text('DONE'),
                onPressed: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                        children: [
                          Container(
                            width: (MediaQuery.of(context).size.width) / 1.1,
                            height: (MediaQuery.of(context).size.height / 1.2),
                            child: PdfPage(),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
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
  final String valueB;
  final String valueC;
  final Widget valueD;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context) {
    _products = _productList(context);
  }

  final BuildContext context;
  int _selectedCount = 0;
  List<_Row> _products = [];

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
          notifyListeners();
        }

        assert(_selectedCount >= 0);
        row.selected = value;
      },
      cells: [
        DataCell(Text(row.valueA)),
        DataCell(Text(row.valueB)),
        DataCell(Text(row.valueC)),
        DataCell(
          (row.valueD),
          showEditIcon: true,
        ),
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
            initialValue: '0',
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            onFieldSubmitted: (val) {
              print('onSubmited $val');
            },
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
          Text('0'),
        );
      });
    }
  }
}
