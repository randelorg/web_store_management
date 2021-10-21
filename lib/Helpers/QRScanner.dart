import 'package:flutter/services.dart';
import 'package:qr_utils/qr_utils.dart';

class ScanQR {
  String qrResult = ' ';

  void scanQR() async {
    try {
      qrResult = await QrUtils.scanQR;
    } on PlatformException {
      qrResult = 'Process Failed!';
    }

    // setState(() {
    //   _content = result;
    // });
  }

  String getQR() {
    return this.qrResult;
  }
}
