class Person {
  int? personId;
  String? firstname;
  String? lastname;
  String? mobileNumber;
  String? homeAddress;

  get getFirstname => this.firstname;

  set setFirstname(String? firstname) => this.firstname = firstname;

  get getLastname => this.lastname;

  set setLastname(lastname) => this.lastname = lastname;

  get getMobileNumber => this.mobileNumber;

  set setMobileNumber(mobileNumber) => this.mobileNumber = mobileNumber;

  get getHomeAddress => this.homeAddress;

  set setHomeAddress(homeAddress) => this.homeAddress = homeAddress;

  Person.empty();

  Person.full(int persondId, String firstname, String lastname,
      String mobileNumber, String homeAddress) {
    this.personId = personId;
    this.firstname = firstname;
    this.lastname = lastname;
    this.mobileNumber = mobileNumber;
    this.homeAddress = homeAddress;
  }

  Person.withOutId(String firstname, String lastname, String mobileNumber,
      String homeAddress) {
    this.firstname = firstname;
    this.lastname = lastname;
    this.mobileNumber = mobileNumber;
    this.homeAddress = homeAddress;
  }
}