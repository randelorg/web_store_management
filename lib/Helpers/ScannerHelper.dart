import 'package:flutter/material.dart';
import 'package:jsqr/scanner.dart';

class ScannerHelper {
  static String? qrContent;

  static String getContent() {
    return qrContent.toString();
  }

  static Widget scanQr(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      title: const Text('Scan QR Code'),
      content: Container(
        width: (MediaQuery.of(context).size.width),
        height: (MediaQuery.of(context).size.height),
        child: Center(
          child: Scanner(
            key: qrContent,
          ),
        ),
      ),
    );
  }
}
