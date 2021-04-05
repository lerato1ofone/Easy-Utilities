import 'package:easy_utilities/constants.dart';
import 'package:easy_utilities/core/hex_color.dart';
import 'package:easy_utilities/core/palette.dart';
import 'package:easy_utilities/data/bill_type.dart';
import 'package:easy_utilities/models/dto/stats_filters_data.dart';
import 'package:easy_utilities/widgets/filter_chip_widget.dart';
import 'package:easy_utilities/widgets/price_range_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_utilities/core/capitalize_extension.dart';

class StatsFilters extends StatefulWidget {
  StatsFilters({
    Key key,
    @required this.names,
    @required this.billTypes,
  }) : super(key: key);

  final List<String> names;
  final List<BillType> billTypes;

  @override
  _StatsFiltersState createState() => _StatsFiltersState();
}

class _StatsFiltersState extends State<StatsFilters> {
  DateTime endDate;
  DateTime startDate;
  double minPrice = 0.00;
  double maxPrice = 500.00;
  List<String> selectedNames = [];
  List<BillType> selectedBillTypes = [];

  @override
  void initState() {
    super.initState();
    endDate = DateTime.now();
    startDate = new DateTime(endDate.year, endDate.month - 1, endDate.day);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex('#E5DFFE'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: SvgPicture.asset(
                    "./assets/icons/cancel-icon.svg",
                    color: HexColor.fromHex('#4D4D4D'),
                  ),
                  iconSize: 100,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                child: Text('Stats Filters', style: ePageHeading),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Purchased by',
                    style: eQuestionText,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Wrap(
                    spacing: 5.0,
                    runSpacing: 3.0,
                    children: List<Widget>.generate(
                      widget.names.length,
                      (index) {
                        return FilterChipWidget(
                          chipName: widget.names[index],
                          returnFilterValue: (val, isAdd) => isAdd
                              ? selectedNames.add(val)
                              : selectedNames.remove(val),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Utility type',
                    style: eQuestionText,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Wrap(
                    spacing: 5.0,
                    runSpacing: 3.0,
                    children: List<Widget>.generate(
                      widget.billTypes.length,
                      (index) {
                        return FilterChipWidget(
                          chipName: widget.billTypes[index] == null
                              ? 'All'
                              : widget.billTypes[index]
                                  .toShortString()
                                  .capitalize(),
                          returnFilterValue: (val, isAdd) => isAdd
                              ? selectedBillTypes.add(
                                  BillType.values.firstWhere((e) =>
                                      e.toShortString().toLowerCase() ==
                                      val.toLowerCase()),
                                )
                              : selectedBillTypes.remove(
                                  BillType.values.firstWhere((e) =>
                                      e.toShortString().toLowerCase() ==
                                      val.toLowerCase()),
                                ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Date range',
                    style: eQuestionText,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          final picked = await showDateRangePicker(
                            context: context,
                            lastDate: endDate,
                            firstDate: new DateTime(2020),
                          );
                          if (picked != null && picked != null) {
                            setState(() {
                              startDate = picked.start;
                              endDate = picked.end;
                            });
                          }
                        },
                        icon: Icon(
                          Icons.calendar_today,
                          color: Colors.black45,
                        ),
                      ),
                      Expanded(
                        child: Text(
                            "${startDate.day} ${monthsInYear[startDate.month]} ${startDate.year} - ${endDate.day} ${monthsInYear[endDate.month]} ${endDate.year}"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price range',
                    style: eQuestionText,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Wrap(
                    spacing: 5.0,
                    runSpacing: 3.0,
                    children: [
                      PriceRangeSlider(
                        press: (value) => onPriceRangeSelected(value),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                        "\R${minPrice.toStringAsFixed(2)} - \R${maxPrice.toStringAsFixed(2)}"),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.center,
              // ignore: deprecated_member_use
              child: FlatButton(
                color: Colors.green[300],
                padding: EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                onPressed: () {
                  StatsFiltersData filters = new StatsFiltersData(
                      selectedNames,
                      selectedBillTypes,
                      minPrice != 0.00 ? minPrice : null,
                      maxPrice != 500.00 ? maxPrice : null,
                      startDate,
                      endDate);

                  Navigator.pop(context, filters);
                },
                child: Text('Apply Filters', style: eBodyText1),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  void onPriceRangeSelected(RangeValues _rangeValues) {
    setState(() {
      minPrice = double.parse(_rangeValues.start.toStringAsFixed(2));
      maxPrice = double.parse(_rangeValues.end.toStringAsFixed(2));
    });
  }
}
