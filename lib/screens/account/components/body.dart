import 'package:easy_utilities/core/hex_color.dart';
import 'package:easy_utilities/core/palette.dart';
import 'package:easy_utilities/screens/account/components/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ProfilePicture(),
        SizedBox(
          height: 20,
        ),
        ProfileMenu(
          icon: "./assets/images/user-icon.svg",
          text: 'My account',
          press: () {},
        ),
      ],
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key key,
    @required this.text,
    @required this.icon,
    @required this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      // ignore: deprecated_member_use
      child: FlatButton(
          padding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Color(0xFFF5F6F9),
          onPressed: press,
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                width: 30,
                color: HexColor.fromHex('#12E2E2'),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  text,
                  style: eBodyText1,
                ),
              ),
              Icon(Icons.arrow_forward_ios),
            ],
          )),
    );
  }
}
