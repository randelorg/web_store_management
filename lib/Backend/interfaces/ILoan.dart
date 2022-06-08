import 'dart:typed_data';

class INewLoan {
  Future<bool> addBorrower(
      String barcode,
      String firstname,
      String lastname,
      String mobile,
      String homeaddress,
      num balance,
      Uint8List contract,
      String plan,
      String term,
      String duedate) {
    var a;
    return a;
  }

  Future<bool> addInvestigation(String firstname, String lastname) {
    var a;
    return a;
  }

  //this will add new loan to the Loan table
  //and this will add credit investigation to the CreditInvestigation table
  Future<bool> addNewLoan(
    String barcode,
    String firstname,
    String lastname,
    String term,
    String duration,
    String duedate,
  ) {
    var a;
    return a;
  }

  Future<bool> approvedCredit(int investigationId, int borrowerId,
      String status, String? invoiceNumber) {
    var a;
    return a;
  }

  Future<bool> updateBalanceAndContract(
      String barcode,
      num balance,
      int id,
      String firstname,
      String lastname,
      plan,
      term,
      dueDate,
      Uint8List contract) async {
    return true;
  }
}
