import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class Environment {
  static String get apiToken {
    //environment variables
    final String _username =
        dotenv.get('API_USERNAME', fallback: 'API username not found');
    final String _password =
        dotenv.get('API_PASSWORD', fallback: 'API password not found');

    return 'Basic ' + base64Encode(utf8.encode('$_username:$_password'));
  }

  static String get apiUrl {
    return dotenv.get('API_URL', fallback: 'API url not found');
  }
}
