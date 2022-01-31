import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCode {
  //generates qr code
  static void generateQR(String content) {
    QrImage(
      data: content.trim(),
      version: QrVersions.auto,
      size: 320,
      gapless: true,
      embeddedImage: AssetImage('assets/images/store-logo.png'),
      embeddedImageStyle: QrEmbeddedImageStyle(
        size: Size(80, 80),
      ),
      errorStateBuilder: (cxt, err) {
        return Container(
          child: Center(
            child: Text(
              "Uh oh! Something went wrong...",
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
