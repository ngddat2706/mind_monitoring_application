import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mind_monitoring_application/controllers/home_controller.dart';

import 'font_style.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({Key? key}) : super(key: key);

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=>SingleChildScrollView(
        padding: EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Column(
            children: [
              CustomFontStyle.indexInformationStation(
                Icons.assistant_photo,
                "Name:",
                homeController.indexDevice.value.name),
              CustomFontStyle.indexInformationStation(
                Icons.assistant_photo,
                "Id:",
                homeController.indexDevice.value.id),
              CustomFontStyle.indexInformationStation(
                Icons.assistant_photo,
                "Description:",
                homeController.indexDevice.value.description),
              CustomFontStyle.indexInformationStation(
                Icons.assistant_photo,
                "Status:",
                (homeController.indexDevice.value.isActive??false)?"Actice":"Not actice"),
              CustomFontStyle.indexInformationStation(
                Icons.assistant_photo,
                "Created time:",
                CustomFontStyle.getDateAndTime( homeController.indexDevice.value.createdTime??DateTime.now())),
              CustomFontStyle.indexInformationStation(
                Icons.assistant_photo,
                "Created by:",
                homeController.indexDevice.value.createdBy),
            ],
          )
        ),
      ),
    );
  }
}