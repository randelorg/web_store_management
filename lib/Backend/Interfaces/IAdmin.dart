import 'dart:typed_data';

class IAdmin {
  Future<void> createAdminAccount(
      String? firstname,
      String? lastname,
      String? mobileNumber,
      String? homeAddress,
      String? username,
      String? password,
      Uint8List? image) async {
    //return false;
  }

  void deleteAdminAccount() {}

  Future<bool> updateAdminAccount(
      final String id, final String username, final String password) {
    var a;
    return a;
  }

  bool verifyAdmin(String password) {
    return true;
  }
}
