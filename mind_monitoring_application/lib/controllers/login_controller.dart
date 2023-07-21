
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../datas/globalData.dart';
// import '../services/login_service.dart';
// import '../services/refresh_token_service.dart';

class LoginController extends GetxController{
  GlobalData globalData = Get.find();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var userNameLogin ="BrwS".obs;
  var statusNotification = true.obs;

  var userName = '';
  var password = '';
  var isLoading = false.obs;
  var isDone = false.obs;
  var currentPage = 0.obs;

  Future<bool> fetchAccessToken() async {
    // var newAccessToken =
    //     await LoginService.fetchAuthDataFromUserCred(userName, password);
    // if (newAccessToken != null) {
    //   return true;
    // } else {
    //   return false;
    // }
    return true;
  }

  Future<bool> checkLogin() async {
    userName = userNameController.text;
    password = passwordController.text;
    return await fetchAccessToken();
  }

  Future<bool> refreshAccessToken()async{
    return true;
    // var newAccessToken = await RefreshTokenService.refeshAuthDataFromRefeshToken("");
    // if(newAccessToken != null){
    //   return true;
    // }else if(await fetchAccessToken()){
    //   return true;
    // }
    // return false;
  }
}