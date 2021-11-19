import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_store_management/Notification/Snack_notification.dart';
import '../Helpers/Hashing_helper.dart';
import 'GlobalController.dart';
import 'Interfaces/ILogin.dart';
import '../Models/Admin_model.dart';
import 'Utility/Mapping.dart';
import 'Session.dart';

class Login implements ILogin {
  var hash = Hashing();
  var admin = Admin.empty();
  var session = Session();
  var controller = GlobalController();

  @override
  Future<bool> mainLogin(String role, String username, String password) async {
    //holds the json body
    var entity;

    switch (role.replaceAll(' ', '')) {
      case 'Administrator':
        entity = json
            .encode({"Username": username, "Password": hash.encrypt(password)});
        break;
      case 'StoreAttendant':
        entity = json.encode({
          "Role": role.replaceAll(' ', ''),
          "Username": username.toString(),
          "Password": hash.encrypt(password)
        });
        break;
      default:
    }

    final response = await http.post(
      Uri.parse('http://localhost:8090/api/login'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: entity,
    );

    //if response is empty return false
    if (response.statusCode == 404) {
      return false;
    }

    try {
      //if response is not empty
      await _users(response, role);
    } catch (e) {
      print(e.toString());
    }

    loadAllList(response, role);

    return true;
  }

  Future<void> _users(http.Response response, String role) async {
    switch (role.replaceAll(' ', '')) {
      case 'Administrator':
        controller
            .parseAdmin(response.body)
            .then((value) => Mapping.adminList = value);
        print(Mapping.adminList.length);
        setSession(true);
        print(Mapping.adminList[0].getAdminId);
        break;
      case 'StoreAttendant':
        controller
            .parseEmployee(response.body)
            .then((value) => Mapping.employeeList = value);
        print(Mapping.employeeList.length);
        setSession(true);
        break;
      default:
    }
  }

  void setSession(bool id) {
    session.setValues2(true);
  }

  @override
  void logout() {
    session.removeValues(); //remove the values from the session
    //clear the list
    Mapping.adminList.clear();
    Mapping.employeeList.clear();
    Mapping.productList.clear();
    Mapping.borrowerList.clear();
  }

  Future<void> loadAllList(http.Response response, String role) async {
    try {
      //load employees if user is an admin
      if (role == 'Administrator') await controller.fetchAllEmployees();

      await controller.fetchProducts();
      await controller.fetchBorrowers();
    } catch (e) {
      SnackNotification.notif('Error', 'Cant fetch neccessary data');
    }
  }
}
