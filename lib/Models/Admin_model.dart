import 'dart:typed_data';
import 'Person_model.dart';

class Admin extends Person {
  String? adminId;
  String? username;
  String? password;
  Uint8List? userImage;

  get getAdminId => this.adminId;

  set setAdminId(adminId) => this.adminId = adminId;

  get getUsername => this.username;

  set setUsername(username) => this.username = username;

  get getPassword => this.password;

  set setPassword(password) => this.password = password;

  get getUserImage => this.userImage;

  set setUserImage(userImage) => this.userImage = userImage;

  Admin.empty() : super.empty();

  Admin.fullJson(
      {this.adminId,
      this.username,
      this.password,
      personId,
      firstname,
      lastname,
      mobileNumber,
      homeAddress})
      : super.full(personId, firstname, lastname, mobileNumber, homeAddress) {
    this.username = username;
    this.password = password;
  }

  Admin.withOutId(
    firstname,
    lastname,
    mobileNumber,
    homeAddress,
    this.username,
    this.password,
    this.userImage,
  ) : super.withOutId(firstname, lastname, mobileNumber, homeAddress) {
    this.username = username;
    this.password = password;
    this.userImage = userImage;
  }

  Admin.withoutImage(
      String username,
      String password,
      personId,
      String firstname,
      String lastname,
      String mobileNumber,
      String homeAddress)
      : super.full(personId, firstname, lastname, mobileNumber, homeAddress);

  Admin.adminOnlyJson({
    this.adminId,
    this.username,
    this.password,
  }) : super.empty() {
    this.adminId = adminId;
    this.username = username;
    this.password = password;
  }

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin.fullJson(
      adminId: json["AdminID"] as String,
      username: json["Username"] as String,
      password: json["Password"] as String,
      personId: json["PersonID"] as int,
      firstname: json["Firstname"] as String,
      lastname: json["Lastname"] as String,
      mobileNumber: json["MobileNumber"] as String,
      homeAddress: json["HomeAddress"] as String,
    );
  }

  Map<String, dynamic> toJsonFull() => {
        "AdminID": adminId,
        "Username": username,
        "Password": password,
        "Firstname": firstname,
        "Lastname": lastname,
        "MobileNumber": mobileNumber,
        "HomeAddress": homeAddress,
        //"UserImage": userImage,
      };
}
