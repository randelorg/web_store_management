import 'PersonModel.dart';

class AdminModel extends PersonModel {
  String? adminId;
  String? username;
  String? password;
  List<dynamic>? userImage;
  //List<int> bufferInt = userImage.map((e) => e as int).toList();

  get getAdminId => this.adminId;

  set setAdminId(adminId) => this.adminId = adminId;

  get getUsername => this.username;

  set setUsername(username) => this.username = username;

  get getPassword => this.password;

  set setPassword(password) => this.password = password;

  get getUserImage => this.userImage;

  set setUserImage(userImage) => this.userImage = userImage;

  AdminModel.empty() : super.empty();

  AdminModel.full(
      String adminId,
      String username,
      String password,
      String firstname,
      String lastname,
      String mobileNumber,
      String homeAddress,
      List<dynamic> userImage)
      : super.partial(firstname, lastname, mobileNumber, homeAddress) {
    this.adminId = adminId;
    this.username = username;
    this.password = password;
    this.userImage = userImage;
  }

  AdminModel.fullJson(
      {this.adminId,
      this.username,
      this.password,
      personId,
      firstname,
      lastname,
      mobileNumber,
      homeAddress,
      this.userImage})
      : super.full(personId, firstname, lastname, mobileNumber, homeAddress) {
    this.username = username;
    this.password = password;
    this.userImage = userImage;
  }

  AdminModel.adminOnlyJson({
    this.adminId,
    this.username,
    this.password,
  }) : super.empty() {
    this.adminId = adminId;
    this.username = username;
    this.password = password;
  }

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel.fullJson(
      adminId: json["AdminID"] as String,
      username: json["Username"] as String,
      password: json["Password"] as String,
      personId: json["PersonID"] as int,
      firstname: json["Firstname"] as String,
      lastname: json["Lastname"] as String,
      mobileNumber: json["MobileNumber"] as String,
      homeAddress: json["HomeAddress"] as String,
      userImage: json["UserImage"]["data"] as List<dynamic>,
    );
  }
}
