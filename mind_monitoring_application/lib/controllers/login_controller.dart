
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../datas/globalData.dart';
import '../services/login_service.dart';
// import '../services/login_service.dart';
// import '../services/refresh_token_service.dart';

class LoginController extends GetxController{
  GlobalData globalData = Get.find();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameRegisterController = TextEditingController();
  TextEditingController emailControler = TextEditingController();
  TextEditingController passwordRegisterController= TextEditingController();
  TextEditingController confirm = TextEditingController();
  TextEditingController fullName = TextEditingController();
  var userNameLogin ="BrwS".obs;
  var statusNotification = true.obs;
  var userId = "".obs;

  var userName = '';
  var password = '';
  var isLoading = false.obs;
  var isDone = false.obs;
  var currentPage = 0.obs;
  Future<bool> fetchAccessToken() async {
    var newAccessToken =
        await LoginService.fetchAuth(userName, password);
    if (newAccessToken != null) {
      globalData.accessToken.value = newAccessToken;
      //print(newAccessToken);
      //print(newAccessToken.split(".")[1]);
      try{
        var decodedPayload = String.fromCharCodes(base64Url.decode(base64Url.normalize(newAccessToken.split(".")[1])));
        var payloadMap = json.decode(decodedPayload);
        //print(payloadMap);
        userNameLogin.value =payloadMap["name"];
        userId.value = payloadMap["userId"];
      }catch(exception){
        print("fail decode");
      }
      
      return true;
    }
    return false;
  }

  Future<bool> checkLogin() async {
    userName = userNameController.text;
    password = passwordController.text;
    return await fetchAccessToken();
  }

  Future<bool> register()async{
   var newAccessToken =
        await LoginService.registerAuth(nameRegisterController.text, passwordRegisterController.text, emailControler.text, fullName.text);
    if (newAccessToken != null) {
      return true;
    }
    return false;
  }
}