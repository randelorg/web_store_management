import 'dart:typed_data';

import 'Person_model.dart';

class EmployeeModel extends PersonModel {
  String? employeeID;
  String? role;
  String? username;
  String? password;
  Uint8List? userImage;

  get getEmployeeID => this.employeeID;

  set setEmployeeID(employeeID) => this.employeeID = employeeID;

  get getRole => this.role;

  set setRole(role) => this.role = role;

  get getUsername => this.username;

  set setUsername(username) => this.username = username;

  get getPassword => this.password;

  set setPassword(password) => this.password = password;

  get getUserImage => this.userImage;

  set setUserImage(userImage) => this.userImage = userImage;

  EmployeeModel.empty() : super.empty();

  EmployeeModel.full(
      {this.employeeID,
      this.role,
      this.username,
      //this.password,
      //this.userImage,
      personId,
      firstname,
      lastname,
      mobileNumber,
      homeAddress})
      : super.full(personId, firstname, lastname, mobileNumber, homeAddress) {
    this.employeeID = employeeID;
    this.role = role;
    this.username = username;
    //this.password = password;
    //this.userImage = userImage;
  }

  EmployeeModel.withoutImage(
      String role,
      String username,
      String password,
      int personId,
      String firstname,
      String lastname,
      String mobileNumber,
      String homeAddress)
      : super.full(personId, firstname, lastname, mobileNumber, homeAddress) {
    this.role = role;
    this.username = username;
    this.password = password;
  }

  EmployeeModel.emplyeeOnly({
    this.employeeID,
    this.username,
    this.password,
  }) : super.empty() {
    this.employeeID = employeeID;
    this.username = username;
    this.password = password;
  }

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel.full(
      employeeID: json["EmployeeID"] as String,
      role: json["Role"] as String,
      username: json["Username"] as String,
      //userImage: json["UserImage"] as Uint8List,
      personId: json["PersonID"] as int,
      firstname: json["Firstname"] as String,
      lastname: json["Lastname"] as String,
      mobileNumber: json["MobileNumber"] as String,
      homeAddress: json["HomeAddress"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "EmployeeID": employeeID,
        "Role": role,
        "Username": username,
        "Password": password,
        "UserImage": userImage,
        "Firstname": firstname,
        "Lastname": lastname,
        "MobileNumber": mobileNumber,
        "HomeAddress": homeAddress,
      };
}
