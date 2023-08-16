import 'dart:convert';

import '../datas/global_config.dart' as GLOBAL_CONFIG;
import 'connection_service.dart';
class LoginService {
  static Future<String?> fetchAuth(String username, String password) async {
    var url = Uri.https(GLOBAL_CONFIG.server, "/api/Users/LoginUser");
    var body = {
      "userName": username,
      "password": password,
      "remember": true,
      "returnUrl": "",
    };
    var response = await ConnectionService.client.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      encoding: Encoding.getByName('utf-8'),
      body: json.encode(body),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return json.decode(response.body)["value"];
    }
    return null;
  }

  static Future<String?> registerAuth(String username, String password, String email, String fullName) async {
    var url = Uri.https(GLOBAL_CONFIG.server, "/api/Users/Register");
    var body = {
      "userName": username,
      "passwordHash": password,
      "passwordSalt": password,
      "email": email,
      "name": fullName,
      "isDeleted": false,
      "createdTime": DateTime.now().toIso8601String(),
      "createdBy": "user",
      "lastModifiedTime": DateTime.now().toIso8601String(),
      "lastModifiedBy": "string",
      "photoFileName":"anonymous.pns",
      "role": 2,
    };
    var response = await ConnectionService.client.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      encoding: Encoding.getByName('utf-8'),
      body: json.encode(body),
    );
    if (response.statusCode == 200) {
      return "";
    }
    print(response.body);
    return null;
  }
}