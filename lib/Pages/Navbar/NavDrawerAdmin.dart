import 'package:flutter/material.dart';
import 'package:web_store_management/Backend/Session.dart';
import 'package:web_store_management/Pages/Branch/BranchPage.dart';
import 'package:web_store_management/Pages/Release/ReleasePage.dart';
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

class NavDrawerAdmin extends StatefulWidget {
  @override
  _NavDrawerAdmin createState() => _NavDrawerAdmin();
}

class _NavDrawerAdmin extends State<NavDrawerAdmin> {
  @override
  void initState() {
    Session.getid().then((id) {
      setState(() {
        if (id.isEmpty) {
          Navigator.pushReplacementNamed(context, '/logout');
        }
      });
    });
    super.initState();
  }

  int _selectedDestination = 0;
  final double iconSize = 35;

  List<Widget> pages = [
    TimeCollection(),
    InventoryPage(),
    SelectionOfProductsPage(),
    CreditScreen(),
    ReleasePage(),
    BorrowersPage(),
    PaymentPage(),
    RequestedProdScreen(),
    RepairsPage(),
    ViewReport(),
    EmployeePage(),
    BranchPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          LayoutBuilder(
            builder: ((context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: NavigationRail(
                      elevation: 5,
                      minWidth: 10,
                      minExtendedWidth: 20.0,
                      backgroundColor: Colors.grey.shade900,
                      selectedIndex: _selectedDestination,
                      onDestinationSelected: (int index) {
                        setState(() {
                          _selectedDestination = index;
                        });
                      },
                      labelType: NavigationRailLabelType.all,
                      destinations: [
                        NavigationRailDestination(
                          icon: Icon(
                            Icons.space_dashboard,
                            color: Colors.white,
                          ),
                          selectedIcon: Icon(
                            Icons.space_dashboard,
                            color: Colors.red,
                            size: iconSize,
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
                            Icons.inventory_2,
                            color: Colors.white,
                          ),
                          selectedIcon: Icon(
                            Icons.inventory_2,
                            color: Colors.red,
                            size: iconSize,
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
                            Icons.create,
                            color: Colors.white,
                          ),
                          selectedIcon: Icon(
                            Icons.create,
                            color: Colors.red,
                            size: iconSize,
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
                            Icons.credit_score,
                            color: Colors.white,
                          ),
                          selectedIcon: Icon(
                            Icons.credit_score,
                            color: Colors.red,
                            size: iconSize,
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
                            Icons.new_releases,
                            color: Colors.white,
                          ),
                          selectedIcon: Icon(
                            Icons.new_releases,
                            color: Colors.red,
                            size: iconSize,
                          ),
                          label: Text(
                            'Release \n Product',
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
                            Icons.group,
                            color: Colors.white,
                          ),
                          selectedIcon: Icon(
                            Icons.group,
                            color: Colors.red,
                            size: iconSize,
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
                          selectedIcon: Icon(
                            Icons.payments,
                            color: Colors.red,
                            size: iconSize,
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
                            Icons.request_quote,
                            color: Colors.white,
                          ),
                          selectedIcon: Icon(
                            Icons.request_quote,
                            color: Colors.red,
                            size: iconSize,
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
                          selectedIcon: Icon(
                            Icons.build,
                            color: Colors.red,
                            size: iconSize,
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
                            Icons.insights,
                            color: Colors.white,
                          ),
                          selectedIcon: Icon(
                            Icons.insights,
                            color: Colors.red,
                            size: iconSize,
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
                          selectedIcon: Icon(
                            Icons.badge,
                            color: Colors.red,
                            size: iconSize,
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
                        NavigationRailDestination(
                          icon: Icon(
                            Icons.store,
                            color: Colors.white,
                          ),
                          selectedIcon: Icon(
                            Icons.store,
                            color: Colors.red,
                            size: iconSize,
                          ),
                          label: Text(
                            'Branch',
                            softWrap: true,
                            style: TextStyle(
                              fontSize: 8,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
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
                  child: pages[_selectedDestination],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
