import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mind_monitoring_application/controllers/value_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../../models/model_value_raw_last_5min.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
class RawEEFDataScreen extends StatefulWidget {
  const RawEEFDataScreen({Key? key}) : super(key: key);

  @override
  State<RawEEFDataScreen> createState() => _RawEEFDataScreenState();
}

class _RawEEFDataScreenState extends State<RawEEFDataScreen> {
   ValueController valueController = Get.find();

  @override
  void initState() {
    valueController.chartData4 = <ChartData>[
      ChartData(2005, 0, 0),
      ChartData(2006, 0, 44),
      ChartData(2007, 36, 44),
      ChartData(2008, 0, 44),
      ChartData(2009, 54, 66),
    ];
    super.initState();
  }

  Future<void> _refresh() async{
    //valueController.fetchNewValue();
    valueController.loadingScreenRaw.value = true;
    await Future.delayed(
      Duration(seconds: 2),
    );
    valueController.loadingScreenRaw.value = false;
    return Future.delayed(
      Duration(milliseconds: 2),
    );
  }
   late ZoomPanBehavior zoomPanBehavior;
  late TrackballBehavior trackballBehavior;
  late ZoomPanBehavior zoomPanBehavior2;
  late TrackballBehavior trackballBehavior2;

  @override
  Widget build(BuildContext context) {
    trackballBehavior = TrackballBehavior(
      activationMode: ActivationMode.singleTap,
      enable: true,
      tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
      shouldAlwaysShow: false,
      hideDelay: 1000,
    );

    zoomPanBehavior = ZoomPanBehavior(
                    enablePinching: true,
                    zoomMode: ZoomMode.x,
                    enablePanning: true,
                );
    trackballBehavior2 = TrackballBehavior(
      activationMode: ActivationMode.singleTap,
      enable: true,
      tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
      shouldAlwaysShow: false,
      hideDelay: 1000,
    );

    zoomPanBehavior2 = ZoomPanBehavior(
                    enablePinching: true,
                    zoomMode: ZoomMode.x,
                    enablePanning: true,
                );

    final height = MediaQuery.of(context).size.height;
    return Obx(()=> Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: valueController.loadingScreenRaw.value
              ? Container(
                  height: MediaQuery.of(context).size.height - 150,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.indigo[900],
                    ),
                  ),
                )
              :  Column(
            children: [
              Container(
                        height: height-(kIsWeb?100:210), child: _buildDefaultLineChart()),
              Container(height: height-(kIsWeb?100:210), child: _buildDefaultLineChart2(),),
              SizedBox(height: kIsWeb?0:70,)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _refresh();
          },
          backgroundColor: Color.fromARGB(255, 0, 22, 100),
          child: Tooltip(
            message: "REFRESH",
            child: Icon(Icons.refresh)
          ),
        ),
    ),
    );
  }

  /// Get the cartesian chart with default line series
  SfCartesianChart _buildDefaultLineChart() {
    return SfCartesianChart(
      trackballBehavior: trackballBehavior,
      zoomPanBehavior: zoomPanBehavior,
      plotAreaBorderWidth: 0,
      legend: Legend(
        position: LegendPosition.top,
          isVisible: true,
          iconWidth: 40, iconHeight: 15),
      primaryXAxis: CategoryAxis(
        arrangeByIndex: true,
          labelRotation: -45,
          interval: 1,
          isInversed: true,
          labelStyle: TextStyle(color: Colors.transparent, fontSize: 0),
          edgeLabelPlacement: EdgeLabelPlacement.shift),
      primaryYAxis: NumericAxis(
        rangePadding: ChartRangePadding.round ,
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: _getDefaultLineSeries(),
    );
  }

  /// The method returns line series to chart.
  List<LineSeries<ModelValueRawLast5Min, String>> _getDefaultLineSeries() {
    return <LineSeries<ModelValueRawLast5Min, String>>[
      LineSeries<ModelValueRawLast5Min, String>(
        legendIconType: LegendIconType.rectangle,
          dataSource: valueController.valueRawLast5min,
          xValueMapper: (ModelValueRawLast5Min sales, _) => DateFormat("hh:mm a - MMMM dd,yyyy").format(sales.recivedTime),
          yValueMapper: (ModelValueRawLast5Min sales, _) => sales.value,
          width: 2,
          name: 'Raw EEG',
          color: Colors.blue[900],),
    ];
  }

  SfCartesianChart _buildDefaultLineChart2() {
    return SfCartesianChart(
      trackballBehavior: trackballBehavior2,
      zoomPanBehavior: zoomPanBehavior2,
      plotAreaBorderWidth: 0,
      legend: Legend(
        position: LegendPosition.top,
          isVisible: true,iconWidth: 40, iconHeight: 15),
      primaryXAxis: NumericAxis(
        labelRotation: -45,
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          interval: 2,),
      primaryYAxis: NumericAxis(
        rangePadding: ChartRangePadding.round ,
          labelFormat: '{value}.000',
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: _getDefaultLineSeries2(),
    );
  }

  /// The method returns line series to chart.
  List<LineSeries<ChartData, num>> _getDefaultLineSeries2() {
    return <LineSeries<ChartData, num>>[
      LineSeries<ChartData, num>(
        legendIconType: LegendIconType.rectangle,
          color: Colors.blue[900],
          dataSource: valueController.chartData4!,
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          width: 2,
          name: 'Amplitude Spectrum',),
    ];
  }

  @override
  void dispose() {
    valueController.chartData4!.clear();
    super.dispose();
  }
}

