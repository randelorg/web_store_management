// import 'dart:ui';

// import 'package:qr_utils/qr_utils.dart';

// class GenerateQR{
//   void _generateQR(String content) async {
//     if (content.trim().length == 0) {
//       _scaffoldKey.currentState
//           .showSnackBar(SnackBar(content: Text('Please enter qr content')));
//       setState(() {
//         _qrImg = null;
//       });
//       return;
//     }
//     Image? image;
//     try {
//       image = await QrUtils.generateQR(content);
//     } on PlatformException {
//       image = null;
//     }
//     // setState(() {
//     //   _qrImg = image;
//     // });
//   }
// }