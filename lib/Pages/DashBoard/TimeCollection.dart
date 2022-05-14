import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Backend/DashboardOperation.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Models/GraphCollectionModel.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'CollectionGraph.dart';

class TimeCollection extends StatefulWidget {
  @override
  _TimeCollection createState() => _TimeCollection();
}

class _TimeCollection extends State<TimeCollection> {
  var dashboard = DashboardOperation();
  String? name;
  late Future day;
  late Future week;
  late Future month;
  late Future<List<GraphCollectionModel>> weekGraph;

  @override
  void initState() {
    //display user name in dashboard
    displayName();
    //graph
    weekGraph = dashboard.getGraphWeek();
    //collection summary total
    day = dashboard.getTodayCollection();
    week = dashboard.getWeekCollection();
    month = dashboard.getMonthCollection();
    super.initState();
  }

  void displayName() {
    try {
      if (Mapping.userRole == "Store Attendant") {
        name = Mapping.employeeLogin[0].toString();
      } else {
        //if user is admin
        name = Mapping.adminLogin[0].toString();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, right: 20, top: 10),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: const Text(
                  'Dashboard',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontFamily: 'Cairo_SemiBold',
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  'Welcome, ${name.toString()}',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontFamily: 'Cairo_SemiBold',
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            //collection summary total
            todayCollection(),
            weekCollection(),
            monthCollection(),
            //TODO: add sales summary here
            Padding(
              padding: EdgeInsets.only(left: 50),
              child: totalSales(),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              //the actual graph
              width: (MediaQuery.of(context).size.width),
              height: (MediaQuery.of(context).size.height),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                shadowColor: Colors.black,
                elevation: 3,
                child: collectionGraph('Month'),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget todayCollection() {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 10),
      child: Container(
        width: 200,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          shadowColor: Colors.black,
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          MdiIcons.currencyPhp,
                          size: 35,
                          color: Colors.black,
                        ),
                        label: Text(
                          //vars here to be setState
                          snapshot.data.toString(),
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 35,
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
                  child: const Text(
                    'Today Collection',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget weekCollection() {
    return Container(
      width: 200,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        shadowColor: Colors.black,
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        MdiIcons.currencyPhp,
                        size: 35,
                        color: Colors.black,
                      ),
                      label: Text(
                        //vars here to be setState
                        snapshot.data.toString(),
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 35,
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
                child: const Text(
                  'Week Collection',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget monthCollection() {
    return Container(
      width: 200,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        shadowColor: Colors.black,
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        MdiIcons.currencyPhp,
                        size: 35,
                        color: Colors.black,
                      ),
                      label: Text(
                        //vars here to be setState
                        snapshot.data.toString(),
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 35,
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
                child: const Text(
                  'Month Collection',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget totalSales() {
    return Container(
      width: 200,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        shadowColor: Colors.black,
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: month,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        semanticsLabel: 'Fetching total sales',
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    return TextButton.icon(
                      //Month collection graph
                      icon: Icon(
                        MdiIcons.currencyPhp,
                        size: 35,
                        color: Colors.black,
                      ),
                      label: Text(
                        //vars here to be setState
                        snapshot.data.toString(),
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 35,
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
                child: const Text(
                  'Cash Payment Sales',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget collectionGraph(String caption) {
    return FutureBuilder<List<GraphCollectionModel>>(
      future: weekGraph,
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
