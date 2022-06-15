import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Backend/HistoryOperation.dart';
import 'package:timelines/timelines.dart';
import 'package:web_store_management/Models/ProductTranferHistoryModel.dart';

class TransferHistory extends StatefulWidget {
  final String? branchCode, branchName;
  TransferHistory({required this.branchCode, required this.branchName});

  @override
  _TransferHistory createState() => _TransferHistory();
}

class _TransferHistory extends State<TransferHistory> {
  var history = HistoryOperation();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width),
      height: (MediaQuery.of(context).size.height),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Text(
              'Transfer History of ${widget.branchName}',
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: HexColor("#155293"),
                fontFamily: 'Cairo_Bold',
                fontSize: 25,
              ),
            ),
          ),
          FutureBuilder<List<ProductTransferHistoryModel>>(
            future: history.productTransferHistory(
              widget.branchCode.toString(),
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    semanticsLabel: 'Fetching history',
                  ),
                );
              }
              if (snapshot.hasData) {
                if (snapshot.data!.isNotEmpty) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Timeline.tileBuilder(
                    theme: TimelineThemeData(
                      color: Colors.amber,
                    ),
                      builder: TimelineTileBuilder.fromStyle(
                        contentsAlign: ContentsAlign.alternating,
                        contentsBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            children: [
                              Text(
                                'Date Transferred: ${snapshot.data![index].getDateTransferred}',
                                style: TextStyle(
                                  fontFamily: 'Cairo_SemiBold',
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                'Product Name: ${snapshot.data![index].getProductName}',
                                style: TextStyle(
                                  fontFamily: 'Cairo_semiBold',
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                'Quantity: ${snapshot.data![index].getQty}',
                                style: TextStyle(
                                  fontFamily: 'Cairo_SemiBold',
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        itemCount: snapshot.data!.length,
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      'NO TRANSFER HISTORY',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontFamily: 'Cairo_SemiBold',
                        fontSize: 20,
                      ),
                    ),
                  );
                }
              }
              return Center(
                child: Text(
                  'NO TRANSFER HISTORY FOR THIS BRANCH',
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontFamily: 'Cairo_SemiBold',
                      fontSize: 20),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
