import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:printing/printing.dart';
import 'package:web_store_management/Backend/GlobalController.dart';
import 'package:web_store_management/Backend/LoanOperation.dart';
import 'package:web_store_management/Backend/TextMessage.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Helpers/PrintHelper.dart';
import 'package:web_store_management/Models/BorrowerModel.dart';
import 'package:web_store_management/Notification/BannerNotif.dart';

class ReleasePage extends StatefulWidget {
  @override
  _ReleasePage createState() => _ReleasePage();
}

class _ReleasePage extends State<ReleasePage> {
  var controller = GlobalController();
  var loan = LoanOperation();
  var message = TextMessage();
  final String released = "RELEASED";
  late Future<List<BorrowerModel>> _releaseApproval;

  int vid = 0, bid = 0;
  double textSize = 15;
  double titleSize = 30;

  @override
  void initState() {
    super.initState();
    _releaseApproval = controller.fetchReleaseApprovals();
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
                  'Release Product',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontFamily: 'Cairo_SemiBold',
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  //padding: EdgeInsets.only(top: 15, bottom: 15, right: 20),
                  width: 400,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search Borrower',
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
              ),
            ],
          ),
        ),
        FutureBuilder<List<BorrowerModel>>(
          future: _releaseApproval,
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
                      children: _cards(),
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    'NO BORROWERS TO RELEASE',
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
                  'NO BORROWERS TO RELEASE',
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

  List<Widget> _cards() {
    return List.generate(
      Mapping.releaseApproval.length,
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
                  title: Text(
                    Mapping.releaseApproval[index].getStatus.toString(),
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
                        Mapping.releaseApproval[index].toString(),
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
                        Mapping.releaseApproval[index].getHomeAddress
                            .toString(),
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
                        Mapping.releaseApproval[index].getMobileNumber
                            .toString(),
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
                          child: const Text('RELEASE'),
                          onPressed: () {
                            vid = Mapping
                                .releaseApproval[index].getinvestigationID;
                            bid = Mapping.releaseApproval[index].getBorrowerId;
                            loan
                                .approvedCredit(vid, bid, released)
                                .then((value) {
                              if (!value) {
                                BannerNotif.notif(
                                  'Error',
                                  'Something went wrong while approving the loan',
                                  Colors.redAccent.shade200,
                                );
                              } else {
                                //refresh the data in the window
                                setState(() {
                                  _releaseApproval =
                                      controller.fetchReleaseApprovals();
                                });

                                //show the print screen
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return showPrint(
                                      Mapping
                                          .releaseApproval[index].getBorrowerId
                                          .toString(),
                                      Mapping.releaseApproval[index].toString(),
                                    );
                                  },
                                );
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget showPrint(String id, String name) {
    return Container(
      child: PdfPreview(
        padding: EdgeInsets.all(100),
        build: (format) => PrintHelper.generatePdfQr(
          format,
          id,
          name,
        ),
      ),
    );
  }
}
