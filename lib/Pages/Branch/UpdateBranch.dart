import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../Backend/BranchOperation.dart';
import '../../Notification/BannerNotif.dart';

class UpdateBranch extends StatefulWidget {
  final String? branchCode, branchName, branchAddress;
  UpdateBranch({required this.branchCode, this.branchName, this.branchAddress});

  @override
  _UpdateBranch createState() => _UpdateBranch();
}

class _UpdateBranch extends State<UpdateBranch> {
  var branch = BranchOperation();
  final branchName = TextEditingController();
  final branchAddress = TextEditingController();

  @override
  void initState() {
    super.initState();
    branchName.text = widget.branchName.toString();
    branchAddress.text = widget.branchAddress.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 300),
                child: Text(
                  'Update Branch',
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: HexColor("#155293"),
                    fontFamily: 'Cairo_Bold',
                    fontSize: 25,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15, left: 2),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Branch Name',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: TextField(
                  controller: branchName,
                  decoration: InputDecoration(
                    hintText: 'Branch Name',
                    filled: true,
                    fillColor: Colors.blueGrey[50],
                    labelStyle: TextStyle(fontSize: 12),
                    contentPadding: EdgeInsets.only(left: 15),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade50),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade50),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 2),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Branch Address',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: TextField(
                  controller: branchAddress,
                  decoration: InputDecoration(
                    hintText: 'Branch Address',
                    filled: true,
                    fillColor: Colors.blueGrey[50],
                    labelStyle: TextStyle(fontSize: 12),
                    contentPadding: EdgeInsets.only(left: 15),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade50),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade50),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
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
                                    left: 20, right: 20, top: 15, bottom: 15),
                                primary: Colors.white,
                                textStyle: TextStyle(
                                    fontFamily: 'Cairo_SemiBold',
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                              child: const Text('UPDATE'),
                              onPressed: () {
                                if (branchName.text.isEmpty ||
                                    branchAddress.text.isEmpty) {
                                  BannerNotif.notif(
                                      "Error",
                                      "Please fill all the fields",
                                      Colors.red.shade600);
                                } else {
                                  branch
                                      .updateBranch(
                                          widget.branchCode.toString(),
                                          branchName.text,
                                          branchAddress.text)
                                      .then((value) {
                                    if (value) {
                                      Navigator.pop(context);
                                      BannerNotif.notif(
                                        'Success',
                                        "Branch" +
                                            branchName.text +
                                            " is updated",
                                        Colors.green.shade600,
                                      );
                                    }
                                  });
                                }
                              }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
