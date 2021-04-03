import 'package:easy_utilities/core/hex_color.dart';
import 'package:easy_utilities/core/palette.dart';
import 'package:easy_utilities/widgets/filter_chip_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatsFilters extends StatelessWidget {
  StatsFilters({
    Key key,
    @required this.names,
  }) : super(key: key);

  final List<String> names;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex('#E5DFFE'),
      body: Column(
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
                    names.length,
                    (index) {
                      return FilterChipWidget(chipName: names[index]);
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
