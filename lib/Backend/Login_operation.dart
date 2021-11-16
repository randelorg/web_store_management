import '../Helpers/Hashing_helper.dart';
import 'Interfaces/ILogin.dart';
import '../Models/Admin_model.dart';
import 'Utility/Mapping.dart';
import 'Session.dart';

class Login implements ILogin {
  var hash = Hashing();
  var admin = Admin.empty();
  var session = Session();

  @override
  String login(String username, String password) {
    for (var admin in Mapping.adminList) {
      if (username == admin.getUsername && password == admin.getPassword) {
        //set the session
        //after successful login
        session.setValues(admin.getAdminId, true);
        return "success";
      }
    }
    return "failed";
  }

  @override
  void logout() {
    session.removeValues(); //remove the values from the session
  }
}
