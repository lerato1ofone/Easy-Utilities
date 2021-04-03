import 'package:easy_utilities/core/hex_color.dart';
import 'package:easy_utilities/core/palette.dart';
import 'package:easy_utilities/models/dto/bar_chart_data.dart';
import 'package:easy_utilities/data/bill_type.dart';
import 'package:easy_utilities/data/constants.dart';
import 'package:easy_utilities/models/bill.dart';
import 'package:easy_utilities/models/dto/stats_filters_data.dart';
import 'package:easy_utilities/models/user.dart';
import 'package:easy_utilities/services/database.dart';
import 'package:easy_utilities/screens/stats/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({
    Key key,
    @required this.user,
  }) : super(key: key);

  final UserData user;

  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  int activeMonth = 4;
  double totalBillsAmount = 0.0;
  double totalElectricityBillsAmount = 0.0;
  double totalWaterBillsAmount = 0.0;
  BillType billType;
  List<String> names;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.05),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    List expenses = [
      {
        "icon": Icons.arrow_back,
        "color": HexColor.fromHex('#f05454'),
        "label": "Electricity",
        "amount": "\R1320.00",
        "type": BillType.electricity,
      },
      {
        "icon": Icons.arrow_forward,
        "color": HexColor.fromHex('#2389DA'),
        "label": "Water",
        "amount": "\R550.00",
        "type": BillType.water,
      },
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.01),
                    spreadRadius: 10,
                    blurRadius: 3),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 60, left: 20, right: 20, bottom: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Stats",
                        style: eTitleText,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: SvgPicture.asset(
                              './assets/icons/search-icon.svg',
                              width: 30,
                            ),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: SvgPicture.asset(
                              './assets/icons/funnel-icon.svg',
                              width: 30,
                            ),
                            onPressed: () {
                              StatsFiltersData filters =
                                  new StatsFiltersData(names);
                              Navigator.of(context).pushNamed('/stats-filters',
                                  arguments: filters);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List<Widget>.generate(
                        days.length,
                        (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                activeMonth = index;
                              });
                            },
                            child: Container(
                              width: (size.width - 40) / 7,
                              child: Column(
                                children: [
                                  Text(
                                    days[index]['label'],
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: activeMonth == index
                                          ? HexColor.fromHex('#F664F7')
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: activeMonth == index
                                            ? HexColor.fromHex('#000')
                                            : Colors.black.withOpacity(0.1),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 7,
                                          bottom: 7,
                                          right: 12,
                                          left: 12),
                                      child: Text(
                                        months[index]['day'],
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: activeMonth == index
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.03),
                      spreadRadius: 10,
                      blurRadius: 3),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Net Spent",
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "\R1870.00",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: size.width - 20,
                        height: 150,
                        child: FutureBuilder(
                          future:
                              DatabaseService(uid: widget.user.uid).billsData,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData) {
                                List<BillData> bills = snapshot.data;

                                var nameSet = <String>{};
                                var distinct = <String>[];
                                for (var bill in bills) {
                                  if (nameSet.add(bill.user.name)) {
                                    distinct.add(bill.user.name);
                                  }
                                }

                                names = distinct ?? null;

                                if (bills.length > 0) {
                                  bills.forEach((bill) {
                                    totalBillsAmount += bill.amount;
                                    if (bill.type == BillType.electricity)
                                      totalElectricityBillsAmount +=
                                          bill.amount;
                                    else
                                      totalWaterBillsAmount += bill.amount;
                                  });
                                }

                                return BarChart(
                                  billType: billType,
                                  billsData: new BarChartData(
                                      widget.user,
                                      bills,
                                      totalBillsAmount,
                                      totalElectricityBillsAmount,
                                      totalWaterBillsAmount),
                                );
                              }
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container(
                                width: 15,
                                height: 15,
                                child: CircularProgressIndicator(),
                              );
                            }
                            return Container();
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Wrap(
            spacing: 20,
            children: List.generate(
              expenses.length,
              (index) {
                return Container(
                  width: (size.width - 60) / 2,
                  height: 170,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.03),
                          spreadRadius: 10,
                          blurRadius: 3),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, top: 20, bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: expenses[index]
                                  ['color'], //  Color(0xFFec5766)
                              shape: BoxShape.circle),
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                setState(
                                  () {
                                    billType = expenses[index]['type'];
                                  },
                                );
                              },
                              icon: Icon(
                                expenses[index]['icon'],
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              expenses[index]['label'],
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              expenses[index]['amount'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
