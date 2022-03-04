import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Backend/DashboardOperation.dart';
import 'package:web_store_management/Models/GraphCollectionModel.dart';
import 'CollectionGraph.dart';

class TimeCollection extends StatefulWidget {
  @override
  _TimeCollection createState() => _TimeCollection();
}

class _TimeCollection extends State<TimeCollection> {
  var dashboard = DashboardOperation();
  late Future day;
  late Future week;
  late Future month;
  late Future<List<GraphCollectionModel>> monthGraph;

  @override
  void initState() {
    super.initState();
    //graph
    monthGraph = dashboard.getGraphWeek();
    //collection summary total
    day = dashboard.getTodayCollection();
    week = dashboard.getWeekCollection();
    month = dashboard.getMonthCollection();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
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
                      future: day,
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
                                color: HexColor("#155293"),
                                fontFamily: 'Cairo_Bold',
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
                              color: HexColor("#155293"),
                              fontFamily: 'Cairo_Bold',
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
                      future: week,
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
                                color: HexColor("#155293"),
                                fontFamily: 'Cairo_Bold',
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
                              color: HexColor("#155293"),
                              fontFamily: 'Cairo_Bold',
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
                      future: month,
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
                                color: HexColor("#155293"),
                                fontFamily: 'Cairo_Bold',
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
                              color: HexColor("#155293"),
                              fontFamily: 'Cairo_Bold',
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
            child: collectionGraph('Month'),
          ),
        ),
      ],
    );
  }

  Widget collectionGraph(String caption) {
    return FutureBuilder<List<GraphCollectionModel>>(
      future: monthGraph,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              semanticsLabel: 'Fetching collections',
            ),
          );
        }
        if (snapshot.hasData) {
          //checkLength();
          return CollectionGraph(caption: caption, graphData: snapshot.data);
        } else if (snapshot.data == []) {
          return Center(
            child: Text(
              'No data to display',
              style: TextStyle(
                fontSize: 20,
                color: HexColor("#155293"),
                fontFamily: 'Cairo_Bold',
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(
            semanticsLabel: 'Fetching borrowers',
          ),
        );
      },
    );
  }
}
