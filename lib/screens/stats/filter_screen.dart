import 'package:easy_utilities/core/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatsFilters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex('#E5DFFE'),
      body: Container(
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
    );
  }
}
