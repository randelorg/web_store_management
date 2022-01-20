import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCode {
  //generates qr code
  static void generateQR(String content) {
    QrImage(
      data: content.trim(),
      version: QrVersions.auto,
      size: 320,
      gapless: false,
      embeddedImage: AssetImage('assets/images/store-logo.png'),
      embeddedImageStyle: QrEmbeddedImageStyle(
        size: Size(80, 80),
      ),
    );
  }
}
