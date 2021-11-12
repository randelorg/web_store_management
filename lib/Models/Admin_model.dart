import 'Person_model.dart';

class Admin extends Person {
  String? adminId;
  String? username;
  String? password;
  String? userImage;

  get getAdminId => this.adminId;

  set setAdminId(adminId) => this.adminId = adminId;

  get getUsername => this.username;

  set setUsername(username) => this.username = username;

  get getPassword => this.password;

  set setPassword(password) => this.password = password;

  get getUserImage => this.userImage;

  set setUserImage(userImage) => this.userImage = userImage;

  Admin.empty() : super.empty();

  Admin.full(
      {this.adminId,
      this.username,
      this.password,
      this.userImage,
      personId,
      firstname,
      lastname,
      mobileNumber,
      homeAddress})
      : super(personId, firstname, lastname, mobileNumber, homeAddress) {
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
      : super(personId, firstname, lastname, mobileNumber, homeAddress);

  Admin.adminOnly({
    this.adminId,
    this.username,
    this.password,
  }) : super.empty() {
    this.adminId = adminId;
    this.username = username;
    this.password = password;
  }

  factory Admin.fromJsonAdmin(Map<String, dynamic> json) {
    return Admin.adminOnly(
      adminId: json["AdminID"] as String,
      username: json["username"] as String,
      password: json["password"] as String,
    );
  }

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin.full(
      adminId: json["AdminID"] as String,
      username: json["username"] as String,
      password: json["password"] as String,
      userImage: json["userImage"] as String,
      personId: json["PersonID"] as int,
      firstname: json["Firstname"] as String,
      lastname: json["Lastname"] as String,
      mobileNumber: json["MobileNumber"] as String,
      homeAddress: json["HomeAddress"] as String,
    );
  }
}
