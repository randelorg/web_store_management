import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';
import 'package:printing/printing.dart';
import 'package:web_store_management/Backend/GlobalController.dart';
import 'package:web_store_management/Backend/LoanOperation.dart';
import 'package:web_store_management/Backend/TextMessage.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Helpers/PrintHelper.dart';
import 'package:web_store_management/Models/BorrowerModel.dart';
import 'package:web_store_management/Models/ProductModel.dart';
import 'package:web_store_management/Pages/LoanRelated/Release/ReleaseItems.dart';

class ReleasePage extends StatefulWidget {
  @override
  _ReleasePage createState() => _ReleasePage();

  final String released = "RELEASED";
  final String toBeRelease = 'TO-BE-RELEASE';
  final List<String> filter = ["RELEASED", "TO-BE-RELEASE"];
}

class _ReleasePage extends State<ReleasePage> {
  late Future<List<BorrowerModel>> _releaseApproval;
  late Future<List<ProductModel>> _products;
  List<String> filteredStatus = [];
  List<BorrowerModel> _borrowerFiltered = [];

  var controller = GlobalController();
  var loan = LoanOperation();
  var message = TextMessage();

  TextEditingController searchValue = TextEditingController();

  String _searchResult = '';

  @override
  void initState() {
    _releaseApproval = controller.fetchReleaseApprovals(widget.toBeRelease);
    _products = controller.fetchProducts();
    //_releaseApproval = controller.fetchBorrowers();
    _releaseApproval
        .whenComplete(() => _borrowerFiltered = Mapping.releaseApproval);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 20, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Wrap(
                children: productTypeWidget().toList(),
              ),
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
                        _borrowerFiltered = Mapping.releaseApproval
                            .where((brw) => brw
                                .toString()
                                .toLowerCase()
                                .contains(_searchResult.toLowerCase()))
                            .toList();
                      });
                    },
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search_rounded),
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
              future: _releaseApproval,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      semanticsLabel: 'Fetching items',
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
                        'NO ITEM IS AVAILABLEs',
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
          ),
        ),
      ],
    );
  }

  Iterable<Widget> productTypeWidget() {
    return widget.filter.map((status) {
      return Padding(
        padding: const EdgeInsets.only(right: 15),
        child: ChoiceChip(
          label: Text(status),
          selected: filteredStatus.contains(status),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                filteredStatus.add(status);
                _releaseApproval = controller.fetchReleaseApprovals(status);
                _releaseApproval.whenComplete(
                    () => _borrowerFiltered = Mapping.releaseApproval);
              } else {
                filteredStatus.removeWhere((name) {
                  _borrowerFiltered = Mapping.releaseApproval;
                  return name == status;
                });
              }
            });
          },
        ),
      );
    });
  }

  List<Widget> _cards(List<BorrowerModel> brwRelease) {
    return List.generate(
      brwRelease.length,
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
                  title: Text(
                    brwRelease[index].getStatus.toString(),
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
                        brwRelease[index].toString(),
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
                        brwRelease[index].getHomeAddress.toString(),
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
                        brwRelease[index].getMobileNumber.toString(),
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
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        child: PdfPreview(
                          padding: EdgeInsets.all(100),
                          build: (format) => PrintHelper.generatePdfContract(
                            brwRelease[index].getBorrowerId.toString(),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              Visibility(
                visible: brwRelease[index].getStatus == widget.toBeRelease,
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
                                    fontSize: 18,
                                    fontFamily: 'Cairo_SemiBold')),
                            child: const Text('RELEASE'),
                            onPressed: () {
                              showModalSideSheet(
                                context: context,
                                width: MediaQuery.of(context).size.width / 2.3,
                                body: ListView(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(30.0),
                                      child: ReleaseItems(
                                        loaniId: brwRelease[index].getLoanId,
                                        name: brwRelease[index].toString(),
                                        address:
                                            brwRelease[index].getHomeAddress,
                                        barcode:
                                            brwRelease[index].getProductCode,
                                        borrowerId: brwRelease[index]
                                            .getBorrowerId
                                            .toString(),
                                        investigationId: brwRelease[index]
                                            .getinvestigationID
                                            .toString(),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
