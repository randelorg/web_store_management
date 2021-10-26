import 'package:flutter/material.dart';

class EmployeeScreen extends StatefulWidget {
  @override
  _EmployeeScreen createState() => _EmployeeScreen();
}

class _EmployeeScreen extends State<EmployeeScreen> {
  String collector = 'Collector';
  String storeAttendant = 'Store Attendant';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 15, top: 15, right: 40),
              child: Container(
                width: 200,
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  color: Colors.black,
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
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.blue.shade700),
                    onChanged: (String? newValue) {
                      setState(() {
                        collector = newValue!;
                      });
                    },
                    items: <String>['Collector', 'Store Attendant']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15, bottom: 15, right: 100),
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search borrower',
                  suffixIcon: InkWell(
                    child: IconButton(
                      icon: Icon(Icons.qr_code_scanner_outlined),
                      color: Colors.grey,
                      tooltip: 'Search by QR',
                      onPressed: () {
                        // showDialog(
                        //   context: context,
                        //   builder: (BuildContext context) {
                        //     return ReadQR();
                        //   },
                        // );
                      },
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
        Expanded(
          child: Container(
            width: (MediaQuery.of(context).size.width),
            height: (MediaQuery.of(context).size.height),
            child: ListView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.only(right: 100, left: 100),
              children: [
                PaginatedDataTable(
                  showCheckboxColumn: false,
                  rowsPerPage: 15,
                  columns: [
                    DataColumn(label: Text('EID')),
                    DataColumn(label: Text('Roll')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Number')),
                    DataColumn(label: Text('Profile')),
                    DataColumn(label: Text('Payroll')),
                  ],
                  source: _DataSource(context),
                )
              ],
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

List _borrowerProfile(BuildContext context) {
  List<_Row> _employees;

  return _employees = List.generate(25, (index) {
    int tot = index + 1;
    return new _Row(
      tot.toString(),
      'CellB2',
      'CellC2',
      "CellC1",
      ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                primary: Colors.white,
                textStyle: const TextStyle(fontSize: 15),
              ),
              onPressed: () {
                // show here employee profile

                // showDialog(
                //   context: context,
                //   builder: (BuildContext context) {
                //     return ViewBorrowerProfile();
                //   },
                // );
              },
              child: const Text('PROFILE'),
            ),
          ],
        ),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                primary: Colors.white,
                textStyle: const TextStyle(fontSize: 15),
              ),
              onPressed: () {
                // show here the payroll

                // showDialog(
                //   context: context,
                //   builder: (BuildContext context) {
                //     return ViewBorrowerProfile();
                //   },
                // );
              },
              child: const Text('PAYROLL'),
            ),
          ],
        ),
      ),
    );
  });
}

class _DataSource extends DataTableSource {
  _DataSource(this.context) {
    _borrowerProfile(context);
  }

  final BuildContext context;

  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _borrowerProfile(context).length) return null;
    final row = _borrowerProfile(context)[index];
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
        DataCell((row.valueE)),
        DataCell((row.valueF)),
      ],
    );
  }

  @override
  int get rowCount => _borrowerProfile(context).length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
