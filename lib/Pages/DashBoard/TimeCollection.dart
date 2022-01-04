import 'package:flutter/material.dart';
import 'package:web_store_management/Backend/Dashboard_operation.dart';
import 'CollectionGraph.dart';

class TimeCollection extends StatefulWidget {
  @override
  _TimeCollection createState() => _TimeCollection();
}

class _TimeCollection extends State<TimeCollection> {
  var dashboard = DashboardOperation();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: Row(
            children: [
              Icon(
                Icons.account_balance_wallet,
                size: 40.0,
                color: Colors.black,
              ),
            ],
          ),
        ),
        Row(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              shadowColor: Colors.black,
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    FutureBuilder(
                      future: dashboard.getTodayCollection(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(
                              semanticsLabel: 'Fetching today collection',
                            ),
                          );
                        }
                        if (snapshot.hasData) {
                          return TextButton.icon(
                            //Today collection graph
                            icon: Icon(
                              Icons.attach_money,
                              size: 30.0,
                              color: Colors.black,
                            ),
                            label: Text(
                              //vars here to be setState
                              snapshot.data.toString(),
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {}, //pwdeng refresh button
                          );
                        }
                        return Center(
                          child: Text(
                            '0',
                            softWrap: true,
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                    Center(
                      child: Text(
                        'TODAY',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              shadowColor: Colors.black,
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    FutureBuilder(
                      future: dashboard.getWeekCollection(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(
                              semanticsLabel: 'Fetching this week collection',
                            ),
                          );
                        }
                        if (snapshot.hasData) {
                          return TextButton.icon(
                            //this weeek collection graph
                            icon: Icon(
                              Icons.attach_money,
                              size: 30.0,
                              color: Colors.black,
                            ),
                            label: Text(
                              //vars here to be setState
                              snapshot.data.toString(),
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {}, //pwdeng refresh button
                          );
                        }
                        return Center(
                          child: Text(
                            '0',
                            softWrap: true,
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                    Center(
                      child: Text(
                        'THIS WEEK',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              shadowColor: Colors.black,
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    FutureBuilder(
                      future: dashboard.getWeekCollection(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(
                              semanticsLabel: 'Fetching this month collection',
                            ),
                          );
                        }
                        if (snapshot.hasData) {
                          return TextButton.icon(
                            //Month collection graph
                            icon: Icon(
                              Icons.attach_money,
                              size: 30.0,
                              color: Colors.black,
                            ),
                            label: Text(
                              //vars here to be setState
                              snapshot.data.toString(),
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {}, //pwdeng refresh button
                          );
                        }
                        return Center(
                          child: Text(
                            '0',
                            softWrap: true,
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                    Center(
                      child: Text(
                        'THIS MONTH',
                      ),
                    ),
                  ],
                ),
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
