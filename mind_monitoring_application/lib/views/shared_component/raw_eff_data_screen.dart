import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mind_monitoring_application/controllers/value_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../../models/model_value_raw_last_5min.dart';

class RawEEFDataScreen extends StatefulWidget {
  const RawEEFDataScreen({Key? key}) : super(key: key);

  @override
  State<RawEEFDataScreen> createState() => _RawEEFDataScreenState();
}

class _RawEEFDataScreenState extends State<RawEEFDataScreen> {
  ValueController valueController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _refresh() async {
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
    return Obx(
      () => Scaffold(
        body: SingleChildScrollView(
          child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: height - 130,
                        child: valueController.loadingScreenRaw.value
                        ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.indigo[900],
                          ),
                        )
                        :_buildDefaultLineChart()),
                    Container(
                      padding: EdgeInsets.only(left: 40),
                      child: ElevatedButton(
                        onPressed: () {
                          valueController.fetchNewRawValue();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            elevation: 10,
                            visualDensity:
                                VisualDensity(horizontal: 0, vertical: 0),
                            padding: EdgeInsets.only(left: 5, right: 5),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        child: Text("REFRESH"),
                      ),
                    ),
                    Container(
                      height: height -130,
                      child: valueController.loadingScreenFTT.value
                        ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.indigo[900],
                          ),
                        )
                        :_buildDefaultLineChart2(),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 40),
                      child: ElevatedButton(
                        onPressed: () {
                          valueController.fetchNewFFTValue();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            elevation: 10,
                            visualDensity:
                                VisualDensity(horizontal: 0, vertical: 0),
                            padding: EdgeInsets.only(left: 5, right: 5),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        child: Text("REFRESH"),
                      ),
                    ),
                    SizedBox(height: 50,)
                  ],
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
          iconWidth: 40,
          iconHeight: 15),
      primaryXAxis: CategoryAxis(
          arrangeByIndex: true,
          labelRotation: -45,
          interval: 1,
          isInversed: true,
          labelStyle: TextStyle(color: Colors.transparent, fontSize: 0),
          edgeLabelPlacement: EdgeLabelPlacement.shift),
      primaryYAxis: NumericAxis(
          rangePadding: ChartRangePadding.round,
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: _getDefaultLineSeries(),
    );
  }

  /// The method returns line series to chart.
  List<LineSeries<int, String>> _getDefaultLineSeries() {
    return <LineSeries<int, String>>[
      LineSeries<int, String>(
        legendIconType: LegendIconType.rectangle,
        dataSource: valueController.listIndex,
        xValueMapper: (int sales, _) =>
            DateFormat("hh:mm a - MMMM dd,yyyy").format(valueController.valueRawLast5min.value.recivedTimes[sales]),
        yValueMapper: (int sales, _) => valueController.valueRawLast5min.value.values[sales],
        width: 2,
        name: 'Raw EEG',
        color: Colors.blue[900],
      ),
    ];
  }

  SfCartesianChart _buildDefaultLineChart2() {
    return SfCartesianChart(
      trackballBehavior: trackballBehavior2,
      zoomPanBehavior: zoomPanBehavior2,
      plotAreaBorderWidth: 0,
      legend: Legend(
          position: LegendPosition.top,
          isVisible: true,
          iconWidth: 40,
          iconHeight: 15),
      primaryXAxis: CategoryAxis(
          arrangeByIndex: true,
          labelRotation: -45,
          interval: 1,
          isInversed: true,
          labelStyle: TextStyle(color: Colors.transparent, fontSize: 0),
          edgeLabelPlacement: EdgeLabelPlacement.shift),
      primaryYAxis: NumericAxis(
          rangePadding: ChartRangePadding.round,
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: _getDefaultLineSeries2(),
    );
  }

  /// The method returns line series to chart.
  List<LineSeries<ModelValueRawLast5Min, String>> _getDefaultLineSeries2() {
    return <LineSeries<ModelValueRawLast5Min, String>>[
      LineSeries<ModelValueRawLast5Min, String>(
        legendIconType: LegendIconType.rectangle,
        color: Colors.blue[900],
        dataSource: valueController.valueLastFFT.value.amplitudeSpectrum,
        xValueMapper: (ModelValueRawLast5Min sales, _) =>
            DateFormat("hh:mm a - MMMM dd,yyyy").format(DateTime.now()),
        yValueMapper: (ModelValueRawLast5Min sales, _) => 2,
        width: 2,
        name: 'Amplitude Spectrum',
      ),
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }
}
