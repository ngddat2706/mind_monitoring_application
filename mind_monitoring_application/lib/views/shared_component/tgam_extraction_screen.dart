import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mind_monitoring_application/controllers/last5mins_value_controller.dart';

class TgamExtractionScreen extends StatefulWidget {
  const TgamExtractionScreen({Key? key}) : super(key: key);

  @override
  State<TgamExtractionScreen> createState() => _TgamExtractionScreenState();
}

class _TgamExtractionScreenState extends State<TgamExtractionScreen> {
  Last5minsValueController last5minsValueController = Get.put(Last5minsValueController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    last5minsValueController.fetchNewValue();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.orange,
      ),
    );
  }
}