import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddDeviceController extends GetxController{
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  var nameError = "".obs;
  var status = "hoạt động".obs;
  checkRegisterNameError(){
    if(name.text.isEmpty){
      nameError.value ="Không được để trống";
      return false;
    }else{
      nameError.value = "";
      return true;
    }
  }
}