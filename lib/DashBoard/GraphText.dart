import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'CollectionGraph.dart';

class GraphText extends StatefulWidget {
  @override
  _GraphText createState() => _GraphText();
}

class _GraphText extends State<GraphText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.only(top: 30),
          child: TextButton.icon(
            icon: Icon(
              Icons.account_balance_wallet,
              size: 40.0,
              color: HexColor("#155293"),                        
            ),
            label: Text(
              'COLLECTIONS',
              softWrap: true,
              style: TextStyle(
                fontSize: 30,
                color: HexColor("#155293"),
                fontFamily: 'Cairo_Bold',
              ),
            ),
            onPressed: () {}, //pwdeng refresh button
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            //height: 200,
            margin: const EdgeInsets.only(top: 40),
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                  width: 160.0,
                  child: Column(
                    children: <Widget>[
                      Center(
                          child: TextButton.icon(
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
                            color: HexColor("#155293"),
                            fontFamily: 'Cairo_Bold',
                          ),
                        ),
                        onPressed: () {}, //pwdeng refresh button
                      )),
                      Center(
                        child: Text(
                          'TODAY',
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 160.0,
                  child: Column(
                    children: <Widget>[
                      Center(
                          child: TextButton.icon(
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
                            color: HexColor("#155293"),
                            fontFamily: 'Cairo_Bold',
                          ),
                        ),
                        onPressed: () {}, //pwdeng refresh button
                      )),
                      Center(
                        child: Text(
                          'THIS WEEK',
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 160.0,
                  child: Column(
                    children: <Widget>[
                      Center(
                          child: TextButton.icon(
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
                            color: HexColor("#155293"),
                            fontFamily: 'Cairo_Bold',
                          ),
                        ),
                        onPressed: () {}, //pwdeng refresh button
                      )),
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
          ),
        ),
        Expanded(
            flex: 4,
            child: Container(
              width: (MediaQuery.of(context).size.width),
              height: (MediaQuery.of(context).size.height),
              child: CollectionGraph(),
            )),
      ],
    );
  }
}
