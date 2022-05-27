import 'package:flutter/material.dart';
import 'package:web_store_management/Backend/Session.dart';
import 'package:web_store_management/Pages/Branch/BranchPage.dart';
import 'package:web_store_management/Pages/InventoryMain/InventoryMain.dart';
import 'package:web_store_management/Pages/LoanRelated/GroupLoan.dart';
import 'package:web_store_management/Pages/Purchase/PurchaseProducts.dart';
import '../DashBoard/TimeCollection.dart';
import '../NewLoan/SelectionOfProductsPage.dart';
import '../Borrowers/BorrowersPage.dart';
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
    InventoryMain(),
    PurchaseProducts(),
    InventoryPage(),
    SelectionOfProductsPage(),
    BorrowersPage(),
    GroupLoan(),
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
                            'Inventory NEW',
                            softWrap: true,
                            style: TextStyle(
                              fontSize: 8,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        NavigationRailDestination(
                          icon: Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                          selectedIcon: Icon(
                            Icons.shopping_basket,
                            color: Colors.red,
                            size: iconSize,
                          ),
                          label: Text(
                            'Purchase',
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
                            Icons.workspaces,
                            color: Colors.white,
                          ),
                          selectedIcon: Icon(
                            Icons.workspaces,
                            color: Colors.red,
                            size: iconSize,
                          ),
                          label: Text(
                            'Loan related',
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
