import 'package:easy_utilities/constants.dart';
import 'package:easy_utilities/core/hex_color.dart';
import 'package:easy_utilities/core/palette.dart';
import 'package:easy_utilities/data/bill_type.dart';
import 'package:easy_utilities/models/bill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ViewBillScreen extends StatelessWidget {
  const ViewBillScreen({
    Key key,
    @required this.bill,
  }) : super(key: key);

  final BillData bill;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex('#E5DFFE'),
      body: SafeArea(
        child: Container(
          child: Column(
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
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 2, color: Colors.white70),
                  ),
                  child: SvgPicture.asset(
                    bill.type == BillType.electricity
                        ? "./assets/icons/electricity-icon.svg"
                        : "./assets/icons/water-drop-icon.svg",
                    height: 50,
                    width: 50,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                bill.type == BillType.electricity ? "Electricity" : "Water",
                style: eTitleText,
              ),
              bill.type == BillType.electricity
                  ? bill.kwh == null || bill.amount == 0.0
                      ? Container()
                      : Text('${bill.kwh}', style: eBodyText1)
                  : bill.litres == null || bill.litres == 0.0
                      ? Container()
                      : Text(
                          '${bill.litres}',
                          style: eBodyText1,
                        ),
              SizedBox(height: 30),
              Text(
                "R ${bill.amount.toStringAsFixed(2)}",
                style: eBlackHeading,
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    child: SvgPicture.asset(
                      "./assets/icons/calendar-icon.svg",
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "${bill.date.day} ${monthsInYear[bill.date.month]} ${bill.date.year}",
                    style: eBodyText1,
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                "Courtesy of ${bill.user.name}",
                style: eBodyText1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
