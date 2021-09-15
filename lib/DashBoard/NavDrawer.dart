import 'package:flutter/material.dart';

import 'GraphText.dart';
import '../LoginPage/LoginPage.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawer createState() => _NavDrawer();
}

class _NavDrawer extends State<NavDrawer>{
  int _selectedIndex = 0;

  var pages = [
    GraphText(),
    LoginPage(),
  ];

  var title = [
    "Graph",
    'Login',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          //list[_selectedIndex],
          NavigationRail(
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
                icon: Icon(Icons.create),
                label: Text(
                    'New Loan',
                  style: TextStyle(

                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.group),
                label: Text(
                    'Borrowers',
                    style: TextStyle(
                    
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.payments),
                label: Text(
                    'Payment',
                    style: TextStyle(
                    
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.credit_score),
                label: Text(
                    'Credit Approval',
                    style: TextStyle(
                    
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.request_quote),
                label: Text(
                    'Request',
                    style: TextStyle(
                    
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.build),
                label: Text(
                    'Repair',
                    style: TextStyle(
                    
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.inventory_2),
                label: Text(
                    'Inventory',
                    style: TextStyle(
                    
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.insights),
                label: Text(
                    'Reports',
                    style: TextStyle(
                    
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.badge),
                label: Text(
                    'Collectors',
                    style: TextStyle(
                    
                  ),
                ),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 100.0),
          // This is the main content.
          //this is how we navigate
          Expanded(
            child: Center(
              child: pages[_selectedIndex],
            )
          )
        ],
      ),
    );
  }
}