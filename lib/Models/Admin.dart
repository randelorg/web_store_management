import 'Person.dart';

class Admin extends Person {
  String? _adminId;
  String? _username;
  String? _password;
  String? _userImage;

  get getAdminId => this._adminId;

  set setAdminId(adminId) => this._adminId = adminId;

  get getUsername => this._username;

  set setUsername(username) => this._username = username;

  get getPassword => this._password;

  set setPassword(password) => this._password = password;

  get getUserImage => this._userImage;

  set setUserImage(userImage) => this._userImage = userImage;

  Admin.empty() : super.empty();

  Admin(String username, String password, String userImage, String firstname,
      String lastname, String mobileNumber, String homeAddress)
      : super(firstname, lastname, mobileNumber, homeAddress) {
    this._username = username;
    this._password = password;
    this._userImage = userImage;
  }

  Admin.withoutImage(String username, String password, String firstname,
      String lastname, String mobileNumber, String homeAddress)
      : super(firstname, lastname, mobileNumber, homeAddress) {
    this._username = username;
    this._password = password;
  }

  Admin.adminOnly(String adminId, String username, String password)
      : super.empty() {
    this._adminId = adminId;
    this._username = username;
    this._password = password;
  }
}
