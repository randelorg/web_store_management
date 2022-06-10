import 'package:flutter/material.dart';
import 'package:web_store_management/Pages/Reports/SalesReport.dart';
import 'CollectionSummary.dart';
import 'HistoryScreen.dart';

class ViewReport extends StatelessWidget {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Sales Report'),
    Tab(text: 'Transfer Products Report'),
    Tab(text: 'Collection Report'),
    Tab(text: 'Payment and Loan Report'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blue[800],
            elevation: 5,
            bottom: TabBar(
              indicatorColor: Colors.amberAccent,
              tabs: myTabs,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SalesReport(),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: CollectionSummary(),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: CollectionSummary(),
              ),
            ),
            Center(
              child: HistoryScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
