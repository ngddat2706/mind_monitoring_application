import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mind_monitoring_application/controllers/value_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RawEEFDataScreen extends StatefulWidget {
  const RawEEFDataScreen({Key? key}) : super(key: key);

  @override
  State<RawEEFDataScreen> createState() => _RawEEFDataScreenState();
}

class _RawEEFDataScreenState extends State<RawEEFDataScreen> {
   ValueController valueController = Get.find();

  @override
  void initState() {
    valueController.chartData3 = <ChartData>[
      ChartData(2005, 21, 28),
      ChartData(2006, 24, 44),
      ChartData(2007, 36, 48),
      ChartData(2008, 38, 50),
      ChartData(2009, 54, 66),
      ChartData(2010, 57, 78),
      ChartData(2011, 70, 84)
    ];
    valueController.chartData4 = <ChartData>[
      ChartData(2005, 0, 0),
      ChartData(2006, 0, 44),
      ChartData(2007, 36, 44),
      ChartData(2008, 0, 44),
      ChartData(2009, 54, 66),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(height: 420, child: _buildDefaultLineChart()),
          Container(height: 420, child: _buildDefaultLineChart2(),)
        ],
      ),
    );
  }

  /// Get the cartesian chart with default line series
  SfCartesianChart _buildDefaultLineChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      legend: Legend(
          isVisible: true,
          iconWidth: 20),
      primaryXAxis: NumericAxis(
        labelRotation: -45,
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          interval: 2,),
      primaryYAxis: NumericAxis(
        rangePadding: ChartRangePadding.none ,
          labelFormat: '{value}%',
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: _getDefaultLineSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  /// The method returns line series to chart.
  List<LineSeries<ChartData, num>> _getDefaultLineSeries() {
    return <LineSeries<ChartData, num>>[
      LineSeries<ChartData, num>(
          dataSource: valueController.chartData3!,
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          width: 2,
          name: 'Raw EEG',
          color: Colors.blue[900],),
    ];
  }

  SfCartesianChart _buildDefaultLineChart2() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      legend: Legend(
          isVisible: true,iconWidth: 20),
      primaryXAxis: NumericAxis(
        labelRotation: -45,
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          interval: 2,),
      primaryYAxis: NumericAxis(
        rangePadding: ChartRangePadding.none ,
          labelFormat: '{value}%',
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: _getDefaultLineSeries2(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  /// The method returns line series to chart.
  List<LineSeries<ChartData, num>> _getDefaultLineSeries2() {
    return <LineSeries<ChartData, num>>[
      LineSeries<ChartData, num>(
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
    valueController.chartData3!.clear();
    valueController.chartData4!.clear();
    super.dispose();
  }
}

