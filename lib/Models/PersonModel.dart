class PersonModel {
  int? personId;
  String? firstname;
  String? lastname;
  String? mobileNumber;
  String? homeAddress;

  get getFirstname => this.firstname;

  set setFirstname(firstname) => this.firstname = firstname;

  get getLastname => this.lastname;

  set setLastname(lastname) => this.lastname = lastname;

  get getMobileNumber => this.mobileNumber;

  set setMobileNumber(mobileNumber) => this.mobileNumber = mobileNumber;

  get getHomeAddress => this.homeAddress;

  set setHomeAddress(homeAddress) => this.homeAddress = homeAddress;

  @override
  String toString() {
    return getFirstname + " " + getLastname;
  }

  PersonModel.empty();

  PersonModel.partial(String firstname, String lastname, String mobileNumber,
      String homeAddress) {
    this.firstname = firstname;
    this.lastname = lastname;
    this.mobileNumber = mobileNumber;
    this.homeAddress = homeAddress;
  }

  PersonModel.full(int persondId, String firstname, String lastname,
      String mobileNumber, String homeAddress) {
    this.personId = personId;
    this.firstname = firstname;
    this.lastname = lastname;
    this.mobileNumber = mobileNumber;
    this.homeAddress = homeAddress;
  }

  PersonModel.withOutId(String firstname, String lastname, String mobileNumber,
      String homeAddress) {
    this.firstname = firstname;
    this.lastname = lastname;
    this.mobileNumber = mobileNumber;
    this.homeAddress = homeAddress;
  }
}
