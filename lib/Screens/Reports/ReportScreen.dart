import 'package:flutter/material.dart';

import 'CollectionSummary.dart';

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
        appBar: AppBar(
          bottom: TabBar(
            tabs: myTabs,
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: CollectionSummary()),
            Center(child: CollectionSummary()),
          ],
        ),
      ),
    );
  }
}
