import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart'; //library for going to next pages

import '../DashBoard/DashBoard.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MediaQuery.of(context).size.width >= 800 //Responsive
             ? Image.asset(
                'images/login-logo.jpg',
                 width: 350,
               )
            : SizedBox(),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 40),
          child: Container(
            width: 300,
            child: _formLogin(),
          ),
        )
      ],
    );
  }
}

Widget _formLogin() {
    return Column(
      children: [
        // Text(
        //   'Welcome to Store Management System \n',
        //   textAlign: TextAlign.center,
        //   style: TextStyle(
        //     fontSize: 30,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        // SizedBox(
        //   height: 30,
        // ),
        TextField(
          decoration: InputDecoration(
            hintText: 'Username',
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
        SizedBox(height: 30),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Password',
            counterText: 'Forgot password?',
            suffixIcon: InkWell(
              child: Icon( 
                      Icons.visibility,
                      color: Colors.grey,
                ),
            ),
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
        SizedBox(height: 40),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.shade100,
                spreadRadius: 10,
                blurRadius: 20,
              ),
            ],
          ),
          child: ElevatedButton(
            child: Container(
                width: double.infinity,
                height: 50,
                child: Center(child: Text("Sign In"))),
            onPressed: () {
              Get.to(DashBoard());
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.redAccent.shade200,
              onPrimary: Colors.white,
            ),
          ),
        ),
      ],
    );
}