import 'Person_model.dart';

class Employee extends Person {
  String? employeeID;
  String? role;
  String? username;
  String? password;
  String? userImage;

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

  Employee.empty() : super.empty();

  Employee.full(
      {this.employeeID,
      this.username,
      this.password,
      this.userImage,
      personId,
      firstname,
      lastname,
      mobileNumber,
      homeAddress})
      : super.full(personId, firstname, lastname, mobileNumber, homeAddress) {
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
      : super.full(personId, firstname, lastname, mobileNumber, homeAddress) {
    this.role = role;
    this.username = username;
    this.password = password;
  }

  Employee.emplyeeOnly({
    this.employeeID,
    this.username,
    this.password,
  }) : super.empty() {
    this.employeeID = employeeID;
    this.username = username;
    this.password = password;
  }

  factory Employee.fromJsonEmployee(Map<String, dynamic> json) {
    return Employee.emplyeeOnly(
      employeeID: json["EmployeeID"] as String,
      username: json["username"] as String,
      password: json["password"] as String,
    );
  }

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee.full(
      employeeID: json["EmployeeID"] as String,
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
