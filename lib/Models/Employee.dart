import 'Person.dart';

class Employee extends Person {
  String? role;
  String? username;
  String? password;
  String? userImage;
  String? get getRole => this.role;

  set setRole(String? role) => this.role = role;

  get getUsername => this.username;

  set setUsername(username) => this.username = username;

  get getPassword => this.password;

  set setPassword(password) => this.password = password;

  get getUserImage => this.userImage;

  set setUserImage(userImage) => this.userImage = userImage;

  Employee(
      String role,
      String username,
      String password,
      String userImage,
      int personId,
      String firstname,
      String lastname,
      String mobileNumber,
      String homeAddress)
      : super(personId, firstname, lastname, mobileNumber, homeAddress) {
    this.role = role;
    this.username = username;
    this.password = password;
    this.userImage = userImage;
  }

  Employee.withoutImage(
      String role,
      String username,
      String password,
      int personId,
      String firstname,
      String lastname,
      String mobileNumber,
      String homeAddress)
      : super(personId, firstname, lastname, mobileNumber, homeAddress) {
    this.role = role;
    this.username = username;
    this.password = password;
  }
}
