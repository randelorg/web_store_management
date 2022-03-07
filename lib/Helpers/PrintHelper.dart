import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:web_store_management/Backend/BorrowerOperation.dart';

class PrintHelper {
  static Future<Uint8List> generatePdfQr(
      PdfPageFormat format, String content, String name) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);

    pdf.addPage(
      pw.Page(
        pageFormat: format,
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

  static Future<Uint8List> generatePdfContract(
      String id, PdfPageFormat format) async {
    var brw = BorrowerOperation();
    Uint8List imageData = await brw.getContract(int.parse(id));

    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [
              pw.FittedBox(
                child: pw.Image(
                  pw.MemoryImage(imageData),
                  width: 40,
                  height: 40,
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
