import '../datas/global_config.dart' as GLOBAL_CONFIG;
import 'connection_service.dart';

class Last5minsValueService {
  static Future<String?> fetchvalue({required String deviceId})async{
    var url = Uri.https(GLOBAL_CONFIG.server, "/api/DeviceDatas/{$deviceId}/Last5Mins");
    var response = await ConnectionService.client.get(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }
}