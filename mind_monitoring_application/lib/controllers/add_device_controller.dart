import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mind_monitoring_application/controllers/home_controller.dart';
import 'package:mind_monitoring_application/services/add_device_service.dart';

class AddDeviceController extends GetxController{
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  HomeController homeController = Get.find();
  var nameError = "".obs;
  var status = "Active".obs;
  checkRegisterNameError(){
    if(name.text.isEmpty){
      nameError.value ="Can not be empty!";
      return false;
    }else{
      nameError.value = "";
      return true;
    }
  }

  Future<bool> addNewDevice() async {
    //await Future.delayed(Duration(milliseconds: 500));
    var newListDevice =
        await AddDeviceService.addNewDevice(name: name.text, description: description.text, isActive: status.value == "hoạt động");
    if (newListDevice != null) {
      homeController.fetchAllDevice();
      return true;
    }
    return false;
  }
}