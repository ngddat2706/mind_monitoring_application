import 'package:mind_monitoring_application/models/model_value_raw_last_5min.dart';

import '../datas/global_config.dart' as GLOBAL_CONFIG;
import '../models/model_value_last_5min.dart';
import 'connection_service.dart';

class Last5minsValueService {
  static Future<ModelValueLast5Min?> fetchvalue({required String deviceId})async{
    var url = Uri.https(GLOBAL_CONFIG.server, "/api/DeviceDatas/{$deviceId}/Last5Mins");
    var response = await ConnectionService.client.get(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      print("ok");
      return modelValueLast5MinFromJson(response.body);
    }
    return null;
  }

  static Future<List<ModelValueRawLast5Min>?> fetchrawvalue({required String deviceId})async{
    var url = Uri.https(GLOBAL_CONFIG.server, "/api/DataRawEEGs/{$deviceId}/Last5Mins");
    var response = await ConnectionService.client.get(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      print("ok");
      return modelValueRawLast5MinFromJson(response.body);
    }
    return null;
  }
}