import 'package:flutter/material.dart';
import 'package:web_store_management/Backend/GlobalController.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';

class CreditScreen extends StatefulWidget {
  @override
  _CreditPage createState() => _CreditPage();
}

class _CreditPage extends State<CreditScreen> {
  var controller = GlobalController();

  double textSize = 15;
  double titleSize = 30;
  late Future _creditapproval;

  @override
  void initState() {
    super.initState();
    _creditapproval = controller.fetchCreditApprovals();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 10, right: 20),
              width: 400,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search borrower',
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
        FutureBuilder(
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
            }
            return Center(
              child: Text('No data for credit approval availble'),
            );
          },
        ),
      ],
    );
  }

  List<Widget> _cards() {
    return List.generate(
      Mapping.creditApprovals.length,
      (index) {
        return new Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35.0),
          ),
          shadowColor: Colors.black,
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(
                    'PENDING',
                    style: TextStyle(fontSize: 30),
                  ),
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
                          left: 30, right: 10, top: 10, bottom: 10),
                      child: Text(
                        'Name',
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        Mapping.creditApprovals[index].toString(),
                        overflow: TextOverflow.visible,
                        maxLines: 2,
                        softWrap: true,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
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
                          left: 30, right: 10, top: 10, bottom: 10),
                      child: Text(
                        'Address',
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        Mapping.creditApprovals[index].getHomeAddress
                            .toString(),
                        overflow: TextOverflow.visible,
                        softWrap: true,
                        maxLines: 3,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
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
                          left: 30, right: 10, top: 10, bottom: 10),
                      child: Text(
                        'Number',
                        softWrap: true,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        Mapping.creditApprovals[index].getMobileNumber
                            .toString(),
                        overflow: TextOverflow.visible,
                        softWrap: true,
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                child: const Text('Show application'),
                style: TextButton.styleFrom(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onPressed: () {},
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
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
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            primary: Colors.white,
                            textStyle: TextStyle(fontSize: 20),
                          ),
                          child: const Text('APPROVE'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.cancel),
                    color: Colors.redAccent.shade400,
                    tooltip: 'DENY CREDIT',
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
