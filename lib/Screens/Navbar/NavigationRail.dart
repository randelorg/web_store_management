import 'package:flutter/material.dart';
import 'package:web_store_management/Backend/Session.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';

import '../DashBoard/TimeCollection.dart';
import '../NewLoan/HomeNewLoan.dart';
import '../Borrowers/BorrowersScreen.dart';
import '../Payment/PaymentScreen.dart';
import '../CreditApproval/CreditScreen.dart';
import '../RequestedProducts/RequestedProdScreen.dart';
import '../Repairs/RepairsScreen.dart';
import '../Inventory/InventoryScreen.dart';
import '../Reports/ReportScreen.dart';
import '../Employees/EmployeeScreen.dart';
import '../../Backend/Login_operation.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawer createState() => _NavDrawer();
}

class _NavDrawer extends State<NavDrawer> {
  var prefs = Session();

  @override
  void initState() {
    super.initState();
    prefs.getid().then((id) {
      setState(() {
        if (id.compareTo('') == 0) {
          Navigator.pushNamed(context, '/logout');
        }
      });
    });
  }

  int _selectedIndex = 1;

  var pages = [
    TimeCollection(),
    HomeNewLoan(),
    BorrowersScreen(),
    PaymentScreen(),
    CreditScreen(),
    RequestedProdScreen(),
    RepairsScreen(),
    InventoryScreen(),
    ViewReport(),
    EmployeeScreen(),
  ];

  var title = [
    "Dashboard",
    'New Loan',
    'Borrowers',
    'Payment',
    'Credit Approval',
    'Requested Products',
    'Repairs',
    'Inventory',
    'Reports',
    'Employees'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          //list[_selectedIndex],
          NavigationRail(
            elevation: 5,
            minWidth: 30.0,
            minExtendedWidth: 50.0,
            backgroundColor: Colors.grey.shade900,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(
                  Icons.space_dashboard,
                  color: Colors.white,
                ),
                label: Text(
                  'Dashboard',
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.create,
                  color: Colors.white,
                ),
                label: Text(
                  'New Loan',
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.group,
                  color: Colors.white,
                ),
                label: Text(
                  'Borrowers',
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.payments,
                  color: Colors.white,
                ),
                label: Text(
                  'Payment',
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.credit_score,
                  color: Colors.white,
                ),
                label: Text(
                  'Credit \n Approval',
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.request_quote,
                  color: Colors.white,
                ),
                label: Text(
                  'Request',
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.build,
                  color: Colors.white,
                ),
                label: Text(
                  'Repair',
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.inventory_2,
                  color: Colors.white,
                ),
                label: Text(
                  'Inventory',
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.insights,
                  color: Colors.white,
                ),
                label: Text(
                  'Reports',
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.badge,
                  color: Colors.white,
                ),
                label: Text(
                  'Employees',
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const VerticalDivider(width: 5),
          // This is the main content.
          //this is how we navigate
          //this is where the menus content will be displayed
          Expanded(
            child: Stack(
              clipBehavior: Clip.antiAlias,
              children: <Widget>[
                Center(
                  child: pages[_selectedIndex],
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  alignment: Alignment.bottomLeft,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    //refresh button
                    child: FloatingActionButton(
                      mouseCursor: MaterialStateMouseCursor.clickable,
                      child: Icon(
                        Icons.refresh,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

