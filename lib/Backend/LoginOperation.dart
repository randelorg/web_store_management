import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_store_management/Models/EmployeeModel.dart';
import 'package:web_store_management/Models/AdminModel.dart';
import 'package:web_store_management/environment/Environment.dart';
import '../Helpers/HashingHelper.dart';
import 'GlobalController.dart';
import 'Interfaces/ILogin.dart';
import 'Utility/Mapping.dart';
import 'Session.dart';

class Login extends GlobalController implements ILogin {
  //var auth = Auth();
  var hash = Hashing();
  var admin = AdminModel.empty();
  var session = Session();

  @override
  Future<bool> mainLogin(
      String branch, String role, String username, String password) async {
    //holds the json body
    var entity, response;
    switch (role.replaceAll(' ', '')) {
      case 'Manager':
        entity = json.encode({
          "Username": username,
          "Password": hash.encrypt(password.trim()),
        });
        break;
      case 'StoreAttendant':
        entity = json.encode({
          "Role": role.replaceAll(' ', ''),
          "Username": username.toString(),
          "Password": hash.encrypt(password.trim())
        });
        break;
      default:
    }

    await Environment.methodPost("http://localhost:8090/api/login", entity)
        .then((value) {
      response = value;
    });

    try {
      //if response is not empty
      bool status = await _users(response, role, branch);

      if (!status) return false;
    } catch (e) {
      print(e.toString());
    }

    return true;
  }

  Future<bool> _users(
      http.Response response, final String role, String branch) async {
    //for identifying the user role
    Mapping.userRole = role;

    try {
      switch (role.replaceAll(' ', '')) {
        case 'Manager':
          Map<String, dynamic> adminMap =
              jsonDecode(response.body)[0] as Map<String, dynamic>;

          var admin = AdminModel.fromJson(adminMap);

          Mapping.adminLogin.add(
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

          await _setSession(admin.toString(), true, role, branch);

          break;
        case 'StoreAttendant':
          Map<String, dynamic> empMap =
              jsonDecode(response.body)[0] as Map<String, dynamic>;

          var emp = EmployeeModel.fromloginJson(empMap);

          Mapping.employeeLogin.add(EmployeeModel.full(
            emp.getEmployeeID,
            emp.getRole,
            emp.getUsername,
            emp.getFirstname,
            emp.getLastname,
            emp.getMobileNumber,
            emp.getHomeAddress,
            emp.getUserImage,
          ));

          await _setSession(emp.toString(), true, role, branch);
          break;
        default:
      }
    } catch (e) {
      print(e.toString());
      return false;
    }

    return true;
  }

  Future<void> _setSession(
      String id, bool status, String role, String branch) async {
    await Session.setValues(id, status, role, branch);
  }

  @override
  Future<bool> logout() async {
    //clear the lists
    Mapping.employeeList.clear();
    Mapping.adminLogin.clear();
    Mapping.productList.clear();
    Mapping.borrowerList.clear();
    Mapping.paymentList.clear();

    //remove the values from the session
    await Session.removeValues();

    return true;
  }
}
