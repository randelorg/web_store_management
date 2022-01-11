class INewLoan {
  //this will add new loan to the Loan table
  //and this will add credit investigation to the CreditInvestigation table
  Future<bool> addNewLoan(
    String firstname,
    String lastname,
    String term,
    String duration,
    String duedate,
  ) {
    var a;
    return a;
  }

  Future<bool> addBorrower(String firstname, String lastname, String mobile,
      String homeaddress, num balance) {
    var a;
    return a;
  }

  Future<bool> approvedCredit(int investigationId, int borrowerId, String status) {
    var a;
    return a;
  }
}
