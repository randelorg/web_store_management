import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class CreditScreen extends StatefulWidget {
  @override
  _CreditScreen createState() => _CreditScreen();
}

class _CreditScreen extends State<CreditScreen> {
  double textSize = 15;
  double titleSize = 30;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, right: 20),
                alignment: Alignment.topLeft,
                width: (MediaQuery.of(context).size.width) / 4.5,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search borrower',
                    suffixIcon: InkWell(
                      child: IconButton(
                        icon: Icon(Icons.qr_code_scanner_outlined),
                        color: Colors.grey,
                        tooltip: 'Search by QR',
                        onPressed: () {},
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.blueGrey[50],
                    labelStyle: TextStyle(fontSize: 12),
                    contentPadding: EdgeInsets.only(left: 30),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade50),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade50),
                    ),
                  ),
                ),
              ),
            ]),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(bottom: 40, right: 20, left: 20),
            //alignment: Alignment.center,
            width: (MediaQuery.of(context).size.width),
            height: (MediaQuery.of(context).size.height),
            child: GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 5,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height),
                children: List.generate(50, (index) {
                  return Column(
                    children: [
                      Card(
                        shadowColor: Colors.black,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'PENDING...',
                              softWrap: true,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: titleSize,
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Text(
                                    'Name',
                                    softWrap: true,
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Randel Reyes',
                                    softWrap: true,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: textSize,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Text(
                                    'Address',
                                    softWrap: true,
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Pagdaicon, Mabolo Naga City',
                                    softWrap: true,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: textSize,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Text(
                                    'Number',
                                    softWrap: true,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '+63 995 354 5532',
                                    softWrap: true,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: textSize,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              child: const Text('Show application'),
                              style: TextButton.styleFrom(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              onPressed: () {},
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned.fill(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          padding: const EdgeInsets.only(
                                              left: 30,
                                              right: 30,
                                              top: 5,
                                              bottom: 5),
                                          primary: Colors.white,
                                          textStyle: TextStyle(fontSize: 20),
                                        ),
                                        onPressed: () {},
                                        child: const Text('APPROVE'),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.cancel),
                                  color: Colors.redAccent.shade400,
                                  tooltip: 'DENY CREDIT',
                                  onPressed: () {},
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  );
                })),
          ),
        ),
      ],
    );
  }
}
