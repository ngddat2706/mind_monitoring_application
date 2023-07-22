import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mind_monitoring_application/controllers/value_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../../models/model_value_last_5min.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class TgamExtractionScreen extends StatefulWidget {
  const TgamExtractionScreen({Key? key}) : super(key: key);

  @override
  State<TgamExtractionScreen> createState() => _TgamExtractionScreenState();
}

class _TgamExtractionScreenState extends State<TgamExtractionScreen> {
  ValueController valueController = Get.find();

  late bool toggleVisibility;
  late bool enableFloatingLegend;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _refresh() async{
    valueController.fetchNewValue();
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
          child: valueController.loadingScreenTgam.value
              ? Container(
                  height: MediaQuery.of(context).size.height - 260,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.indigo[900],
                    ),
                  ),
                )
              : Column(
                  children: [
                    Container(
                        height: height-(kIsWeb?100:210), child: _buildCartesianLegendOptionsChart()),
                    Container(height: height-(kIsWeb?100:210), child: _buildDefaultSplineChart()),
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

  /// Returns the stacked line chart with various legedn modification options.
  SfCartesianChart _buildCartesianLegendOptionsChart() {
    return SfCartesianChart(
      trackballBehavior: trackballBehavior,
      zoomPanBehavior: zoomPanBehavior,
      legend: Legend(isVisible: true, iconWidth: 40, iconHeight: 15, position: LegendPosition.top, overflowMode: LegendItemOverflowMode.wrap),
      plotAreaBorderWidth: 0,
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
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getSplieAreaSeries(),
    );
  }

  /// Returns the list of chart series which need to render
  /// on the stacked area chart.
  List<ChartSeries<General, String>> _getSplieAreaSeries() {
    return <ChartSeries<General, String>>[
      SplineAreaSeries<General, String>(
        splineType: SplineType.cardinal,
        legendIconType: LegendIconType.rectangle,
        dataSource: valueController.valueLast5Min.value.generals,
        color: Color.fromARGB(153, 213, 216, 41),
        borderColor: Color.fromARGB(255, 168, 185, 75),
        borderWidth: 2,
        name: 'Poor Quality',
        xValueMapper: (General general, _) => DateFormat("hh:mm a - MMMM dd,yyyy").format(general.createdTime),
        yValueMapper: (General general, _) => general.poorQuality,
      ),
      SplineAreaSeries<General, String>(
        splineType: SplineType.cardinal,
        legendIconType: LegendIconType.rectangle,
        dataSource: valueController.valueLast5Min.value.generals,
        borderColor: const Color.fromRGBO(192, 108, 132, 1),
        color: const Color.fromRGBO(192, 108, 132, 0.6),
        borderWidth: 2,
        name: 'Meditation',
        xValueMapper: (General general, _) => DateFormat("hh:mm a - MMMM dd,yyyy").format(general.createdTime),
        yValueMapper: (General general, _) => general.meditation,
      ),
      SplineAreaSeries<General, String>(
        splineType: SplineType.cardinal,
        legendIconType: LegendIconType.rectangle,
        dataSource: valueController.valueLast5Min.value.generals,
        borderColor: const Color.fromARGB(255, 34, 126, 26),
        color: Color.fromARGB(85, 35, 143, 25),
        borderWidth: 2,
        name: 'Attention',
        xValueMapper: (General general, _) => DateFormat("hh:mm a - MMMM dd,yyyy").format(general.createdTime),
        yValueMapper: (General general, _) => general.attention,
      )
    ];
  }

  SfCartesianChart _buildDefaultSplineChart() {
    return SfCartesianChart(
      trackballBehavior: trackballBehavior2,
      zoomPanBehavior: zoomPanBehavior2,
      plotAreaBorderWidth: 0,
      legend: Legend(
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap,
          iconWidth: 40, iconHeight: 15, position: LegendPosition.top),
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
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getDefaultSplineSeries(),
    );
  }

  /// Returns the list of chart series which need to render on the spline chart.
  List<SplineSeries<Data8Band, String>> _getDefaultSplineSeries() {
    return <SplineSeries<Data8Band, String>>[
      SplineSeries<Data8Band, String>(
        splineType: SplineType.cardinal,
        legendIconType: LegendIconType.rectangle,
        dataSource: valueController.valueLast5Min.value.data8Bands,
        xValueMapper: (Data8Band sales, _) => DateFormat("hh:mm a - MMMM dd,yyyy").format(sales.createdTime),
        yValueMapper: (Data8Band sales, _) => sales.delta,
        color: Colors.brown[600],
        name: 'Delta',
      ),
      SplineSeries<Data8Band, String>(
        splineType: SplineType.cardinal,
        legendIconType: LegendIconType.rectangle,
          dataSource: valueController.valueLast5Min.value.data8Bands,
          name: 'Theta',
          xValueMapper: (Data8Band sales, _) => DateFormat("hh:mm a - MMMM dd,yyyy").format(sales.createdTime),
          yValueMapper: (Data8Band sales, _) => sales.theta,
          color: Colors.pink),
      SplineSeries<Data8Band, String>(
        splineType: SplineType.cardinal,
        legendIconType: LegendIconType.rectangle,
          dataSource: valueController.valueLast5Min.value.data8Bands,
          xValueMapper: (Data8Band sales, _) => DateFormat("hh:mm a - MMMM dd,yyyy").format(sales.createdTime),
          yValueMapper: (Data8Band sales, _) => sales.alpha,
          name: 'Alpha',
          color: Colors.orange),
      SplineSeries<Data8Band, String>(
        splineType: SplineType.cardinal,
        legendIconType: LegendIconType.rectangle,
          dataSource: valueController.valueLast5Min.value.data8Bands,
          xValueMapper: (Data8Band sales, _) => DateFormat("hh:mm a - MMMM dd,yyyy").format(sales.createdTime),
          yValueMapper: (Data8Band sales, _) => sales.lowBeta,
          name: 'Low Beta',
          color: Colors.green),
      SplineSeries<Data8Band, String>(
        splineType: SplineType.cardinal,
        legendIconType: LegendIconType.rectangle,
          dataSource: valueController.valueLast5Min.value.data8Bands,
          xValueMapper: (Data8Band sales, _) => DateFormat("hh:mm a - MMMM dd,yyyy").format(sales.createdTime),
          yValueMapper: (Data8Band sales, _) => sales.midBeta,
          name: 'Midle Beta',
          color: Colors.green[900]),
      SplineSeries<Data8Band, String>(
        splineType: SplineType.cardinal,
        legendIconType: LegendIconType.rectangle,
          dataSource: valueController.valueLast5Min.value.data8Bands,
          xValueMapper: (Data8Band sales, _) =>  DateFormat("hh:mm a - MMMM dd,yyyy").format(sales.createdTime),
          yValueMapper: (Data8Band sales, _) => sales.highBeta,
          name: 'High Beta',
          color: Colors.blue[900]),
      SplineSeries<Data8Band, String>(
        splineType: SplineType.cardinal,
        legendIconType: LegendIconType.rectangle,
          dataSource: valueController.valueLast5Min.value.data8Bands,
          xValueMapper: (Data8Band sales, _) =>  DateFormat("hh:mm a - MMMM dd,yyyy").format(sales.createdTime),
          yValueMapper: (Data8Band sales, _) => sales.gamma,
          name: 'Gmaa',
          color: Colors.indigo[900]),
      SplineSeries<Data8Band, String>(
        splineType: SplineType.cardinal,
        legendIconType: LegendIconType.rectangle,
          dataSource: valueController.valueLast5Min.value.data8Bands,
          xValueMapper: (Data8Band sales, _) =>  DateFormat("hh:mm a - MMMM dd,yyyy").format(sales.createdTime),
          yValueMapper: (Data8Band sales, _) => sales.uhfGamma,
          name: 'UHF Gama',
          color: Colors.black),
    ];
  }
}
