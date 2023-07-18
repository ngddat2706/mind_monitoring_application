
import 'dart:convert';

import 'package:mind_monitoring_application/models/model_device.dart';

import '../datas/global_config.dart' as GLOBAL_CONFIG;
import 'connection_service.dart';

class AddDeviceService {
  static Future<ModelDevice?> addNewDevice({required String name, String description = '',required bool isActive})async{
    var url = Uri.https(GLOBAL_CONFIG.server, "/api/Devices");
    var body = {
      "name": name,
      "description": description,
      "isActive": isActive
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
      return ModelDevice.fromJson(json.decode(response.body));
    }
    return null;
  }
}