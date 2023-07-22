import 'package:get/get.dart';
import 'package:mind_monitoring_application/controllers/home_controller.dart';
import 'package:mind_monitoring_application/models/model_value_raw_last_5min.dart';
import 'package:mind_monitoring_application/services/last5mins_value_service.dart';

import '../models/model_value_fft.dart';
import '../models/model_value_last_5min.dart';

class ValueController extends GetxController{
  HomeController homeController = Get.find();
  Rx<ModelValueLast5Min> valueLast5Min = ModelValueLast5Min(data8Bands: [], generals: []).obs;
  List<ModelValueRawLast5Min> valueRawLast5min = <ModelValueRawLast5Min>[];
  Rx<ModelValueFft> valueLastFFT = ModelValueFft(amplitudeSpectrum: [], frequencyAxis: []).obs;
  var loadingScreenTgam = false.obs;
  var loadingScreenRaw = false.obs;
  var loadingScreenFTT = false.obs;
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
  Future<bool> fetchNewFFTValue() async {
    loadingScreenFTT.value = true;
    var newValue =
        await Last5minsValueService.fetchFFTValue(deviceId: homeController.indexDevice.value.id??"");
    if (newValue != null) {
      valueLastFFT.value = newValue;
      loadingScreenFTT.value =false;
      return true;
    }
    valueLastFFT.value = ModelValueFft(amplitudeSpectrum: [], frequencyAxis: []);
    return false;
  }
}
