import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mind_monitoring_application/controllers/login_controller.dart';
import 'package:mind_monitoring_application/models/model_device.dart';
import 'package:mind_monitoring_application/views/pages/notification_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiengviet/tiengviet.dart';

import '../../controllers/home_controller.dart';
import '../../controllers/value_controller.dart';
import '../../datas/globalData.dart';
import 'add_device_screen.dart';
import 'detail_device_screen.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController? _textEditingController = TextEditingController();
  HomeController homeController = Get.put(HomeController());
  ValueController valueController = Get.put(ValueController());
  LoginController loginController = Get.find();
  GlobalData globalData = Get.find();
  List<Widget> listDataFlow = <Widget>[].obs;
  late FocusNode myFocusNode;
  List<ModelDevice> addressListOnSearch = [];
  DateTime pre_backpress = DateTime.now();
  LoginController controller = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.fetchAllDevice();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myFocusNode.dispose();
  }

  List<ModelDevice> findDevice(List<ModelDevice> listStation, value) {
    List<ModelDevice> addressListOnSearch = listStation
        .where((element) => TiengViet.parse(element.name??"")
            .toLowerCase()
            .contains(TiengViet.parse(value).toLowerCase()))
        .toList();
    return addressListOnSearch;
  }

  Future<void> _refresh() {
    homeController.fetchAllDevice();
    return Future.delayed(
      Duration(milliseconds: 2),
    );
  }

  void functionLogout() async {
    final timegap = DateTime.now().difference(pre_backpress);
    final cantExit = timegap >= Duration(seconds: 2);
    pre_backpress = DateTime.now();
    if (cantExit) {
      Get.closeAllSnackbars();
      Get.snackbar(
        "Brainwave System",
        "Nhấn lần nữa để đăng xuất!",
        isDismissible: true,
        duration: Duration(seconds: 2),
      );
      // false will do nothing when back press
    } else {
      if (!kIsWeb) {
        if (Platform.isAndroid || Platform.isIOS) {
          FirebaseMessaging.instance
            .unsubscribeFromTopic(controller.userNameLogin.value);
          }
      }
      controller.passwordController.clear();
      controller.userNameController.clear();
      controller.userName = "";
      controller.password = "";
      controller.isLoading.value = false;
      controller.isDone.value = false;
      final preferences = await SharedPreferences.getInstance();
      preferences.remove('username');
      preferences.remove('password');
      Get.offNamed('/login'); // true will exit the app
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leadingWidth: 0,
          title: Row(
            children: [
              Image.asset(
                'assets/logo.png',
                height: 60,
              ),
              Text(
                    "Device: " + loginController.userNameLogin.value,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,),
                  ),
              Spacer(),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                    child: TextButton(
                      onPressed: () {
                        Get.dialog(
                          Center(
                              child: Stack(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(
                                      left: 3, right: 3, top: 30, bottom: 30),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: NotificationScreen())),
                            ],
                          )),
                        );
                      },
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: 0),
                          padding: EdgeInsets.all(0),
                          minimumSize: Size(30, 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      child: Icon(
                        Icons.notifications_outlined,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                  Positioned(
                    top: kIsWeb?0:10,
                    right: kIsWeb?7:15,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.red[900], shape: BoxShape.circle),
                      child: Text(
                        "2",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  )
                ],
              ),
               SizedBox(width: kIsWeb?10:0,),
               TextButton(
                 onPressed: () {
                   functionLogout();
                 },
                 style: TextButton.styleFrom(
                     primary: Colors.blue,
                     ),
                 child: Text(
                   "LOGOUT",
                   style: TextStyle(
                     color: Colors.black,
                     fontSize: 16,
                   ),
                 ),
               ),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              height: 45,
              margin: EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 15),
              padding: const EdgeInsets.only(bottom: 2, left: 20, right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1.0, color: Colors.indigo[900]!),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigo.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ]),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          addressListOnSearch =
                              findDevice(globalData.allDevice, value);
                        });
                      },
                      maxLines: 1,
                      focusNode: myFocusNode,
                      textAlignVertical: TextAlignVertical.center,
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        errorBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Enter device name!',
                        hintStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black45),
                        suffixIcon: _textEditingController!.text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  _textEditingController!.clear();
                                  //FocusScope.of(context).unfocus();
                                  setState(() {});
                                },
                                icon: Icon(Icons.cancel, color: Colors.grey))
                            : null,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 25,
                  )
                ],
              ),
            ),
