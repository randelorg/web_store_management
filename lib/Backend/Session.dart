import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static Future<void> setValues(String id, bool isLog, String role) async {
    await SharedPreferences.getInstance().then((prefs) {
      prefs.setString('id', id);
      prefs.setBool('isLoggedin', isLog);
      prefs.setString('role', role);
    });
  }

  static Future<bool> getvalues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedin')!;
  }

  static Future<String> getid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('id').toString();
  }

  static Future<String> getrole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('role').toString();
  }

  static void removeValues() {
    //set the default values clockin and clockout
    Session.setTimeIn(true);
    Session.setTimeOut(false);

    //remove the values for the login
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove('id');
      prefs.remove('isLoggedin');
    });
  }

  //for clockins
  static Future<bool> getTimeIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('timeIn') ?? true;
  }

  static Future<bool> getTimeOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('timeOut') ?? false;
  }

  static Future<bool> setTimeIn(bool timeIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool('timeIn', timeIn);
  }

  static Future<bool> setTimeOut(bool timeOut) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool('timeOut', timeOut);
  }
}
