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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          // ignore: deprecated_member_use
          child: FlatButton(
              padding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Color(0xFFF5F6F9),
              onPressed: () {},
              child: Row(
                children: [
                  SvgPicture.asset(
                    "./assets/images/user-icon.svg",
                    width: 30,
                    color: Colors.blueGrey,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      'My account',
                      style: eBodyText1,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios),
                ],
              )),
        )
      ],
    );
  }
}
