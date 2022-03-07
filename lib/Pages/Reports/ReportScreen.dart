import 'package:flutter/material.dart';

import 'CollectionSummary.dart';
import 'HistoryScreen.dart';

class ViewReport extends StatelessWidget {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Revenue Summary'),
    Tab(text: 'History'),
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
            backgroundColor: Colors.blue[700],
            elevation: 5,     
            bottom: TabBar(
              tabs: myTabs,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: CollectionSummary()),
            Center(child: HistoryScreen()),
          ],
        ),
      ),
    );
  }
}
