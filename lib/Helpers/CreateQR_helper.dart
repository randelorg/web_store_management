import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

class CreateQrHelper {
  static Widget createQr(String qrCode) {
    return QrImage(
      data: qrCode,
      version: QrVersions.auto,
      embeddedImage: AssetImage('assets/images/store-logo.png'),
      embeddedImageStyle: QrEmbeddedImageStyle(
        size: Size(50, 50),
      ),
      size: 200.0,
    );
  }

  static Future<String> scanQr() async {
    var barcode = await BarcodeScanner.scan();
    return barcode.rawContent.toString();
  }
}
