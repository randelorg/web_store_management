import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreateQrHelper {
  static Widget createQr(String content) {
    return QrImage(
      data: content,
      version: QrVersions.auto,
      embeddedImage: AssetImage('assets/images/store-logo.png'),
      embeddedImageStyle: QrEmbeddedImageStyle(
        size: Size(70, 70),
      ),
      size: 200.0,
    );
  }
}
