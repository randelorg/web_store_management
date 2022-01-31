import 'package:flutter/material.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import '../../Backend/GlobalController.dart';
import 'package:hexcolor/hexcolor.dart';

class PayrollPage extends StatefulWidget {
  final String? employeeName;
  PayrollPage({this.employeeName});
  @override
  _Payrollpage createState() => _Payrollpage();
}

class _Payrollpage extends State<PayrollPage> {
  var controller = GlobalController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        
        Padding(
          padding: EdgeInsets.only(bottom: 5, left: 5, right: 5),
          child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
        ),
            
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, top: 20, bottom: 5),
              child: Text(
                widget.employeeName.toString().toUpperCase(),
                style: TextStyle(
                  color: HexColor("#155293"),
                  fontFamily: 'Cairo_Bold',
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
        FutureBuilder(
          future: controller.fetchAllEmployees(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  semanticsLabel: 'Fetching employees',
                ),
              );
            }
            if (snapshot.hasData) {
              return Expanded(
                child: Container(
                  width: (MediaQuery.of(context).size.width),
                  height: (MediaQuery.of(context).size.height),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.only(top: 20),
                    children: [
                      PaginatedDataTable(
                        showCheckboxColumn: false,
                        rowsPerPage: 10,
                        columns: [
                          DataColumn(label: Text('PYID')),
                          DataColumn(label: Text('CHECKIN')),
                          DataColumn(label: Text('CHECKOUT')),
                          DataColumn(label: Text('WAGE')),
                        ],
                        source: _DataSource(context),
                      )
                    ],
                  ),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                semanticsLabel: 'Fetching borrowers',
              ),
            );
          },
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
  );

  final String valueA;
  final String valueB;
  final String valueC;
  final String valueD;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context) {
    payroll = _borrowerProfile();
  }

  final BuildContext context;
  List<_Row> payroll = [];
  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _borrowerProfile().length) return null;
    final row = _borrowerProfile()[index];
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
      ],
    );
  }

  @override
  int get rowCount => _borrowerProfile().length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

List<_Row> _borrowerProfile() {
  try {
    return List.generate(Mapping.employeeList.length, (index) {
      return new _Row(
        Mapping.employeeList[index].getEmployeeID.toString(),
        Mapping.employeeList[index].getRole.toString(),
        Mapping.employeeList[index].toString(),
        Mapping.employeeList[index].getMobileNumber.toString(),
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
      );
    });
  }
}
