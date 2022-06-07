class IBorrower {
  Future<bool> updateBorrower(int id, String firstname, String lastname,
      String mobile, String address) {
    var a;
    return a;
  }

  Future<bool> makePayment(int id, double payment, String date) {
    var a;
    return a;
  }

  Future<bool> addRequest(int borrowerid, String product, String date) {
    var a;
    return a;
  }

  Future<bool> addReturn(String status, String itemcode, String turnoverdate,
      String fullname, String mobile, String address) {
    var a;
    return a;
  }

  bool removeBorrower() {
    return false;
  }

  Future<bool> updateReturn(int id, final String status) {
    var a;
    return a;
  }

  Future<bool> updateRequest(int id, final String status) {
    var a;
    return a;
  }

  Future<List<int>> getContract(int id) {
    var a;
    return a;
  }
}
