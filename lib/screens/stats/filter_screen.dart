import 'package:easy_utilities/core/hex_color.dart';
import 'package:easy_utilities/core/palette.dart';
import 'package:easy_utilities/widgets/filter_chip_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatsFilters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex('#E5DFFE'),
      body: Column(
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
          Container(
            child: Text('Stats FIlters', style: eTitleText),
          ),
          SizedBox(
            height: 25,
          ),
          Wrap(
            spacing: 5.0,
            runSpacing: 3.0,
            children: <Widget>[
              FilterChipWidget(chipName: 'Filters'),
            ],
          )
        ],
      ),
    );
  }
}