// // List Device
//             Container(
//               alignment: Alignment.centerLeft,
//               padding: EdgeInsets.only(left: 20, bottom: 5),
//               child: Row(
//                 children: [
//                   Text(
//                     "Thiết bị giảm sát",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 17,
//                         fontWeight: FontWeight.w500),
//                   ),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   Container(
//                     width: 23,
//                     height: 23,
//                     decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: Center(
//                       child: Text(
//                         homeController.loadingScreen.value
//                             ? "0"
//                             : (_textEditingController!.text.isNotEmpty
//                                     ? (addressListOnSearch.length)
//                                     : (globalData.allDevice.length))
//                                 .toString(),
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 17,
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
            Expanded(
              child: RefreshIndicator(
                displacement: 100,
                onRefresh: _refresh,
                color: Colors.indigo[900],
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Container(
                    child: homeController.loadingScreen.value
                        ? Container(
                            height: MediaQuery.of(context).size.height - 260,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.indigo[900],
                              ),
                            ),
                          )
                        : Container(
                            child: _textEditingController!.text.isNotEmpty &&
                                    addressListOnSearch.isEmpty
                                ? Container(
                                    height: MediaQuery.of(context).size.height -
                                        260,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.search_off,
                                          size: 50,
                                          color: Colors.indigo[900],
                                        ),
                                        Text(
                                          'Không tìm thấy thiết bị',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    alignment: width > 600
                                        ? Alignment.topLeft
                                        : Alignment.topCenter,
                                    constraints: BoxConstraints(
                                        minHeight:
                                            MediaQuery.of(context).size.height -
                                                100),
                                    child: Wrap(
                                        alignment: WrapAlignment.start,
                                        direction: Axis.horizontal,
                                        spacing: 10,
                                        runSpacing: 10,
                                        children: List<Widget>.generate(
                                            _textEditingController!
                                                    .text.isNotEmpty
                                                ? (addressListOnSearch.length)
                                                : (globalData.allDevice
                                                    .length), (index) {
                                          return Container(
                                              height: width > 600 ? 170 : 100,
                                              width: width > 600 ? 170 : width,
                                              margin: EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 0, 8, 50),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.indigo
                                                          .withOpacity(0.2),
                                                      blurRadius: 5,
                                                      spreadRadius: 2,
                                                      offset: Offset(0, 0),
                                                    ),
                                                  ]),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: Color.fromARGB(
                                                        255, 0, 8, 50),
                                                    foregroundColor: Colors.blue[300],
                                                    visualDensity:
                                                        VisualDensity(
                                                            horizontal: 0,
                                                            vertical: 0),
                                                    padding: EdgeInsets.all(0),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10))),
                                                onPressed: () {
                                                  homeController
                                                          .indexDevice.value =
                                                      _textEditingController!
                                                              .text.isNotEmpty
                                                          ? (addressListOnSearch[
                                                              index])
                                                          : (globalData.allDevice[
                                                              index]);
                                                  Get.to(DetailDeviceScreen());
                                                },
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          top: 10,
                                                          left: 10,
                                                          right: 5),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        _textEditingController!
                                                                .text.isNotEmpty
                                                            ? (addressListOnSearch[
                                                                index].name??"")
                                                            : (globalData.allDevice[
                                                                index].name??""),
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ));
                                        }))),
                          ),
                  ),
                ),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.dialog(
                Center(
                    child: Stack(
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                            left: 5, right: 5, top: 40, bottom: 30),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: AddDeviceScreen())),
                  ],
                )),
                barrierDismissible: false);
          },
          backgroundColor: Color.fromARGB(255, 0, 22, 100),
          child: Tooltip(
            message: "CREATE NEW DEVICE",
            child: Icon(Icons.add)
          ),
        ),
      ),
    );
  }
}
