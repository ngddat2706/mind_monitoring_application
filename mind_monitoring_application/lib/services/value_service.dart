
import 'package:get/get.dart';
import 'package:mind_monitoring_application/models/model_device.dart';

import '../controllers/login_controller.dart';
import '../datas/globalData.dart';
import '../datas/global_config.dart' as GLOBAL_CONFIG;
import 'connection_service.dart';

class ValueService {
  // static Future<List<ModelDevice>?> fetchAllDevice()async{
  //   var url = Uri.https(GLOBAL_CONFIG.server, "/api/Devices");
  //   GlobalData globalData = Get.find();
  //   var response = await ConnectionService.client.get(
  //     url,
  //     headers: {
  //       "Authorization": "Bearer ${globalData.accessToken.value}",
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     print(response.body);
  //     return modelDeviceFromJson(response.body);
  //   }
  //   return null;
  // }
  static Future<List<ModelDevice>?> fetchAllDevice()async{
    LoginController loginController = Get.find();
    var param = {
      "userId" : loginController.userId.value,
    };
    var url = Uri.https(GLOBAL_CONFIG.server, "/api/Devices/userId",param);
    GlobalData globalData = Get.find();
    
    var response = await ConnectionService.client.get(
      url,
      headers: {
        "Authorization": "Bearer ${globalData.accessToken.value}",
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return modelDeviceFromJson(response.body);
    }else if(response.statusCode ==401){
      if(await loginController.fetchAccessToken()){
        return fetchAllDevice();
      }
    }
    return null;
  }
}