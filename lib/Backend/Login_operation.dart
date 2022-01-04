import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_store_management/Models/Employee_model.dart';
import '../Helpers/Hashing_helper.dart';
import 'GlobalController.dart';
import 'Interfaces/ILogin.dart';
import '../Models/Admin_model.dart';
import 'Utility/Mapping.dart';
import 'Session.dart';

class Login extends GlobalController implements ILogin {
  var hash = Hashing();
  var admin = AdminModel.empty();
  var session = Session();

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

    //loadAllList(response, role);

    return true;
  }

  Future<bool> _users(http.Response response, String role) async {
    try {
      switch (role.replaceAll(' ', '')) {
        case 'Administrator':
          Map<String, dynamic> adminMap =
              jsonDecode(response.body)[0] as Map<String, dynamic>;

          var admin = AdminModel.fromJson(adminMap);
          print(admin.toString());
          Mapping.adminList.add(
            AdminModel.full(
              admin.getAdminId,
              admin.getUsername,
              admin.getPassword,
              admin.getFirstname,
              admin.getLastname,
              admin.getMobileNumber,
              admin.getHomeAddress,
              admin.getUserImage,
            ),
          );

          //setSession(admin.toString(), true, role);

          break;
        case 'StoreAttendant':
          Map<String, dynamic> empMap =
              jsonDecode(response.body)[0] as Map<String, dynamic>;

          var emp = EmployeeModel.fromJson(empMap);
          Mapping.employeeList.add(emp);

          //setSession(emp.toString(), true, role);
          break;
        default:
      }
    } catch (e) {
      print('login');
      print(e.toString());
      return false;
    }

    return true;
  }

  void setSession(String id, bool status, String role) {
    session.setValues(id, status, role);
  }

  @override
  void logout() {
    session.removeValues(); //remove the values from the session
    //clear the lists
    Mapping.employeeList.clear();
    Mapping.productList.clear();
    Mapping.borrowerList.clear();
    Mapping.paymentList.clear();
  }
}
