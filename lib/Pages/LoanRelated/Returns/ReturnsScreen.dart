import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Backend/BorrowerOperation.dart';
import 'package:web_store_management/Backend/GlobalController.dart';
import 'package:web_store_management/Backend/TextMessage.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Models/BorrowerModel.dart';
import 'package:web_store_management/Notification/BannerNotif.dart';
import 'package:web_store_management/Pages/LoanRelated/Returns/SearchSerialNumber.dart';

class ReturnsPage extends StatefulWidget {
  @override
  _ReturnsPage createState() => _ReturnsPage();

  final String statusPending = 'PENDING';
  final String statusReturned = 'RETURNED';
  final String statusRejected = 'REJECTED';
  final List<String> filters = ['PENDING', 'RETURNED', 'REJECTED'];
}

class _ReturnsPage extends State<ReturnsPage> {
  var controller = GlobalController();
  var borrower = BorrowerOperation();
  var message = TextMessage();

  late Future<List<BorrowerModel>> _returns;
  List<BorrowerModel> _borrowerFiltered = [];
  List<String> filteredStatus = [];

  TextEditingController searchValue = TextEditingController();
  String _searchResult = '';
  bool _sortAscending = true;

  @override
  void initState() {
    controller.fetchBorrowers();
    _returns = controller.fetchReturns(widget.statusPending);
    _returns.whenComplete(() => _borrowerFiltered = Mapping.returns);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 20, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topLeft,
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
                        label: Text('NEW RETURN'),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SearchSerialNumber();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Wrap(
                      children: productTypeWidget().toList(),
                    ),
                  ),
                  Container(
                    width: 300,
                    padding: EdgeInsets.only(bottom: 10),
                    child: TextField(
                      controller: searchValue,
                      onChanged: (value) {
                        setState(() {
                          _searchResult = value;
                          _borrowerFiltered = Mapping.returns
                              .where((brw) => brw.getFullname
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
                        contentPadding: EdgeInsets.only(left: 15),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueGrey.shade50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueGrey.shade50),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            width: (MediaQuery.of(context).size.width),
            height: (MediaQuery.of(context).size.height),
            child: FutureBuilder<List<BorrowerModel>>(
              future: _returns,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      semanticsLabel: 'Fetching returns',
                    ),
                  );
                }
                if (snapshot.hasData) {
                  if (snapshot.data!.length > 0) {
                    return GridView.count(
                      crossAxisCount: 4,
                      crossAxisSpacing: 40,
                      mainAxisSpacing: 40,
                      shrinkWrap: true,
                      childAspectRatio: (MediaQuery.of(context).size.width) /
                          (MediaQuery.of(context).size.height) /
                          2.5,
                      children: _cards(_borrowerFiltered),
                    );
                  } else {
                    return Center(
                      child: Text(
                        'NO RETURNS FOUND',
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
                      'NO RETURNS FOUND',
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
            borderRadius: BorderRadius.circular(20),
          ),
          shadowColor: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(brwRepair[index].getReturnStatus,
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
                        'Product Name \n and Serial no.',
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
                        "${brwRepair[index].getReturnProductName} SN:${brwRepair[index].getProductItemId}",
                        overflow: TextOverflow.visible,
                        softWrap: true,
                        maxLines: 2,
                        style: TextStyle(
                          fontFamily: 'Cairo_SemiBold',
                          fontSize: 14,
                        ),
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
                          left: 10, top: 10, bottom: 10, right: 85),
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
                        brwRepair[index].getFullname,
                        overflow: TextOverflow.visible,
                        softWrap: true,
                        maxLines: 2,
                        style: TextStyle(
                          fontFamily: 'Cairo_SemiBold',
                          fontSize: 14,
                        ),
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
                          left: 10, top: 10, bottom: 10, right: 75),
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
                        brwRepair[index].getHomeAddress,
                        overflow: TextOverflow.visible,
                        softWrap: true,
                        maxLines: 3,
                        style: TextStyle(
                          fontFamily: 'Cairo_SemiBold',
                          fontSize: 14,
                        ),
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
                          left: 10, top: 10, bottom: 10, right: 75),
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
                        brwRepair[index].getMobileNumber,
                        overflow: TextOverflow.visible,
                        softWrap: true,
                        maxLines: 2,
                        style: TextStyle(
                          fontFamily: 'Cairo_SemiBold',
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible:
                    brwRepair[index].getReturnStatus == widget.statusPending,
                child: ButtonBar(
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
                                  left: 20, right: 20, top: 10, bottom: 10),
                              primary: Colors.white,
                              textStyle: TextStyle(
                                  fontSize: 18, fontFamily: 'Cairo_SemiBold'),
                            ),
                            child: const Text('RETURN'),
                            onPressed: () {
                              repairStatus(
                                brwRepair[index].getReturnId,
                                widget.statusReturned,
                                brwRepair[index].getReturnProductName,
                                brwRepair[index].getFullname,
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
                      tooltip: 'Reject',
                      onPressed: () {
                        repairStatus(
                          brwRepair[index].getReturnId,
                          widget.statusRejected,
                          brwRepair[index].getReturnProductName,
                          brwRepair[index].toString(),
                          brwRepair[index].getMobileNumber,
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Iterable<Widget> productTypeWidget() {
    return widget.filters.map((status) {
      return Padding(
        padding: const EdgeInsets.only(right: 15),
        child: ChoiceChip(
          label: Text(status),
          selected: filteredStatus.contains(status),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                filteredStatus.add(status);
                _returns = controller.fetchReturns(status);
                _returns
                    .whenComplete(() => _borrowerFiltered = Mapping.returns);
              } else {
                filteredStatus.removeWhere((name) {
                  _borrowerFiltered = Mapping.returns;
                  return name == status;
                });
              }
            });
          },
        ),
      );
    });
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
    borrower.updateReturn(id, status).then((value) {
      if (!value) {
        BannerNotif.notif(
          'Error',
          'Something went wrong while updating the returns',
          Colors.redAccent.shade200,
        );
      } else {
        //refresh the future and the widget
        setState(() {
          _returns = controller.fetchReturns(widget.statusPending);
          _returns.whenComplete(() => _borrowerFiltered = Mapping.returns);
        });
        //send message to the receiver
        _returns.whenComplete(() {
          sendRepairedMessage(name, number, product, status);
        });
      }
    });
  }
}
