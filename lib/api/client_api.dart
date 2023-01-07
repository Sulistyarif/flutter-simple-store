import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:simple_store/data/provider_user.dart';
import 'package:simple_store/models/users.dart' as userClass;

class ClientApi {
  static final Uri uri = Uri.parse('http://192.168.18.6:5004');
  static final client = http.Client();

  static Future<Map<String, dynamic>> login(username, password, context) async {
    var response = await client.post(
      Uri.parse('$uri/login'),
      headers: {
        "content-type": "application/x-www-form-urlencoded",
      },
      body: {
        'username': username,
        'password': password,
      },
    );
    Map<String, dynamic> resJson = json.decode(response.body);
    Provider.of<ProviderUser>(context, listen: false)
        .setUser(userClass.Users.fromJson(resJson['data']));
    log(response.body);
    return resJson;
  }

  static Future<bool> register(username, email, password) async {
    var response = await client.post(
      Uri.parse('$uri/crud'),
      headers: {
        "content-type": "application/x-www-form-urlencoded",
      },
      body: {
        'username': username,
        'email': email,
        'password': password,
      },
    );
    Map<String, dynamic> resJson = json.decode(response.body);
    log(response.body);
    if (resJson['success']) {
      return true;
    } else {
      return false;
    }
  }

  static Future<String> forgot(username) async {
    var response = await client.post(
      Uri.parse('$uri/password'),
      headers: {
        "content-type": "application/x-www-form-urlencoded",
      },
      body: {
        'username': username,
      },
    );
    Map<String, dynamic> resJson = json.decode(response.body);
    log(response.body);
    return resJson['message'];
  }
}
