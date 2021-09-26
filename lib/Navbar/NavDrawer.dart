import 'package:flutter/material.dart';
import 'package:web_store_management/NewLoan/BorrowersDetails.dart';

import '../DashBoard/GraphText.dart';
import '../NewLoan/BorrowersDetails.dart';
import '../Borrowers/BorrowersScreen.dart';
import '../Payment/PaymentScreen.dart';
import '../CreditApproval/CreditScreen.dart';
import '../RequestedProducts/RequestedProdScreen.dart';
import '../Repairs/RepairsScreen.dart';
import '../Inventory/InventoryScreen.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawer createState() => _NavDrawer();
}

class _NavDrawer extends State<NavDrawer> {
  int _selectedIndex = 7;

  var pages = [
    GraphText(),
    BorrowerDetail(),
    BorrowersScreen(),
    PaymentScreen(),
    CreditScreen(),
    RequestedProdScreen(),
    RepairsScreen(),
    InventoryScreen(),
  ];

  var title = [
    "Dashboard",
    'New Loan',
    'Borrowers',
    'Payment',
    'Credit Approval',
    'Requested Products',
    'Repairs',
    'Inventory'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          //list[_selectedIndex],
          NavigationRail(
            minWidth: 45.0,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            extended: true,
            labelType: NavigationRailLabelType.none,
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(Icons.space_dashboard),
                label: Text(
                  'Dashboard',
                  style: TextStyle(),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.create),
                label: Text(
                  'New Loan',
                  style: TextStyle(),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.group),
                label: Text(
                  'Borrowers',
                  softWrap: true,
                  style: TextStyle(),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.payments),
                label: Text(
                  'Payment',
                  softWrap: true,
                  style: TextStyle(),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.credit_score),
                label: Text(
                  'Credit Approval',
                  softWrap: true,
                  style: TextStyle(),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.request_quote),
                label: Text(
                  'Request',
                  softWrap: true,
                  style: TextStyle(),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.build),
                label: Text(
                  'Repair',
                  softWrap: true,
                  style: TextStyle(),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.inventory_2),
                label: Text(
                  'Inventory',
                  softWrap: true,
                  style: TextStyle(),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.insights),
                label: Text(
                  'Reports',
                  softWrap: true,
                  style: TextStyle(),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.badge),
                label: Text(
                  'Collectors',
                  softWrap: true,
                  style: TextStyle(),
                ),
              ),
            ],
          ),
          const VerticalDivider(width: 20),
          // This is the main content.
          //this is how we navigate
          //this is where the menus content will be displayed
          Expanded(
              child: Center(
            child: pages[_selectedIndex],
          )),
        ],
      ),
    );
  }
}
