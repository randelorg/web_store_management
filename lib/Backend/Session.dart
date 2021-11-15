import 'package:shared_preferences/shared_preferences.dart';

class Session {
  void setValues(String id, bool isLog) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('id', id);
      prefs.setBool('isLoggedin', isLog);
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

  void removeValues() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove('id');
      prefs.remove('isLoggedin');
    });
  }
}
