import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:web_store_management/Backend/BorrowerOperation.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Helpers/PdfInvoiceApi.dart';
import 'package:web_store_management/Models/InvoiceModel.dart';

class PrintHelper {
  static Future<Uint8List> generatePdfQr(
      PdfPageFormat format, String content, String name) async {
    final pdf = pw.Document(compress: true);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.letter,
        build: (context) {
          return pw.Column(
            children: [
              pw.SizedBox(
                width: double.infinity,
                child: pw.FittedBox(
                  child: pw.BarcodeWidget(
                    barcode: pw.Barcode.qrCode(),
                    data: content,
                    width: 10,
                    height: 10,
                  ),
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Flexible(
                child: pw.Text(
                  name,
                  style: pw.TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              pw.Flexible(
                child: pw.Text(
                  "Dellrain's Store Borrower",
                  style: pw.TextStyle(
                    fontSize: 10,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  static Future<Uint8List> generateInvoice(
      PdfPageFormat format, Invoice invoice) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);

    pdf.addPage(pw.MultiPage(
      build: (context) => [
        PdfInvoiceApi.buildHeader(invoice),
        pw.SizedBox(height: 3 * PdfPageFormat.cm),
        PdfInvoiceApi.buildTitle(invoice),
        PdfInvoiceApi.buildInvoice(invoice),
        pw.Divider(),
        PdfInvoiceApi.buildTotal(invoice),
      ],
      footer: (context) => PdfInvoiceApi.buildFooter(invoice),
    ));

    //clear the selected products
    Mapping.invoice.clear();

    return pdf.save();
  }

  static Future<Uint8List> generatePdfContract(String id) async {
    var brw = BorrowerOperation();
    var imageData = await brw.getContract(int.parse(id));
    var contract = Uint8List.fromList(imageData);

    final pdf = pw.Document(compress: true);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Expanded(
            child: pw.Image(
              pw.MemoryImage(contract),
              fit: pw.BoxFit.contain,
            ),
          );
        },
      ),
    );

    //returm the pdf invoice
    return pdf.save();
  }
}
