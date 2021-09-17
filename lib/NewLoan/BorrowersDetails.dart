
import 'package:flutter/material.dart';

class BorrowerDetail extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: (MediaQuery.of(context).size.width) /3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 40),
                    child: Text(
                      "Input Borrower's Details",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    child: Image.asset(
                      '../../assets/images/qr-code-scan.png',
                      width: 150,
                      height: 150,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: TextButton.icon(
                      icon: Icon(
                        Icons.print,
                      ),
                      label: Text(
                        'Print QR',
                        softWrap: true,
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                        onPressed: () {}, //pwdeng refresh button
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Firstname',
                        filled: true,
                        fillColor: Colors.blueGrey[50],
                        labelStyle: TextStyle(fontSize: 12),
                        contentPadding: EdgeInsets.only(left: 30),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey.shade50),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey.shade50),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Lastname',
                        filled: true,
                        fillColor: Colors.blueGrey[50],
                        labelStyle: TextStyle(fontSize: 12),
                        contentPadding: EdgeInsets.only(left: 30),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey.shade50),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey.shade50),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Mobile number',
                        filled: true,
                        fillColor: Colors.blueGrey[50],
                        labelStyle: TextStyle(fontSize: 12),
                        contentPadding: EdgeInsets.only(left: 30),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey.shade50),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey.shade50),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Home address',
                        filled: true,
                        fillColor: Colors.blueGrey[50],
                        labelStyle: TextStyle(fontSize: 12),
                        contentPadding: EdgeInsets.only(left: 30),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey.shade50),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey.shade50),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  //buttons
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                            color: Colors.white,
                          ),
                        backgroundColor: Colors.blue.shade400,
                      ),
                      onPressed: () {},
                      child: const Text(
                          'UPLOAD \n CONTRACT',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                            color: Colors.white,
                          ),
                        backgroundColor: Colors.blue.shade400,
                      ),
                      onPressed: () {},
                      child: const Text(
                          'SAVE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                          ),
                        ),
                    ),
                  ),
                ],
              ),
          ),
        ],
      ),
    );
  }
} 