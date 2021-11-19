import 'package:flutter/material.dart';

import 'CollectionGraph.dart';

class TimeCollection extends StatefulWidget {
  @override
  _TimeCollection createState() => _TimeCollection();
}

class _TimeCollection extends State<TimeCollection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20, top: 20),
          child: Row(
            children: [
              Icon(
                Icons.account_balance_wallet,
                size: 40.0,
                color: Colors.black,
              ),
              Text(
                'COLLECTIONS',
                softWrap: true,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  TextButton.icon(
                    //Today collection graph
                    icon: Icon(
                      Icons.attach_money,
                      size: 30.0,
                      color: Colors.black,
                    ),
                    label: Text(
                      //vars here to be setState
                      '60,000',
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {}, //pwdeng refresh button
                  ),
                  Center(
                    child: Text(
                      'TODAY',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  TextButton.icon(
                    //this weeek collection graph
                    icon: Icon(
                      Icons.attach_money,
                      size: 30.0,
                      color: Colors.black,
                    ),
                    label: Text(
                      //vars here to be setState
                      '60,000',
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {}, //pwdeng refresh button
                  ),
                  Center(
                    child: Text(
                      'THIS WEEK',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  TextButton.icon(
                    //Month collection graph
                    icon: Icon(
                      Icons.attach_money,
                      size: 30.0,
                      color: Colors.black,
                    ),
                    label: Text(
                      //vars here to be setState
                      '60,000',
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {}, //pwdeng refresh button
                  ),
                  Center(
                    child: Text(
                      'THIS MONTH',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Expanded(
          child: Container(
            //the actual graph
            width: (MediaQuery.of(context).size.width),
            height: (MediaQuery.of(context).size.height),
            child: CollectionGraph(),
          ),
        ),
      ],
    );
  }
}
