import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Backend/DashboardOperation.dart';
import 'package:web_store_management/Backend/EmployeeOperation.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Models/GraphModel.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:web_store_management/Notification/BannerNotif.dart';
import 'package:web_store_management/Backend/Session.dart';
import 'package:web_store_management/Pages/DashBoard/SalesGraph.dart';

class TimeCollection extends StatefulWidget {
  @override
  _TimeCollection createState() => _TimeCollection();
}

class _TimeCollection extends State<TimeCollection> {
  var dashboard = DashboardOperation();
  var emp = EmployeeOperation();
  bool _isAuthorized = false, _isEmployee = true;
  String? name;
  late Future day, week, month, weekCollection;
  late Future<List<GraphModel>> weekGraph;
  String timeStatus = "CLOCK IN", branchName = '';

  @override
  void initState() {
    getBranch();
    displayName(); //display user name in dashboard
    weekGraph = dashboard.getGraphWeek(); //graph
    //collection total
    day = dashboard.getTodaySales();
    week = dashboard.getWeekSales();
    month = dashboard.getMonthSales();
    weekCollection = dashboard.getWeekCollection();
    super.initState();
  }

  Future<void> getBranch() async {
    await Session.getBranch().then((branch) {
      setState(() {
        branchName = branch;
      });
    });
  }

  void displayName() {
    try {
      if (Mapping.userRole == "Store Attendant") {
        name = Mapping.employeeLogin[0].toString();
      } else {
        //if user is admin
        name = Mapping.adminLogin[0].toString();
        _isAuthorized = true;
        _isEmployee = false;
      }
    } catch (e) {
      print(e);
    }
  }

  //for employee clock in and clock out
  void timeIn(String id, String date) {
    emp.timeIn(id, date).then(
      (value) {
        //set the time in button to invisible
        setState(() {
          //change the button text
          timeStatus = "CLOCK OUT";
          //set the visbility to false -> timeIn
          Session.setTimeIn(false);
          Session.setTimeOut(true);
        });

        BannerNotif.notif(
          'Success',
          'Time-in: $date',
          Colors.green.shade600,
        );
      },
    );
  }

  void timeOut(String id, String date) {
    emp.timeOut(id, date).then((value) {
      setState(() {
        //change the button text
        timeStatus = "CLOCK IN";
      });

      BannerNotif.notif(
        'Success',
        'Time-out: $date',
        Colors.red.shade600,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
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
                      fontFamily: 'Cairo_Bold',
                    ),
                  ),
                ),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        "Welcome ${name.toString()}, you're in the $branchName",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontFamily: 'Cairo_SemiBold',
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _isEmployee,
                      maintainSize: false,
                      maintainAnimation: true,
                      maintainState: true,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: attendantClock(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              //collection summary total
              todaySales(),
              weekSales(),
              monthSales(),
              //TODO: add sales summary here
              Padding(
                padding: EdgeInsets.only(left: 80),
                child: totalCollection(),
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
                  child: salesGraph('Week'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget attendantClock() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green.shade600,
              ),
            ),
          ),
          Tooltip(
            message: timeStatus,
            child: TextButton.icon(
              icon: Icon(
                Icons.timer,
                color: Colors.white,
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(10),
                primary: Colors.white,
                onSurface: Colors.white, //remove it if enable the button
                textStyle: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Cairo_SemiBold',
                ),
              ),
              label: Text(timeStatus),
              onPressed: () async {
                await Session.getTimeIn().then((value) {
                  if (!value) {
                    timeOut(
                      Mapping.employeeLogin[0].getEmployeeID,
                      Mapping.dateToday(),
                    );
                  } else {
                    timeIn(
                      Mapping.employeeLogin[0].getEmployeeID,
                      Mapping.dateToday(),
                    );
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget todaySales() {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 10),
      child: Container(
        //width: 200,
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
                    'Today Sales',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget weekSales() {
    return Container(
      //width: 200,
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
                        semanticsLabel: 'Fetching this week sales',
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
                  'Weekly Sales',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget monthSales() {
    return Container(
      // width: 200,
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
                  'Monthly Sales',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget totalCollection() {
    return Container(
      // width: 200,
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
                future: weekCollection,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        semanticsLabel: 'Fetching total collection',
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
                  'Weekly Collection',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget salesGraph(String caption) {
    return FutureBuilder<List<GraphModel>>(
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
          return SalesGraph(caption: caption, graphData: snapshot.data);
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
