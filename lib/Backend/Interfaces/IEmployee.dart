import 'dart:typed_data';

class IEmployee {
  Future<bool> createEmployeeAccount(
      String? role,
      String? firstname,
      String? lastname,
      String? mobileNumber,
      String? homeAddress,
      String? username,
      String? password,
      Uint8List? image) async {
    return false;
  }

  void deleteEmployeeAccount() {}

  Future<bool> updateEmployeeAccount(
      int pid, String eid, String role, String mobile, String address) {
    var a;
    return a;
  }
}
