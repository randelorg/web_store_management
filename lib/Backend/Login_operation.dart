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
      bool status = await _users(response, role);

      if (!status) return false;
    } catch (e) {
      print(e.toString());
    }

    loadAllList(response, role);

    return true;
  }

  Future<bool> _users(http.Response response, String role) async {
    try {
      switch (role.replaceAll(' ', '')) {
        case 'Administrator':
          await controller
              .parseAdmin(response.body)
              .then((value) => Mapping.adminList = value);
          setSession(Mapping.adminList[0].getAdminId.toString(), true);
          print('ID ' + Mapping.adminList[0].getAdminId);
          break;
        case 'StoreAttendant':
          await controller
              .parseEmployee(response.body)
              .then((value) => Mapping.employeeList = value);
          setSession(Mapping.employeeList[0].getEmployeeID.toString(), true);
          break;
        default:
      }
    } catch (e) {
      return false;
    }

    return true;
  }

  void setSession(String id, bool status) {
    session.setValues(id, status);
    print('id ' + id);
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
