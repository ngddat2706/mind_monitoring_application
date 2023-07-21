import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mind_monitoring_application/controllers/home_controller.dart';
import 'package:intl/intl.dart';
import 'font_style.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({Key? key}) : super(key: key);

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  HomeController homeController = Get.find();
  String yourJson = '{"general": {"poorQuality": "<<Fill a integer value form 0 to 255>>","attention": "<<Fill a integer value form 0 to 255>>","meditation": "<<Fill a integer value form 0 to 255>>","deviceId": "3fa85f64-5717-4562-b3fc-2c963f66afa6"},"delta": "<<Fill a integer value form 0 to 255>>","theta": "<<Fill a integer value form 0 to 255>>","alpha": "<<Fill a integer value form 0 to 255>>","lowBeta": "<<Fill a integer value form 0 to 255>>","midBeta": "<<Fill a integer value form 0 to 255>>","highBeta": "<<Fill a integer value form 0 to 255>>","gamma": "<<Fill a integer value form 0 to 255>>","uhfGamma": "<<Fill a integer value form 0 to 255, preferably 512 number separated value (by,)>>",  "rawEEGs": [0  ]}';

  
  String prettyString = "";

  @override
  void initState() {
    // TODO: implement initState
    final object = json.decode(yourJson);
    prettyString = JsonEncoder.withIndent('  ').convert(object);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=>SingleChildScrollView(
        padding: EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Column(
            children: [
              CustomFontStyle.indexInformationStation(
                "Name:",
                homeController.indexDevice.value.name),
              CustomFontStyle.indexInformationStation(
                "Description:",
                homeController.indexDevice.value.description),
              Container(
        margin: EdgeInsets.only(top: 2),
        color: Color.fromARGB(255, 0, 8, 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 120,
              padding: EdgeInsets.only(left: 8, top: 3, bottom: 3),
              child: Text(
                "Status: ",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
// Địa chỉ trạm
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(left: 8, top: 3, bottom: 3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color.fromARGB(255, 0, 8, 50))
                ),
                child: Row(
                  children: [
                    CupertinoSwitch(
                      thumbColor: Colors.green,
                      activeColor: Colors.green[900],
                      value: (homeController.indexDevice.value.isActive??false),
                      onChanged: (bool newValue){

                      },
                    ),
                    SizedBox(width: 5,),
                    Text(
                      (homeController.indexDevice.value.isActive??false)?"Active": "Inactive",
                      textAlign: TextAlign.end, // Điền địa chỉ vào
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
              CustomFontStyle.indexInformationStation(
                "Last Active:",
                DateFormat("hh:mm a - MMMM dd,yyyy").format(homeController.indexDevice.value.activeTime??DateTime.now())),
              CustomFontStyle.indexInformationStation(
                "Created At:",
                DateFormat("hh:mm a - MMMM dd,yyyy").format(homeController.indexDevice.value.createdTime??DateTime.now())),
                SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 3,
                      offset: Offset(2, 2)
                    ),
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 3,
                      offset: Offset(-2, -2)
                    )
                  ]
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                      child: Text(
                        "Device API information for sending EEG data to Brainwave System:",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                        ),
                      ),
                    ),
                    CustomFontStyle.indexInformationDevice(
                      "URL:",
                      "https://localhost:44321/api/DeviceDatas/" + (homeController.indexDevice.value.id??"")),
                    CustomFontStyle.indexInformationDevice(
                      "HTTP Method:",
                      "POST"),
                    CustomFontStyle.indexInformationDevice(
                      "Header",
                      "{\n  accept: text/plain,\n  Content-type: application/json\n}"),
                    CustomFontStyle.indexInformationDevice(
                      "Body (Payload) format",
                      prettyString),
                  ],
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}