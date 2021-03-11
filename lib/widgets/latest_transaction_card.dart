import 'package:easy_utilities/core/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LatestTransactionCard extends StatelessWidget {
  const LatestTransactionCard({
    Key key,
    this.tileColor,
    @required this.title,
    @required this.subtitle,
    @required this.icon,
    @required this.onPress,
  }) : super(key: key);

  final Color tileColor;
  final String title;
  final String subtitle;
  final String icon;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: tileColor,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: ListTile(
            tileColor: tileColor,
            onTap: () => onPress(),
            leading: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                height: 45,
                width: 45,
                child: SvgPicture.asset(
                  icon,
                  height: 50,
                  width: 50,
                  color: Colors.black,
                ),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            subtitle: Text(
              subtitle,
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
      ),
    );
  }
}
