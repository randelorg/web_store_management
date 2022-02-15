import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Pages/Employees/PayrollPage.dart';
import 'AddEmployee.dart';
import 'ViewEmpProfile.dart';
import '../../Backend/GlobalController.dart';

class EmployeePage extends StatefulWidget {
  @override
  _Employeepage createState() => _Employeepage();
}

class _Employeepage extends State<EmployeePage> {
  var controller = GlobalController();
  String collector = 'Collector';
  String storeAttendant = 'Store Attendant';

  late Future employees;

  @override
  void initState() {
    super.initState();
    employees = controller.fetchAllEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15, left: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: HexColor("#155293"),
                            ),
                          ),
                        ),
                        TextButton.icon(
                          icon:Icon(Icons.add_box_rounded, color: Colors.white),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                            primary: Colors.white,
                            textStyle: TextStyle(fontSize: 18, fontFamily: 'Cairo_SemiBold'),
                          ),
                          label: Text('NEW EMPLOYEE'),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AddEmployee();
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                    padding: EdgeInsets.only(bottom: 30, top: 15, right: 15),
                    child: Text('Sort by')),
                Padding(
                  padding: EdgeInsets.only(bottom: 15, top: 15, right: 40),
                  child: Container(
                    width: 200,
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blueGrey.shade50,
                        style: BorderStyle.solid,
                        width: 0.80,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: collector,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: HexColor("#155293")),
                        onChanged: (String? newValue) {
                          setState(() {
                            collector = newValue!;
                          });
                        },
                        items: <String>['Collector', 'Store Attendant']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: EdgeInsets.only(left: 25),
                              child: Text(
                                value,
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 15, bottom: 15, right: 100),
                  width: 400,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search Employee',
                      suffixIcon: InkWell(
                        child: IconButton(
                          icon: Icon(Icons.qr_code_scanner_outlined),
                          color: Colors.grey,
                          tooltip: 'Search by QR',
                          onPressed: () {},
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.blueGrey[50],
                      labelStyle: TextStyle(fontSize: 12),
                      contentPadding: EdgeInsets.only(left: 30),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey.shade50),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey.shade50),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Expanded(
          child: Container(
            width: (MediaQuery.of(context).size.width),
            height: (MediaQuery.of(context).size.height),
            child: FutureBuilder(
              future: employees,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      semanticsLabel: 'Fetching employees',
                    ),
                  );
                }
                if (snapshot.hasData) {
                  return ListView(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.only(right: 100, left: 100),
                    children: [
                      PaginatedDataTable(
                        showCheckboxColumn: false,
                        showFirstLastButtons: true,
                        rowsPerPage: 12,
                        columns: [
                          DataColumn(label: Text('EID')),
                          DataColumn(label: Text('ROLE')),
                          DataColumn(label: Text('NAME')),
                          DataColumn(label: Text('NUMBER')),
                          DataColumn(label: Text('PROFILE')),
                          DataColumn(label: Text('PAYROLL')),
                        ],
                        source: _DataSource(context),
                      )
                    ],
                  );
                }
                return Center(
                  child: CircularProgressIndicator(
                    semanticsLabel: 'Fetching borrowers',
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _Row {
  _Row(
    this.valueA,
    this.valueB,
    this.valueC,
    this.valueD,
    this.valueE,
    this.valueF,
  );

  final String valueA;
  final String valueB;
  final String valueC;
  final String valueD;
  final Widget valueE;
  final Widget valueF;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context) {
    _employees = _borrowerProfile(context);
  }

  final BuildContext context;

  int _selectedCount = 0;
  List<_Row> _employees = [];

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _employees.length) return null;
    final row = _employees[index];
    return DataRow.byIndex(
      index: index,
      selected: row.selected,
      onSelectChanged: (value) {
        if (row.selected != value) {
          var value = false;
          _selectedCount += value ? 1 : -1;
          assert(_selectedCount >= 0);
          row.selected = value;
          notifyListeners();
        }
      },
      cells: [
        DataCell(Text(row.valueA)),
        DataCell(Text(row.valueB)),
        DataCell(Text(row.valueC)),
        DataCell(Text(row.valueD)),
        DataCell((row.valueE), onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ViewEmpProfile(
                eid: row.valueA,
                role: row.valueB,
                name: row.valueC,
                number: row.valueD,
              );
            },
          );
        }),
        DataCell((row.valueF), onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width) / 2,
                    height: (MediaQuery.of(context).size.height),
                    child: PayrollPage(employeeName: row.valueC),
                  ),
                ],
              );
            },
          );
        }),
      ],
    );
  }

  @override
  int get rowCount => _employees.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  List<_Row> _borrowerProfile(BuildContext context) {
    try {
      return List.generate(Mapping.employeeList.length, (index) {
        return new _Row(
          Mapping.employeeList[index].getEmployeeID.toString(),
          Mapping.employeeList[index].getRole.toString(),
          Mapping.employeeList[index].toString(),
          Mapping.employeeList[index].getMobileNumber.toString(),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: HexColor("#155293"),
                    ),
                  ),
                ),
                Padding(
                 padding:EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
                  child: Text(
                    'PROFILE',
                    style: TextStyle(
                      fontFamily: 'Cairo_SemiBold',
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: HexColor("#155293"),
                    ),
                  ),
                ),
                Padding(
                  padding:EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
                  child: Text(
                    'PAYROLL',
                    style: TextStyle(
                      fontFamily: 'Cairo_SemiBold',
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
    } catch (e) {
      //if employees list is empty
      return List.generate(0, (index) {
        return _Row(
          '',
          '',
          '',
          '',
          Text(''),
          Text(''),
        );
      });
    }
  }
}
