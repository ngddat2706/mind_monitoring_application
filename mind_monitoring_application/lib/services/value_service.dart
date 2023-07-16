
import 'package:mind_monitoring_application/models/model_device.dart';

import '../datas/global_config.dart' as GLOBAL_CONFIG;
import 'connection_service.dart';

class ValueService {
  static Future<List<ModelDevice>?> fetchAllDevice()async{
    var url = Uri.https(GLOBAL_CONFIG.server, "/api/Devices");
    var response = await ConnectionService.client.get(
      url,
    );
    if (response.statusCode == 200) {
      return modelDeviceFromJson(response.body);
    }
    return null;
  }
}