import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Backend/Session.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Notification/Snack_notification.dart';
import '../DashBoard/TimeCollection.dart';
import '../NewLoan/SelectionOfProductsPage.dart';
import '../Borrowers/BorrowersPage.dart';
import '../Payment/PaymentPage.dart';
import '../CreditApproval/CreditPage.dart';
import '../RequestedProducts/RequestedProdScreen.dart';
import '../Repairs/RepairsScreen.dart';
import '../Inventory/InventoryPage.dart';
import '../Reports/ReportScreen.dart';
import '../Employees/EmployeePage.dart';

class NavDrawer extends StatefulWidget {
  final Function? callback;
  NavDrawer({this.callback});
  @override
  _NavDrawer createState() => _NavDrawer();
}

class _NavDrawer extends State<NavDrawer> {
  int _selectedIndex = 0;

  List<Widget> pages = [
    TimeCollection(),
    SelectionOfProductsPage(),
    BorrowersPage(),
    PaymentPage(),
    CreditScreen(),
    RequestedProdScreen(),
    RepairsPage(),
    InventoryPage(),
    ViewReport(),
    EmployeePage(),
  ];

  @override
  void initState() {
    super.initState();

    Session.getid().then((id) {
      setState(() {
        if (id.compareTo('') == 0) {
          Navigator.pushNamed(context, '/logout');
        }
      });
    });
  }

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
              if (Mapping.userRole == 'Store Attendant') {
                if (index == 9) {
                  SnackNotification.notif(
                    "No Access",
                    "You don't have right to access this tab",
                    Colors.red.shade500,
                  );
                }
                return;
              }
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: <NavigationRailDestination>[
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
                      backgroundColor: HexColor("#155293"),
                      mouseCursor: MaterialStateMouseCursor.clickable,
                      child: Icon(
                        Icons.refresh,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          pages[_selectedIndex] = pages[_selectedIndex];
                        });
                      },
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
