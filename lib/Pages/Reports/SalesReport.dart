import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Backend/DashboardOperation.dart';
import 'package:web_store_management/Pages/DashBoard/SalesGraph.dart';
import '../../Models/GraphModel.dart';
import '../../Notification/BannerNotif.dart';

class SalesReport extends StatefulWidget {
  @override
  _SalesReport createState() => _SalesReport();
}

class _SalesReport extends State<SalesReport> {
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  late Future<List<GraphModel>> report;
  var dashboard = DashboardOperation();

  @override
  void initState() {
    startDate.text = "";
    endDate.text = "";
    report = dashboard.getSalesGraphReport('', '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text('Start: '),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 10, right: 30, bottom: 5),
              child: Container(
                width: (MediaQuery.of(context).size.width) / 6,
                child: TextField(
                  controller: startDate,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.date_range_rounded),
                    labelStyle: TextStyle(fontSize: 12),
                    contentPadding: EdgeInsets.only(left: 15),
                    filled: true,
                    hintText: 'Date Start',
                    fillColor: Colors.blueGrey[50],
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade50),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade50),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  //readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2032),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: Colors.red, //Background Color
                              onPrimary: Colors.white, //Text Color
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                primary: Colors.black, //Button Text Color
                              ),
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      setState(() {
                        startDate.text = formattedDate;
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, right: 20),
              child: Text('To'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text('End:'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 10, right: 30, bottom: 5),
              child: Container(
                width: (MediaQuery.of(context).size.width) / 6,
                child: TextField(
                  controller: endDate,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.date_range_rounded),
                    labelStyle: TextStyle(fontSize: 12),
                    contentPadding: EdgeInsets.only(left: 15),
                    filled: true,
                    hintText: 'Date End',
                    fillColor: Colors.blueGrey[50],
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade50),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade50),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  //readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2032),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: Colors.red, //Background Color
                              onPrimary: Colors.white, //Text Color
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                primary: Colors.black, //Button Text Color
                              ),
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      setState(() {
                        endDate.text = formattedDate;
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: HexColor("#155293"),
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 15, bottom: 15),
                        primary: Colors.white,
                        textStyle: TextStyle(
                            fontFamily: 'Cairo_SemiBold', fontSize: 14),
                      ),
                      child: const Text('VIEW'),
                      onPressed: () {
                        if (startDate.text.isEmpty || endDate.text.isEmpty) {
                          BannerNotif.notif(
                              "Error",
                              "Please fill all the fields",
                              Colors.red.shade600);
                        } else {
                          setState(() {
                            report = dashboard.getSalesGraphReport(
                              startDate.text,
                              endDate.text,
                            );
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Center(
            child: FutureBuilder<List<GraphModel>>(
              future: report,
              builder: (context, snapshot) {
                if (ConnectionState.waiting == snapshot.connectionState) {
                  return Center(
                    child: CircularProgressIndicator(
                      semanticsLabel: 'Fetching collections',
                    ),
                  );
                }
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      semanticsLabel: 'Fetching collections',
                    ),
                  );
                }
                if (snapshot.hasData) {
                  //checkLength();
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    shadowColor: Colors.black,
                    elevation: 5,
                    child: SalesGraph(graphData: snapshot.data),
                  );
                } else if (snapshot.data!.isEmpty) {
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
                    semanticsLabel: 'Fetching collections',
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
