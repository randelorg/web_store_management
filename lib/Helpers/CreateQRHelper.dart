import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreateQrHelper {
  static Widget createQr(String content) {
    return QrImage(
      data: content,
      gapless: true,
      version: QrVersions.auto,
      size: 150,
      // embeddedImage: AssetImage('assets/images/store-logo.png'),
      // embeddedImageStyle: QrEmbeddedImageStyle(
      //   size: Size(20, 20),
      // ),
    );
  }
}
