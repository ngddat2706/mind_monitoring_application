import 'package:get/get.dart';
import 'package:mind_monitoring_application/controllers/home_controller.dart';
import 'package:mind_monitoring_application/services/last5mins_value_service.dart';

class ValueController extends GetxController{
  HomeController homeController = Get.find();
  List<SplineAreaData>? chartData;
  List<ChartSampleData>? chartData2;
  List<ChartData>? chartData3;
  List<ChartData>? chartData4;
  var loadingScreenTgam = false.obs;
  var loadingScreenRaw = false.obs;
  Future<bool> fetchNewValue() async {
    //await Future.delayed(Duration(milliseconds: 500));
    var newValue =
        await Last5minsValueService.fetchvalue(deviceId: homeController.indexDevice.value.id??"");
    if (newValue != null) {
      print(newValue);
      return true;
    }
    return false;
  }
}

class ChartSampleData {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleData(this.x,
      this.y,
      this.y1,
      this.y2,
      this.y3,
      this.y4,
      this.y5,
      this.y6,
      this.y7,);

  /// Holds x value of the datapoint
  final dynamic x;

  /// Holds y value of the datapoint
  final double y;
  final double y1;
  final double y2;
  final double y3;
  final double y4;
  final double y5;
  final double y6;
  final double y7;
}

class ChartData {
  ChartData(this.x, this.y, this.y2);
  final double x;
  final double y;
  final double y2;
}

class SplineAreaData {
  SplineAreaData(this.year, this.y1, this.y2, this.y3);
  final double year;
  final double y1;
  final double y2;
  final double y3;
}