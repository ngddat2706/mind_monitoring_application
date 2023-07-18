import 'package:get/get.dart';
import 'package:mind_monitoring_application/controllers/home_controller.dart';
import 'package:mind_monitoring_application/services/last5mins_value_service.dart';

class Last5minsValueController extends GetxController{
  HomeController homeController = Get.find();

  Future<bool> fetchNewValue() async {
    //await Future.delayed(Duration(milliseconds: 500));
    var newValue =
        await Last5minsValueService.fetchvalue(deviceId: homeController.indexDevice.value.id??"");
    if (newValue != null) {
      print(newValue);
      return true;
    }
    return false;
  }
}