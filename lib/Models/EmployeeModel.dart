import 'PersonModel.dart';

class EmployeeModel extends PersonModel {
  String? employeeID;
  String? role;
  String? username;
  String? password;
  List<dynamic>? userImage;

  //for payroll
  String? payrollID;
  double? wage;
  double? salary;
  String? checkin;
  String? checkout;

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

  get getPayrollID => this.payrollID;

  set setPayrollID(payrollID) => this.payrollID = payrollID;

  get getWage => this.wage;

  set setWage(wage) => this.wage = wage;

  get getSalary => this.salary;

  set setSalary(salary) => this.salary = salary;

  get getCheckin => this.checkin;

  set setCheckin(checkin) => this.checkin = checkin;

  get getCheckout => this.checkout;

  set setCheckout(checkout) => this.checkout = checkout;

  EmployeeModel.empty() : super.empty();

  EmployeeModel.full(
    String employeeID,
    String role,
    String username,
    String firstname,
    String lastname,
    String mobileNumber,
    String homeAddress,
    List<dynamic> userImage,
  ) : super.withOutId(firstname, lastname, mobileNumber, homeAddress) {
    this.employeeID = employeeID;
    this.role = role;
    this.username = username;
    this.userImage = userImage;
  }

  EmployeeModel.fullJson({
    this.employeeID,
    this.role,
    this.username,
    personId,
    firstname,
    lastname,
    mobileNumber,
    homeAddress,
  }) : super.full(personId, firstname, lastname, mobileNumber, homeAddress) {
    this.employeeID = employeeID;
    this.role = role;
    this.username = username;
  }

  EmployeeModel.loginJson({
    this.employeeID,
    this.role,
    this.username,
    firstname,
    lastname,
    mobileNumber,
    homeAddress,
    this.userImage,
  }) : super.withOutId(firstname, lastname, mobileNumber, homeAddress) {
    this.employeeID = employeeID;
    this.role = role;
    this.username = username;
    this.userImage = userImage;
  }

  //for payroll
  EmployeeModel.payroll({this.payrollID, this.checkin, this.checkout})
      : super.empty();

  factory EmployeeModel.payrollJson(Map<String, dynamic> json) {
    return EmployeeModel.payroll(
      payrollID: json['payrollID'] as String,
      checkin: json['checkin'] as String,
      checkout: json['checkout'] as String,
    );
  }

  factory EmployeeModel.fromloginJson(Map<String, dynamic> json) {
    return EmployeeModel.loginJson(
      employeeID: json["EmployeeID"] as String,
      role: json["Role"] as String,
      username: json["Username"] as String,
      firstname: json["Firstname"] as String,
      lastname: json["Lastname"] as String,
      mobileNumber: json["MobileNumber"] as String,
      homeAddress: json["HomeAddress"] as String,
      userImage: json["UserImage"]["data"] as List<dynamic>,
    );
  }

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel.fullJson(
      employeeID: json["EmployeeID"] as String,
      role: json["Role"] as String,
      username: json["Username"] as String,
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
