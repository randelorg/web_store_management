import 'package:flutter/material.dart';
import 'package:web_store_management/Pages/LoanRelated/CreditApproval/CreditPage.dart';
import 'package:web_store_management/Pages/LoanRelated/Release/ReleasePage.dart';
import 'package:web_store_management/Pages/LoanRelated/Returns/ReturnsScreen.dart';

class GroupLoan extends StatelessWidget {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Credit Approval'),
    Tab(text: 'Release Products'),
    Tab(text: 'Returns'),
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
            Center(child: CreditScreen()),
            Center(child: ReleasePage()),
            Center(child: ReturnsPage()),
          ],
        ),
      ),
    );
  }
}
