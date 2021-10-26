import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../DashBoard/CollectionGraph.dart';

class CollectionSummary extends StatefulWidget {
  @override
  _CollectionSummary createState() => _CollectionSummary();
}

class _CollectionSummary extends State<CollectionSummary> {
  TextEditingController dateinput = TextEditingController();

  @override
  void initState() {
    dateinput.text = "";
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
              padding: EdgeInsets.only(top: 20, left: 10, right: 30),
              child: Container(
                width: (MediaQuery.of(context).size.width) / 6,
                child: TextField(
                  controller: dateinput,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(fontSize: 12),
                    contentPadding: EdgeInsets.only(left: 30),
                    hintText: 'Date Today',
                    fillColor: Colors.blueGrey[50],
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue.shade400),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  //readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1999),
                        lastDate: DateTime(2031));
                    if (pickedDate != null) {
                      print(pickedDate);
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      print(formattedDate);
                      setState(() {
                        dateinput.text = formattedDate;
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
              padding: EdgeInsets.only(top: 20, left: 10, right: 30),
              child: Container(
                width: (MediaQuery.of(context).size.width) / 6,
                child: TextField(
                  controller: dateinput,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(fontSize: 12),
                    contentPadding: EdgeInsets.only(left: 30),
                    hintText: 'Date Today',
                    fillColor: Colors.blueGrey[50],
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue.shade400),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  //readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1999),
                        lastDate: DateTime(2031));
                    if (pickedDate != null) {
                      print(pickedDate);
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      print(formattedDate);
                      setState(() {
                        dateinput.text = formattedDate;
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
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
                            left: 20, right: 20, top: 15, bottom: 15),
                        primary: Colors.white,
                        textStyle: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {},
                      child: const Text('VIEW'),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20),
              child: Tooltip(
                message: 'Print graph',
                child: Icon(Icons.print_rounded),
              ),
            ),
          ],
        ),
        Expanded(
          child: Center(
            child: CollectionGraph(),
          ),
        )
      ],
    );
  }
}
