import 'Person.dart';

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

  Admin(String username, String password, String userImage, String firstname,
      String lastname, String mobileNumber, String homeAddress)
      : super(firstname, lastname, mobileNumber, homeAddress) {
    this.username = username;
    this.password = password;
    this.userImage = userImage;
  }

  Admin.withoutImage(String username, String password, String firstname,
      String lastname, String mobileNumber, String homeAddress)
      : super(firstname, lastname, mobileNumber, homeAddress) {
    this.username = username;
    this.password = password;
  }

  Admin.adminOnly({
    this.adminId,
    this.username,
    this.password,
  }) : super.empty() {
    this.adminId = adminId;
    this.username = username;
    this.password = password;
  }

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin.adminOnly(
      adminId: json['AdminID'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
    );
  }
}
