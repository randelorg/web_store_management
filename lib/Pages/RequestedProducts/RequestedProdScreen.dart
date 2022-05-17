import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Backend/BorrowerOperation.dart';
import 'package:web_store_management/Backend/GlobalController.dart';
import 'package:web_store_management/Backend/TextMessage.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Models/BorrowerModel.dart';
import 'package:web_store_management/Notification/BannerNotif.dart';
import 'package:web_store_management/Pages/RequestedProducts/ReqManualSearchBorrower.dart';

class RequestedProdScreen extends StatefulWidget {
  @override
  _RequestedProdScreen createState() => _RequestedProdScreen();
}

class _RequestedProdScreen extends State<RequestedProdScreen> {
  var controller = GlobalController();
  var borrower = BorrowerOperation();
  var message = TextMessage();
  List<BorrowerModel> _borrowerFiltered = [];
  TextEditingController searchValue = TextEditingController();
  String _searchResult = '';
  late Future<List<BorrowerModel>> _requested;
  final double textSize = 15;
  final double titleSize = 30;

  @override
  void initState() {
    //controller.fetchBorrowers();
    _requested = controller.fetchRequestedProducts();
    _requested.whenComplete(() => _borrowerFiltered = Mapping.requested);
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
                        label: Text('NEW REQUEST'),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ReqManualBorrowerSearch();
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
                        _borrowerFiltered = Mapping.requested
                            .where((brw) => brw
                                .toString()
                                .toLowerCase()
                                .contains(_searchResult.toLowerCase()))
                            .toList();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search Request',
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
        FutureBuilder<List<BorrowerModel>>(
          future: _requested,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  semanticsLabel: 'Fetching requested products',
                ),
              );
            }
            if (snapshot.hasData) {
              if (snapshot.data!.length > 0) {
                return Expanded(
                  child: Container(
                    padding: EdgeInsets.only(right: 20, left: 20),
                    width: (MediaQuery.of(context).size.width),
                    height: (MediaQuery.of(context).size.height),
                    child: GridView.count(
                      crossAxisCount: 5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      shrinkWrap: true,
                      childAspectRatio: (MediaQuery.of(context).size.width) /
                          (MediaQuery.of(context).size.height) /
                          2.5,
                      children: _cards(_borrowerFiltered),
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    'NO REQUESTED PRODUCTS',
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
                  'NO REQUESTED PRODUCTS',
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
      ],
    );
  }

  List<Widget> _cards(List<BorrowerModel> brwRequest) {
    return List.generate(
      brwRequest.length,
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
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
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
                          left: 10, top: 10, bottom: 10, right: 30),
                      child: Text(
                        'Requested \n Product',
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
                        brwRequest[index].getRequestedProductName,
                        overflow: TextOverflow.visible,
                        maxLines: 2,
                        softWrap: true,
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
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 10, bottom: 10, right: 56),
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
                        brwRequest[index].toString(),
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
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 10, bottom: 10, right: 46),
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
                        brwRequest[index].getHomeAddress,
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
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 10, bottom: 10, right: 48),
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
                        brwRequest[index].getMobileNumber,
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
                          child: const Text('IN-STORE'),
                          onPressed: () {
                            requestStatus(
                              brwRequest[index].getRequestId,
                              'IN-STORE',
                              brwRequest[index].getRequestedProductName,
                              brwRequest[index].toString(),
                              brwRequest[index].getMobileNumber,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_forever),
                    color: Colors.redAccent.shade400,
                    tooltip: 'DENY REQUEST',
                    onPressed: () {
                      requestStatus(
                        brwRequest[index].getRequestId,
                        'DENIED',
                        brwRequest[index].getRequestedProductName,
                        brwRequest[index].toString(),
                        brwRequest[index].getMobileNumber,
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

  void sendRequestedMessage(
      String name, String number, String product, String status) {
    message
        .sendRequestedProduct(name, number, product, status)
        .then((value) => {
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

  void requestStatus(
      int id, final String status, String product, String name, String number) {
    borrower.updateRequest(id, status).then((value) {
      if (!value) {
        BannerNotif.notif(
          'Error',
          'Something went wrong while updating the request',
          Colors.redAccent.shade200,
        );
      } else {
        setState(() {
          _requested = controller.fetchRequestedProducts();
          _requested.whenComplete(() => _borrowerFiltered = Mapping.requested);
        });
        //send message to the receiver
        _requested.whenComplete(
            () => sendRequestedMessage(name, number, product, status));
      }
    });
  }
}
