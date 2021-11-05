import 'Person.dart';

class Admin extends Person {
  String? username;
  String? password;
  String? userImage;

  get getUsername => this.username;

  set setUsername(username) => this.username = username;

  get getPassword => this.password;

  set setPassword(password) => this.password = password;

  get getUserImage => this.userImage;

  set setUserImage(userImage) => this.userImage = userImage;

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

  //Admin.epmty() : super();
}
