import 'package:easy_utilities/screens/account/components/profile_menu.dart';
import 'package:easy_utilities/screens/account/components/profile_picture.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfilePicture(),
          SizedBox(
            height: 15,
          ),
          ProfileMenu(
            icon: "./assets/icons/logout-icon.svg",
            text: 'Log Out',
            press: () {},
          ),
          ProfileMenu(
            icon: "./assets/icons/user-icon.svg",
            text: 'My account',
            press: () {},
          ),
          ProfileMenu(
            icon: "./assets/icons/bell-icon.svg",
            text: 'Notifications',
            press: () {},
          ),
          ProfileMenu(
            icon: "./assets/icons/settings-icon.svg",
            text: 'Settings',
            press: () {},
          ),
          ProfileMenu(
            icon: "./assets/icons/question-mark-icon.svg",
            text: 'Help Center',
            press: () {},
          ),
        ],
      ),
    );
  }
}
