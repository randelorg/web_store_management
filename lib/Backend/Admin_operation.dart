import 'dart:typed_data';
import 'Interfaces/IAdmin.dart';
import 'Utility/Mapping.dart';
import '../Helpers/Hashing_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminOperation implements IAdmin {
  final hash = Hashing();

  @override
  Future<bool> createAdminAccount(
      String? firstname,
      String? lastname,
      String? mobileNumber,
      String? homeAddress,
      String? username,
      String? password,
      Uint8List? image) async {
    //json body
    var id = 'admin_009';
    var addAdmin = json.encode({
      'AdminID': id,
      'Username': username,
      'Password': password,
      'Firstname': firstname,
      'Lastname': lastname,
      'MobileNumber': mobileNumber,
      'HomeAddress': homeAddress,
      'UserImage': image
    });

    try {
      final response = await http.post(
        Uri.parse("http://localhost:8090/api/admin"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: addAdmin,
      );

      if (response.statusCode == 404) return false;
    } catch (e) {
      e.toString();
    }

    //if status code is 202
    return true;
  }

  @override
  void deleteAdminAccount() {
    // TODO: implement deleteAdminAccount
  }

  @override
  void updateAdminAccount() {
    // TODO: implement updateAdminAccount
  }

  @override
  bool verifyAdmin(String password) {
    print(Mapping.adminList[0].getPassword.toString());
    if (Mapping.adminList[0].getPassword.toString() == hash.encrypt(password))
      return true;

    return false;
  }
}
