import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TransferStock extends StatefulWidget {
  @override
  _TransferStock createState() => _TransferStock();
}

class _TransferStock extends State<TransferStock> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Transfer Stock',
        softWrap: true,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35,
            color: Colors.blue,
            overflow: TextOverflow.fade),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actions: <Widget>[
        Column(
          children: [
            Container(
              child: Container(alignment: Alignment.topLeft,),
            )
          ],
        )
      ],
    );
  }
}
