
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mind_monitoring_application/models/model_device.dart';

import '../datas/globalData.dart';
import '../services/value_service.dart';
import '../views/pages/home_screen.dart';
import 'login_controller.dart';

enum HomeScreenState {initScreen, reportScreen, notificationScreen, intormationScreen}
enum ButtonState {init, loading, done}
class HomeController extends GetxController{
  var homeScreenState = HomeScreenState.initScreen.obs;
  LoginController loginController = Get.find();
  GlobalData globalData = Get.find();
  var loadingScreen = true.obs;
  Rx<ModelDevice> indexDevice = ModelDevice().obs;
 

  
  Future<bool> fetchAllDevice() async {
    loadingScreen.value = true;
    //await Future.delayed(Duration(milliseconds: 500));
    var newListDevice =
        await ValueService.fetchAllDevice();
    if (newListDevice != null) {
      globalData.allDevice= newListDevice;
      loadingScreen.value = false;
      return true;
    }
    globalData.allDevice.clear();
    return false;
  }

}