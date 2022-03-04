import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:web_store_management/Backend/BorrowerOperation.dart';
import 'package:web_store_management/Backend/GlobalController.dart';
import 'package:web_store_management/Backend/TextMessage.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Notification/Snack_notification.dart';
import 'package:web_store_management/Pages/Repairs/ManualBorrowerSearch.dart';

class RepairsPage extends StatefulWidget {
  @override
  _RepairsPage createState() => _RepairsPage();
}

class _RepairsPage extends State<RepairsPage> {
  var controller = GlobalController();
  var borrower = BorrowerOperation();
  var message = TextMessage();
  late Future _repairs;
  double textSize = 15;
  double titleSize = 30;

  @override
  void initState() {
    super.initState();
    controller.fetchBorrowers();
    _repairs = controller.fetchRepairs();
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
                          icon:
                              Icon(Icons.add_box_rounded, color: Colors.white),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
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
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 15, bottom: 15, right: 20),
                  alignment: Alignment.topLeft,
                  width: 400,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search Repair',
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
        FutureBuilder(
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
                  'No credits to show',
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
      Mapping.repairs.length,
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
                        Mapping.repairs[index].getRepairProductName,
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
                        Mapping.repairs[index].toString(),
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
                        Mapping.repairs[index].getHomeAddress,
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
                        Mapping.repairs[index].getMobileNumber,
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
                            padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
                            primary: Colors.white,
                            textStyle: TextStyle(fontSize: 18, fontFamily: 'Cairo_SemiBold')
                          ),
                          child: const Text('REPAIR'),
                          onPressed: () {
                            repairStatus(
                              Mapping.repairs[index].getRepairId,
                              'REPAIR',
                              Mapping.repairs[index].getRepairProductName,
                              Mapping.repairs[index].toString(),
                              Mapping.repairs[index].getMobileNumber,
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
                        Mapping.repairs[index].getRepairId,
                        'UNREPAIRABLE',
                        Mapping.repairs[index].getRepairProductName,
                        Mapping.repairs[index].toString(),
                        Mapping.repairs[index].getMobileNumber,
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

  void sendRepairedMessage(String name, String number, String product) {
    message.sendRepairedProduct(name, number, product).then((value) => {
          if (value)
            {
              SnackNotification.notif(
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
        SnackNotification.notif(
          'Error',
          'Something went wrong while updating the repair',
          Colors.redAccent.shade200,
        );
      } else {
        //refresh the future and the widget
        setState(() {
          _repairs = controller.fetchRepairs();
        });
        //send message to the receiver
        sendRepairedMessage(name, number, product);
      }
    });
  }
}
