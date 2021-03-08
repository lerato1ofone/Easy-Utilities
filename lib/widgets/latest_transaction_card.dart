import 'package:easy_utilities/core/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LatestTransactionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: ListTile(
          leading: SvgPicture.asset(
            './assets/icons/electricity-icon.svg',
            color: Colors.black,
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'Cryptic Gxdly',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          subtitle: Text(
            '03 March | R250.00',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          trailing:
              // ignore: deprecated_member_use
              FlatButton(
            minWidth: 50.0,
            color: HexColor.fromHex('#FFD2E8'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            splashColor: HexColor.fromHex('#12E2E2'),
            onPressed: () {},
            child: Text("REPEAT"),
          ),
        ),
      ),
    );
  }
}
