import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:http/http.dart';

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

  static Future<Response> methodPost(String url, dynamic payload) async {
    return await http.post(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: "${Environment.apiToken}"
      },
      body: payload,
    );
  }

  static Future<Response> methodGet(String url) async {
    return await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: "${Environment.apiToken}"
      },
    );
  }
}
