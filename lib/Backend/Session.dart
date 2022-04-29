import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static Future<void> setValues(
      String id, bool isLog, String role, String branch) async {
    await SharedPreferences.getInstance().then((prefs) {
      prefs.setString('id', id);
      prefs.setBool('isLoggedin', isLog);
      prefs.setString('role', role);
      prefs.setString('branch', branch);
    });
  }

  static Future<bool> getvalues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedin') ?? false;
  }

  static Future<String> getid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('id') ?? '';
  }

  static Future<String> getrole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('role') ?? '';
  }

  static Future<String> getBranch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('branch') ?? '';
  }

  static Future<bool> removeValues() async {
    //set the default values clockin and clockout
    await Session.setTimeIn(true);
    await Session.setTimeOut(false);

    //remove the values for the login
    await SharedPreferences.getInstance().then((prefs) {
      prefs.remove('id');
      prefs.remove('isLoggedin');
    });

    return true;
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
