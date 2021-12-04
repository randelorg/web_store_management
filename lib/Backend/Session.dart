import 'package:shared_preferences/shared_preferences.dart';

class Session {
  void setValues(String id, bool isLog, String role) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('id', id);
      prefs.setBool('isLoggedin', isLog);
      prefs.setString('role', role);
    });
  }

  Future<bool> getvalues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedin')!;
  }

  Future<String> getid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('id').toString();
  }

  Future<String> getrole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('role').toString();
  }

  void removeValues() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove('id');
      prefs.remove('isLoggedin');
    });
  }
}
