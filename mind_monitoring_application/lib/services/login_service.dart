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
       "isDeleted": true,
      "createdTime": "2023-08-13T19:36:46.863Z",
      "createdBy": "string",
      "lastModifiedTime": "2023-08-13T19:36:46.863Z",
      "lastModifiedBy": "string",
      "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "photoFileName": "string",
      "role": 0,
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