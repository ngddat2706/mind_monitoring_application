
import 'package:get/get.dart';
import 'package:mind_monitoring_application/models/model_device.dart';

class GlobalData extends GetxController{
  //accessToken will have type Rx<AccessTokenModel>
  var errorRequest = "".obs;
  var accessToken = "".obs;
   List<ModelDevice> allDevice = <ModelDevice>[].obs;
}