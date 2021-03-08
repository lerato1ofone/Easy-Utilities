import 'package:easy_utilities/core/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class QuickActionCard extends StatelessWidget {
  const QuickActionCard({
    Key key,
    @required this.color,
    @required this.icon,
    @required this.text,
    @required this.textColor,
    @required this.iconColor,
    @required this.onPress,
  }) : super(key: key);

  final String color;
  final String icon;
  final String text;
  final String textColor;
  final String iconColor;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: GestureDetector(
        onTap: () => onPress(),
        child: Container(
          decoration: BoxDecoration(
            color: HexColor.fromHex(color),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                IconButton(
                  icon: SvgPicture.asset(
                    icon,
                    color: HexColor.fromHex(iconColor),
                  ),
                  iconSize: 50,
                  onPressed: () {},
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  text,
                  style: TextStyle(
                      color: HexColor.fromHex(textColor),
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
