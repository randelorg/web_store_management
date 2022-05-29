import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Backend/BorrowerOperation.dart';
import 'package:web_store_management/Backend/GlobalController.dart';
import 'package:web_store_management/Backend/TextMessage.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Models/BorrowerModel.dart';
import 'package:web_store_management/Notification/BannerNotif.dart';
import 'package:web_store_management/Pages/LoanRelated/Repairs/ManualBorrowerSearch.dart';

class ReturnsPage extends StatefulWidget {
  @override
  _ReturnsPage createState() => _ReturnsPage();
}

class _ReturnsPage extends State<ReturnsPage> {
  var controller = GlobalController();
  var borrower = BorrowerOperation();
  var message = TextMessage();
  late Future<List<BorrowerModel>> _repairs;
  List<BorrowerModel> _borrowerFiltered = [];
  TextEditingController searchValue = TextEditingController();
  String _searchResult = '';
  final double textSize = 15;
  final double titleSize = 30;
  bool _sortAscending = true;

  @override
  void initState() {
    controller.fetchBorrowers();
    _repairs = controller.fetchRepairs();
    _repairs.whenComplete(() => _borrowerFiltered = Mapping.repairs);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 20, top: 10),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: const Text(
                  'Payments',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontFamily: 'Cairo_SemiBold',
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
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
                        icon: Icon(Icons.add_box_rounded, color: Colors.white),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          primary: Colors.white,
                          textStyle: TextStyle(
                              fontSize: 18, fontFamily: 'Cairo_SemiBold'),
                        ),
                        label: Text('NEW REPAIRS'),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ManualBorrowerSearch();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  //padding: EdgeInsets.only(top: 15, bottom: 15, right: 20),
                  width: 300,
                  child: TextField(
                    controller: searchValue,
                    onChanged: (value) {
                      setState(() {
                        _searchResult = value;
                        _borrowerFiltered = Mapping.repairs
                            .where((brw) => brw
                                .toString()
                                .toLowerCase()
                                .contains(_searchResult.toLowerCase()))
                            .toList();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search Borrower',
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
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            width: (MediaQuery.of(context).size.width),
            height: (MediaQuery.of(context).size.height),
            child: FutureBuilder<List<BorrowerModel>>(
              future: _repairs,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      semanticsLabel: 'Fetching repairs',
                    ),
                  );
                }
                if (snapshot.hasData) {
                  if (snapshot.data!.length > 0) {
                    return GridView.count(
                      crossAxisCount: 5,
                      crossAxisSpacing: 50,
                      mainAxisSpacing: 50,
                      shrinkWrap: true,
                      childAspectRatio: (MediaQuery.of(context).size.width) /
                          (MediaQuery.of(context).size.height) /
                          2.5,
                      children: _cards(_borrowerFiltered),
                    );
                  } else {
                    return Center(
                      child: Text(
                        'NO REPAIRS FOUND',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontFamily: 'Cairo_SemiBold',
                          fontSize: 20,
                        ),
                      ),
                    );
                  }
                } else {
                  return Center(
                    child: Text(
                      'NO REPAIRS FOUND',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontFamily: 'Cairo_SemiBold',
                        fontSize: 20,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _cards(List<BorrowerModel> brwRepair) {
    return List.generate(
      brwRepair.length,
      (index) {
        return new Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35.0),
          ),
          shadowColor: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: ListTile(
                  title: Text('PENDING',
                      style: TextStyle(
                          fontSize: 30, fontFamily: 'Cairo_SemiBold')),
                  subtitle: Text(
                    'status',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                shadowColor: Colors.black,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 10, bottom: 10, right: 40),
                      child: Text(
                        'Product \n Name',
                        softWrap: true,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontFamily: 'Cairo_SemiBold',
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        brwRepair[index].getRepairProductName,
                        overflow: TextOverflow.visible,
                        softWrap: true,
                        maxLines: 2,
                        style: TextStyle(
                            fontFamily: 'Cairo_SemiBold', fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                shadowColor: Colors.black,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 10, bottom: 10, right: 53),
                      child: Text(
                        'Name',
                        softWrap: true,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontFamily: 'Cairo_SemiBold',
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        brwRepair[index].toString(),
                        overflow: TextOverflow.visible,
                        softWrap: true,
                        maxLines: 2,
                        style: TextStyle(
                            fontFamily: 'Cairo_SemiBold', fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                shadowColor: Colors.black,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 10, bottom: 10, right: 43),
                      child: Text(
                        'Address',
                        softWrap: true,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontFamily: 'Cairo_SemiBold',
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        brwRepair[index].getHomeAddress,
                        overflow: TextOverflow.visible,
                        softWrap: true,
                        maxLines: 3,
                        style: TextStyle(
                            fontFamily: 'Cairo_SemiBold', fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                shadowColor: Colors.black,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 10, bottom: 10, right: 44),
                      child: Text(
                        'Number',
                        softWrap: true,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontFamily: 'Cairo_SemiBold',
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        brwRepair[index].getMobileNumber,
                        overflow: TextOverflow.visible,
                        softWrap: true,
                        maxLines: 2,
                        style: TextStyle(
                            fontFamily: 'Cairo_SemiBold', fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
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
                        TextButton(
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 12, bottom: 12),
                              primary: Colors.white,
                              textStyle: TextStyle(
                                  fontSize: 18, fontFamily: 'Cairo_SemiBold')),
                          child: const Text('REPAIRED'),
                          onPressed: () {
                            repairStatus(
                              brwRepair[index].getRepairId,
                              'REPAIRED',
                              brwRepair[index].getRepairProductName,
                              brwRepair[index].toString(),
                              brwRepair[index].getMobileNumber,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_forever),
                    color: Colors.redAccent.shade400,
                    tooltip: 'UNREPAIRABLE',
                    onPressed: () {
                      repairStatus(
                        brwRepair[index].getRepairId,
                        'UNREPAIRABLE',
                        brwRepair[index].getRepairProductName,
                        brwRepair[index].toString(),
                        brwRepair[index].getMobileNumber,
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  void sendRepairedMessage(
      String name, String number, String product, String status) {
    message.sendRepairedProduct(name, number, product, status).then((value) => {
          if (value)
            {
              BannerNotif.notif(
                'PENDING',
                'The message is in transit to the network',
                Colors.orange.shade500,
              )
            }
        });
  }

  void repairStatus(
      int id, final String status, String product, String name, String number) {
    borrower.updateRepair(id, status).then((value) {
      if (!value) {
        BannerNotif.notif(
          'Error',
          'Something went wrong while updating the repair',
          Colors.redAccent.shade200,
        );
      } else {
        //refresh the future and the widget
        setState(() {
          _repairs = controller.fetchRepairs();
          _repairs.whenComplete(() => _borrowerFiltered = Mapping.repairs);
        });
        //send message to the receiver
        _repairs.whenComplete(() {
          sendRepairedMessage(name, number, product, status);
        });
      }
    });
  }
}
