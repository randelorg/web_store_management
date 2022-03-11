import 'package:flutter/material.dart';
import 'package:web_store_management/Helpers/PdfApi.dart';
import 'package:web_store_management/Helpers/PdfInvoiceApi.dart';
import 'package:web_store_management/Helpers/Widget/ButtonWidget.dart';
import 'package:web_store_management/Helpers/Widget/TitleWidget.dart';
import 'package:web_store_management/Models/BorrowerModel.dart';
import 'package:web_store_management/Models/InvoiceModel.dart';

class PdfPage extends StatefulWidget {
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        actionsPadding: EdgeInsets.only(bottom: 5, left: 5, right: 5),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(32),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ButtonWidget(
                    text: 'Invoice PDF',
                    onClicked: () async {
                      final date = DateTime.now();
                      final dueDate = date.add(Duration(days: 7));

                      final invoice = Invoice(
                        customer: BorrowerModel.invoice(
                          'Randel',
                          'Reyes',
                          'Mabolo',
                        ),
                        info: InvoiceInfo(
                          date: date,
                          dueDate: dueDate,
                          description: 'My description...',
                          number: '${DateTime.now().year}-9999',
                        ),
                        items: [
                          InvoiceItem(
                            description: 'Coffee',
                            date: DateTime.now(),
                            quantity: 3,
                            vat: 0.19,
                            unitPrice: 5.99,
                          ),
                          InvoiceItem(
                            description: 'Water',
                            date: DateTime.now(),
                            quantity: 8,
                            vat: 0.19,
                            unitPrice: 0.99,
                          ),
                          InvoiceItem(
                            description: 'Orange',
                            date: DateTime.now(),
                            quantity: 3,
                            vat: 0.19,
                            unitPrice: 2.99,
                          ),
                          InvoiceItem(
                            description: 'Apple',
                            date: DateTime.now(),
                            quantity: 8,
                            vat: 0.19,
                            unitPrice: 3.99,
                          ),
                          InvoiceItem(
                            description: 'Mango',
                            date: DateTime.now(),
                            quantity: 1,
                            vat: 0.19,
                            unitPrice: 1.59,
                          ),
                          InvoiceItem(
                            description: 'Blue Berries',
                            date: DateTime.now(),
                            quantity: 5,
                            vat: 0.19,
                            unitPrice: 0.99,
                          ),
                          InvoiceItem(
                            description: 'Lemon',
                            date: DateTime.now(),
                            quantity: 4,
                            vat: 0.19,
                            unitPrice: 1.29,
                          ),
                        ],
                      );

                      final pdfFile = await PdfInvoiceApi.generate(invoice);

                      PdfApi.openFile(pdfFile);
                    },
                  ),
                ],
              ),
            ),
          ),
        ]);
  }
}
