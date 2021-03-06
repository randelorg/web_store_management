import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Backend/GlobalController.dart';
import 'package:web_store_management/Backend/LoanOperation.dart';
import 'package:web_store_management/Backend/TextMessage.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Models/BorrowerModel.dart';
import 'package:web_store_management/Notification/BannerNotif.dart';

class CreditScreen extends StatefulWidget {
  @override
  _CreditPage createState() => _CreditPage();
}

class _CreditPage extends State<CreditScreen> {
  var controller = GlobalController();
  var loan = LoanOperation();
  var message = TextMessage();
  late Future<List<BorrowerModel>> _creditapproval;
  List<BorrowerModel> _borrowerFiltered = [];
  TextEditingController searchValue = TextEditingController();
  String _searchResult = '';

  int vid = 0, bid = 0;
  final double textSize = 15;
  final double titleSize = 30;
  final String denied = "DENIED",
      tobeRelease = 'TO-BE-RELEASE',
      approved = 'APPROVED';
  bool _sortAscending = true;

  @override
  void initState() {
    _creditapproval = controller.fetchCreditApprovals();
    _creditapproval
        .whenComplete(() => _borrowerFiltered = Mapping.creditApprovals);
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
                alignment: Alignment.topRight,
                child: Container(
                  padding: EdgeInsets.only(bottom: 10),
                  width: 300,
                  child: TextField(
                    controller: searchValue,
                    onChanged: (value) {
                      setState(() {
                        _searchResult = value;
                        _borrowerFiltered = Mapping.creditApprovals
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
                      contentPadding: EdgeInsets.only(left: 15),
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
              future: _creditapproval,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      semanticsLabel: 'Fetching credits',
                    ),
                  );
                }
                if (snapshot.hasData) {
                  if (snapshot.data!.length > 0) {
                    return GridView.count(
                      crossAxisCount: 5,
                      crossAxisSpacing: 40,
                      mainAxisSpacing: 40,
                      shrinkWrap: true,
                      childAspectRatio: (MediaQuery.of(context).size.width) /
                          (MediaQuery.of(context).size.height) / 2.5,
                      children: _cards(_borrowerFiltered),
                    );
                  } else {
                    return Center(
                      child: Text(
                        'NO CREDIT APPROVALS',
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
                      'NO CREDIT APPROVALS',
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

  List<Widget> _cards(List<BorrowerModel> brwCredit) {
    return List.generate(brwCredit.length, (index) {
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
                title: Text(
                  brwCredit[index].getStatus.toString(),
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Cairo_SemiBold',
                  ),
                ),
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
                        left: 10, top: 10, bottom: 10, right: 50),
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
                      brwCredit[index].toString(),
                      overflow: TextOverflow.visible,
                      maxLines: 2,
                      softWrap: true,
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
                        left: 10, top: 10, bottom: 10, right: 40),
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
                      brwCredit[index].getHomeAddress.toString(),
                      overflow: TextOverflow.visible,
                      softWrap: true,
                      maxLines: 3,
                      style:
                          TextStyle(fontFamily: 'Cairo_SemiBold', fontSize: 14),
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
                        left: 10, top: 10, bottom: 10, right: 40),
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
                      brwCredit[index].getMobileNumber.toString(),
                      overflow: TextOverflow.visible,
                      softWrap: true,
                      maxLines: 2,
                      style:
                          TextStyle(fontFamily: 'Cairo_SemiBold', fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: TextStyle(
                  fontSize: 10,
                  decoration: TextDecoration.underline,
                ),
              ),
              child: Text(
                'Show Application',
                style: TextStyle(
                  color: HexColor("#155293"),
                ),
              ),
              onPressed: () {},
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
                                left: 20, right: 20, top: 10, bottom: 10),
                            primary: Colors.white,
                            textStyle: TextStyle(
                                fontSize: 18, fontFamily: 'Cairo_SemiBold')),
                        child: const Text('APPROVE'),
                        onPressed: () {
                          vid = brwCredit[index].getinvestigationID;
                          bid = brwCredit[index].getBorrowerId;
                          loan
                              .approvedCredit(vid, bid, tobeRelease)
                              .then((value) {
                            if (!value) {
                              BannerNotif.notif(
                                'Error',
                                'Something went wrong while approving the loan',
                                Colors.red.shade600,
                              );
                            } else {
                              //refresh the data in the window
                              setState(() {
                                _creditapproval =
                                    controller.fetchCreditApprovals();
                                _creditapproval.whenComplete(() =>
                                    _borrowerFiltered =
                                        Mapping.creditApprovals);
                              });
                              //send message to the borrower that the credit has been approved
                              _creditapproval
                                  .whenComplete(() => sendMessageApproved(
                                        brwCredit[index].getMobileNumber,
                                        brwCredit[index].toString(),
                                        approved,
                                      ));
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.cancel),
                  color: Colors.redAccent.shade400,
                  tooltip: 'DENY CREDIT',
                  onPressed: () {
                    vid = brwCredit[index].getinvestigationID;
                    bid = brwCredit[index].getBorrowerId;
                    loan.approvedCredit(vid, bid, denied).then((value) {
                      if (!value) {
                        BannerNotif.notif(
                          'Error',
                          'Something went wrong while approving the loan',
                          Colors.red.shade600,
                        );
                      } else {
                        //refresh the data in the window
                        setState(() {
                          _creditapproval = controller.fetchCreditApprovals();
                          _creditapproval.whenComplete(() =>
                              _borrowerFiltered = Mapping.creditApprovals);
                        });
                        //send message to the borrower that the credit has been approved
                        _creditapproval.whenComplete(() => sendMessageApproved(
                              brwCredit[index].getMobileNumber,
                              brwCredit[index].toString(),
                              denied,
                            ));
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  void sendMessageApproved(String number, String name, String status) {
    message.sendApprovedCredit(name, number, status).then((value) => {
          if (value)
            {
              BannerNotif.notif(
                'PENDING',
                'The message is in transit to the network',
                Colors.orange.shade600,
              )
            }
        });
  }
}
