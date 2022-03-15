class ForgetPasswordModel {
  int? personID;
  String? adminID;
  String? mobilenumber;
  String? firstname;
  String? lastname;

  get getPersonID => this.personID;

  set setPersonID(int? personID) => this.personID = personID;

  get getAdminID => this.adminID;

  set setAdminID(adminID) => this.adminID = adminID;

  get getMobilenumber => this.mobilenumber;

  set setMobilenumber(mobilenumber) => this.mobilenumber = mobilenumber;

  get getFirstname => this.firstname;

  set setFirstname(firstname) => this.firstname = firstname;

  get getLastname => this.lastname;

  set setLastname(lastname) => this.lastname = lastname;

  @override
  String toString() {
    return getFirstname + " " + getLastname;
  }

  ForgetPasswordModel(
    int personID,
    String adminID,
    String mobilenumber,
    String firstname,
    String lastname,
  ) {
    this.personID = personID;
    this.adminID = adminID;
    this.mobilenumber = mobilenumber;
    this.firstname = firstname;
    this.lastname = lastname;
  }

  ForgetPasswordModel.full(
      {this.personID,
      this.adminID,
      this.mobilenumber,
      this.firstname,
      this.lastname});

  factory ForgetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordModel.full(
      personID: json["PersonID"] as int,
      adminID: json["AdminID"] as String,
      mobilenumber: json["MobileNumber"] as String,
      firstname: json["FirstName"] as String,
      lastname: json["LastName"] as String,
    );
  }
}
