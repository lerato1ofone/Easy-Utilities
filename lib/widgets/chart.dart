import 'package:easy_utilities/constants.dart';
import 'package:easy_utilities/core/hex_color.dart';
import 'package:easy_utilities/data/bill_type.dart';
import 'package:easy_utilities/models/bill.dart';
import 'package:easy_utilities/models/dto/bar_chart_data.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BarChart extends StatefulWidget {
  BarChart({
    Key key,
    this.billType,
    @required this.billsData,
  }) : super(key: key);

  final BarChartData billsData;
  final BillType billType;

  @override
  BarChartState createState() => BarChartState();
}

class BarChartState extends State<BarChart> {
  List<charts.Series> seriesList;

  List<charts.Series<BillData, String>> _createBillsData(BillType billType) {
    switch (billType) {
      case BillType.electricity:
        final eletricityBills = widget.billsData.bills
            .where((bill) => bill.type == BillType.electricity)
            .toList();
        return [
          charts.Series<BillData, String>(
            id: 'Elecricity Bills',
            domainFn: (BillData bill, _) =>
                "${bill.date.day} ${monthsInYear[bill.date.month]} ${bill.date.year}",
            measureFn: (BillData bill, _) => bill.amount,
            data: eletricityBills,
            fillColorFn: (BillData bill, _) {
              return charts.ColorUtil.fromDartColor(
                  HexColor.fromHex('#f05454'));
            },
          ),
        ];
        break;
      case BillType.water:
        final waterBills = widget.billsData.bills
            .where((bill) => bill.type == BillType.electricity)
            .toList();

        return [
          charts.Series<BillData, String>(
            id: 'Water Bills',
            domainFn: (BillData bill, _) =>
                "${bill.date.day} ${monthsInYear[bill.date.month]} ${bill.date.year}",
            measureFn: (BillData bill, _) => bill.amount,
            data: waterBills,
            fillColorFn: (BillData bill, _) {
              return charts.ColorUtil.fromDartColor(
                  HexColor.fromHex('#2389DA'));
            },
          )
        ];
        break;
      default:
        final eletricityBills = widget.billsData.bills
            .where((bill) => bill.type == BillType.electricity)
            .toList();

        final waterBills = widget.billsData.bills
            .where((bill) => bill.type == BillType.electricity)
            .toList();

        return [
          charts.Series<BillData, String>(
            id: 'Elecricity Bills',
            domainFn: (BillData bill, _) =>
                "${bill.date.day} ${monthsInYear[bill.date.month]} ${bill.date.year}",
            measureFn: (BillData bill, _) => bill.amount,
            data: eletricityBills,
            fillColorFn: (BillData bill, _) {
              return charts.ColorUtil.fromDartColor(
                  HexColor.fromHex('#f05454'));
            },
          ),
          charts.Series<BillData, String>(
            id: 'Water Bills',
            domainFn: (BillData bill, _) =>
                "${bill.date.day} ${monthsInYear[bill.date.month]} ${bill.date.year}",
            measureFn: (BillData bill, _) => bill.amount,
            data: waterBills,
            fillColorFn: (BillData bill, _) {
              return charts.ColorUtil.fromDartColor(
                  HexColor.fromHex('#2389DA'));
            },
          )
        ];
        break;
    }
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
      domainAxis: new charts.OrdinalAxisSpec(
        renderSpec: new charts.SmallTickRendererSpec(
          minimumPaddingBetweenLabelsPx: 0,
          // Tick and Label styling here.
          labelStyle: new charts.TextStyleSpec(
              fontSize: 10, // size in Pts.
              color: charts.MaterialPalette.black),

          // Change the line colors to match text color.
          lineStyle:
              new charts.LineStyleSpec(color: charts.MaterialPalette.black),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    seriesList = _createBillsData(widget.billType);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: barChart(),
    );
  }
}
