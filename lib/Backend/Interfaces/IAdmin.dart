import 'dart:typed_data';

class IAdmin {
  Future<bool> createAdminAccount(
      String? firstname,
      String? lastname,
      String? mobileNumber,
      String? homeAddress,
      String? username,
      String? password,
      Uint8List? image) async {
    return false;
  }

  void deleteAdminAccount() {}
  void updateAdminAccount() {}
  bool verifyAdmin(String password) {
    return true;
  }
}
