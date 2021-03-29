import 'package:easy_utilities/core/hex_color.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartsDemo extends StatefulWidget {
  //
  ChartsDemo() : super();

  @override
  ChartsDemoState createState() => ChartsDemoState();
}

class ChartsDemoState extends State<ChartsDemo> {
  //
  List<charts.Series> seriesList;
  static List<charts.Series<Sales, String>> _createRandomData() {
    final random = Random();

    final tabletSalesData = [
      Sales('Jan', random.nextInt(100)),
      Sales('Feb', random.nextInt(100)),
      Sales('Mar', random.nextInt(100)),
      Sales('Apr', random.nextInt(100)),
      Sales('May', random.nextInt(100)),
    ];

    final mobileSalesData = [
      Sales('Jan', random.nextInt(100)),
      Sales('Feb', random.nextInt(100)),
      Sales('Mar', random.nextInt(100)),
      Sales('Apr', random.nextInt(100)),
      Sales('May', random.nextInt(100)),
    ];

    return [
      charts.Series<Sales, String>(
        id: 'Sales',
        domainFn: (Sales sales, _) => sales.year,
        measureFn: (Sales sales, _) => sales.sales,
        data: tabletSalesData,
        fillColorFn: (Sales sales, _) {
          return charts.ColorUtil.fromDartColor(HexColor.fromHex('#f05454'));
        },
      ),
      charts.Series<Sales, String>(
        id: 'Sales',
        domainFn: (Sales sales, _) => sales.year,
        measureFn: (Sales sales, _) => sales.sales,
        data: mobileSalesData,
        fillColorFn: (Sales sales, _) {
          return charts.ColorUtil.fromDartColor(HexColor.fromHex('#2389DA'));
        },
      )
    ];
  }

  charts.BarChart barChart() {
    return charts.BarChart(
      seriesList,
      animate: true,
      vertical: true,
      barGroupingType: charts.BarGroupingType.grouped,
      defaultRenderer: charts.BarRendererConfig(
        groupingType: charts.BarGroupingType.grouped,
        strokeWidthPx: 1.0,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    seriesList = _createRandomData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: barChart(),
    );
  }
}

class Sales {
  final String year;
  final int sales;

  Sales(this.year, this.sales);
}

class BarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
