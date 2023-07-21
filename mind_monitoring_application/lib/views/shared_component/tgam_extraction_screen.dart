import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mind_monitoring_application/controllers/value_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TgamExtractionScreen extends StatefulWidget {
  const TgamExtractionScreen({Key? key}) : super(key: key);

  @override
  State<TgamExtractionScreen> createState() => _TgamExtractionScreenState();
}

class _TgamExtractionScreenState extends State<TgamExtractionScreen> {
  ValueController valueController = Get.find();
  
  late bool toggleVisibility;
  late bool enableFloatingLegend;
  List<String>? _positionList;
  List<String>? _modeList;
  
  @override
  void dispose() {
    _positionList!.clear();
    _modeList!.clear();
    valueController.chartData!.clear();
    valueController.chartData2!.clear();
    super.dispose();
  }

  @override
  void initState() {
    toggleVisibility = true;
    enableFloatingLegend = false;
    _positionList = <String>['auto', 'bottom', 'left', 'right', 'top'].toList();
    _modeList = <String>['wrap', 'scroll', 'none'].toList();
    valueController.chartData = <SplineAreaData>[
      SplineAreaData(2010, 10.53, 3.3, 4.3),
      SplineAreaData(2011, 9.5, 5.4, 3.4),
      SplineAreaData(2012, 10, 2.65, 3.2),
      SplineAreaData(2013, 9.4, 2.62, 3.2),
      SplineAreaData(2014, 5.8, 1.99, 5.6),
      SplineAreaData(2015, 4.9, 1.44, 3.2),
      SplineAreaData(2016, 4.5, 2, 5),
      SplineAreaData(2017, 3.6, 1.56, 1.2),
      SplineAreaData(2018, 3.43, 2.1, 2),
    ];
    valueController.chartData2 = <ChartSampleData>[
      ChartSampleData(
          'Jan', 43, 37, 41, 35.3, 35.6, 60, 26.8, 24.9),
      ChartSampleData(
          'Feb', 43, 37, 41, 35.3, 35.6, 3.4, 26.8, 24.9),
      ChartSampleData(
          'Mar', 43, 37, 41, 35.3, 35.6, 23.4, 26.8, 24.9),
      ChartSampleData(
          'Apr', 43, 37, 41, 35.3, 40.6, 23.4, 26.8, 24.9),
      ChartSampleData(
          'May', 43, 37, 41, 35.3, 35.6, 23.4, 26.8, 24.9),
      ChartSampleData(
          'Jun', 43, 37, 41, 35.3, 35.6, 69.4, 26.8, 24.9),
      ChartSampleData(
          'Jul', 43, 37, 41, 35.3, 35.6, 23.4, 26.8, 24.9),
      ChartSampleData(
          'Aug', 43, 37, 41, 35.3, 35.6, 23.4, 26.8, 24.9),
      ChartSampleData(
          'Sep', 43, 37, 41, 35.3, 35.6, 23.4, 26.8, 24.9),
      ChartSampleData(
          'Oct', 43, 37, 41, 35.3, 35.6, 23.4, 26.8, 24.9),
      ChartSampleData(
          'Nov', 43, 37, 41, 35.3, 35.6, 23.4, 26.8, 24.9),
      ChartSampleData(
          'Dec', 43, 37, 41, 35.3, 35.6, 23.4, 26.8, 24.9)
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            height: 420,
            child: _buildCartesianLegendOptionsChart()),
          Container(
            height: 420,child: _buildDefaultSplineChart())
        ],
      ),
    );
  }

  /// Returns the stacked line chart with various legedn modification options.
  SfCartesianChart _buildCartesianLegendOptionsChart() {
    return SfCartesianChart(
      legend: Legend(isVisible: true, iconHeight: 20, iconWidth: 20),
      plotAreaBorderWidth: 0,
      primaryXAxis: NumericAxis(
        labelRotation: -45,
          interval: 1,
          edgeLabelPlacement: EdgeLabelPlacement.shift),
      primaryYAxis: NumericAxis(
        rangePadding: ChartRangePadding.none ,
          labelFormat: '{value}%',
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getSplieAreaSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );

  }

  /// Returns the list of chart series which need to render
  /// on the stacked area chart.
  List<ChartSeries<SplineAreaData, double>> _getSplieAreaSeries() {
    return <ChartSeries<SplineAreaData, double>>[
      SplineAreaSeries<SplineAreaData, double>(
        dataSource: valueController.chartData!,
        color: Color.fromARGB(153, 213, 216, 41),
        borderColor: Color.fromARGB(255, 168, 185, 75),
        borderWidth: 2,
        name: 'Poor Quality',
        xValueMapper: (SplineAreaData sales, _) => sales.year,
        yValueMapper: (SplineAreaData sales, _) => sales.y1,
      ),
      SplineAreaSeries<SplineAreaData, double>(
        dataSource: valueController.chartData!,
        borderColor: const Color.fromRGBO(192, 108, 132, 1),
        color: const Color.fromRGBO(192, 108, 132, 0.6),
        borderWidth: 2,
        name: 'Meditation',
        xValueMapper: (SplineAreaData sales, _) => sales.year,
        yValueMapper: (SplineAreaData sales, _) => sales.y2,
      ),
      SplineAreaSeries<SplineAreaData, double>(
        dataSource: valueController.chartData!,
        borderColor: const Color.fromARGB(255, 34, 126, 26),
        color: Color.fromARGB(85, 35, 143, 25),
        borderWidth: 2,
        name: 'Attention',
        xValueMapper: (SplineAreaData sales, _) => sales.year,
        yValueMapper: (SplineAreaData sales, _) => sales.y3,
      )
    ];
  }

  SfCartesianChart _buildDefaultSplineChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap, iconHeight: 20, iconWidth: 20),
      primaryXAxis: CategoryAxis(
        labelRotation: -45,
          labelPlacement: LabelPlacement.onTicks),
      primaryYAxis: NumericAxis(
          rangePadding: ChartRangePadding.none ,
          axisLine: const AxisLine(width: 0),
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          labelFormat: '{value}°F',
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getDefaultSplineSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  /// Returns the list of chart series which need to render on the spline chart.
  List<SplineSeries<ChartSampleData, String>> _getDefaultSplineSeries() {
    return <SplineSeries<ChartSampleData, String>>[
      SplineSeries<ChartSampleData, String>(
        dataSource: valueController.chartData2!,
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        color: Colors.brown[600],
        name: 'Delta',
      ),
      SplineSeries<ChartSampleData, String>(
        dataSource: valueController.chartData2!,
        name: 'Theta',
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.y1,
        color: Colors.pink
      ),
      SplineSeries<ChartSampleData, String>(
        dataSource: valueController.chartData2!,
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.y2,
        name: 'Alpha',
        color: Colors.orange
      ),
      SplineSeries<ChartSampleData, String>(
        dataSource: valueController.chartData2!,
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.y3,
        name: 'Low Beta',
        color:Colors.green
      ),
      SplineSeries<ChartSampleData, String>(
        dataSource: valueController.chartData2!,
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.y4,
        name: 'Midle Beta',
        color:Colors.green[900]
      ),
      SplineSeries<ChartSampleData, String>(
        dataSource: valueController.chartData2!,
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.y5,
        name: 'High Beta',
        color:Colors.blue[900]
      ),
      SplineSeries<ChartSampleData, String>(
        dataSource: valueController.chartData2!,
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.y6,
        name: 'Gmaa',
        color:Colors.indigo[900]
      ),
      SplineSeries<ChartSampleData, String>(
        dataSource: valueController.chartData2!,
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.y7,
        name: 'UHF Gama',
        color:Colors.black
      ),
    ];
  }
}