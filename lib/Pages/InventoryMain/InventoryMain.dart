import 'package:flutter/material.dart';
import 'package:web_store_management/Pages/InventoryMain/IncomingPurchases.dart';
import 'package:web_store_management/Pages/InventoryMain/InventoryDashboard.dart';

class InventoryMain extends StatelessWidget {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Inventory'),
    Tab(text: 'Incoming Purchases'),
    Tab(text: 'Outgoing Orders'),
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
            Center(child: InventoryDashboard()),
            Center(child: IncomingPurchases()),
            Center(child: InventoryDashboard()),
          ],
        ),
      ),
    );
  }
}
