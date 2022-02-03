import 'package:ai_barcode/ai_barcode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScannerHelper {
  static String? qrContent;
  static dynamic qrCodeResult;
  static Widget scanBarcode() {
    return AlertDialog(
      actionsPadding: EdgeInsets.only(bottom: 5, left: 5, right: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actions: [
        Container(
          color: Colors.black26,
          width: 200,
          height: 200,
          child: PlatformAiBarcodeScannerWidget(
            platformScannerController:
                ScannerController(scannerResult: (result) {})
                    .startCameraPreview(),
          ),
        ),
      ],
    );
  }
}
