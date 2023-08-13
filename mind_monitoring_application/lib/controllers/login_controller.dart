
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