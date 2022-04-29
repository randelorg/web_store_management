import 'PersonModel.dart';

class EmployeeModel extends PersonModel {
  String? employeeID;
  String? role;
  String? username;
  String? password;
  List<dynamic>? userImage;

  //for payroll
  int? attendanceID;
  String? clockIn;
  String? clockOut;

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

  get getAttendanceID => this.attendanceID;

  set setAttendanceID(attendanceID) => this.attendanceID = attendanceID;

  get getClockIn => this.clockIn;

  set setTimeIn(clockIn) => this.clockIn = clockIn;

  get getClockOut => this.clockOut;

  set setClockOut(clockOut) => this.clockOut = clockOut;

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
    this.firstname = firstname;
    this.lastname = lastname;
    this.mobileNumber = mobileNumber;
    this.homeAddress = homeAddress;
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
    this.personId = personId;
    this.firstname = firstname;
    this.lastname = lastname;
    this.mobileNumber = mobileNumber;
    this.homeAddress = homeAddress;
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
    this.firstname = firstname;
    this.lastname = lastname;
    this.mobileNumber = mobileNumber;
    this.homeAddress = homeAddress;
  }

  //for payroll
  EmployeeModel.attendance({this.attendanceID, this.clockIn, this.clockOut})
      : super.empty() {
    this.attendanceID = attendanceID;
    this.clockIn = clockIn;
    this.clockOut = clockOut;
  }

  factory EmployeeModel.attendanceJson(Map<String, dynamic> json) {
    return EmployeeModel.attendance(
      attendanceID: json['AttendanceID'] as int,
      clockIn: json['TimeIn'] as String,
      clockOut: json['TimeOut'] as String?,
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
}
