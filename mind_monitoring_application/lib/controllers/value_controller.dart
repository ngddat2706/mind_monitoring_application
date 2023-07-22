import 'package:get/get.dart';
import 'package:mind_monitoring_application/controllers/home_controller.dart';
import 'package:mind_monitoring_application/models/model_value_raw_last_5min.dart';
import 'package:mind_monitoring_application/services/last5mins_value_service.dart';

import '../models/model_value_last_5min.dart';

class ValueController extends GetxController{
  HomeController homeController = Get.find();
  List<ChartData>? chartData4;
  Rx<ModelValueLast5Min> valueLast5Min = ModelValueLast5Min(data8Bands: [], generals: []).obs;
  List<ModelValueRawLast5Min> valueRawLast5min = <ModelValueRawLast5Min>[];
  var loadingScreenTgam = false.obs;
  var loadingScreenRaw = false.obs;
  Future<bool> fetchNewValue() async {
    loadingScreenTgam.value = true;
    var newValue =
        await Last5minsValueService.fetchvalue(deviceId: homeController.indexDevice.value.id??"");
    if (newValue != null) {
      valueLast5Min.value = newValue;
      loadingScreenTgam.value =false;
      return true;
    }
    valueLast5Min.value = ModelValueLast5Min(data8Bands: [], generals: []);
    return false;
  }

  Future<bool> fetchNewRawValue() async {
    loadingScreenRaw.value = true;
    var newValue =
        await Last5minsValueService.fetchrawvalue(deviceId: homeController.indexDevice.value.id??"");
    if (newValue != null) {
      valueRawLast5min = newValue;
      loadingScreenRaw.value =false;
      return true;
    }
    valueRawLast5min = [];
    return false;
  }
}

class ChartData {
  ChartData(this.x, this.y, this.y2);
  final double x;
  final double y;
  final double y2;
}
