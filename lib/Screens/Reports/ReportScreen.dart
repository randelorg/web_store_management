import 'package:flutter/material.dart';

import 'CollectionSummary.dart';
import 'HistoryScreen.dart';

class ViewReport extends StatelessWidget {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Revenue summary'),
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
