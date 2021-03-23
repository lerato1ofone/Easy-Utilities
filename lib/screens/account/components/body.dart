import 'package:easy_utilities/models/user.dart';
import 'package:easy_utilities/screens/account/components/profile_menu.dart';
import 'package:easy_utilities/screens/account/components/profile_picture.dart';
import 'package:easy_utilities/services/auth.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  Body({
    Key key,
    @required this.user,
  }) : super(key: key);

  final UserData user;
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          ProfilePicture(
            disableIcon: true,
            user: user,
          ),
          SizedBox(
            height: 60,
          ),
          ProfileMenu(
            icon: "./assets/icons/logout-icon.svg",
            text: 'Log Out',
            press: () {
              _auth.signOutUser();
            },
          ),
          ProfileMenu(
            icon: "./assets/icons/user-icon.svg",
            text: 'My account',
            press: () {
              Navigator.of(context).pushNamed('/my-account', arguments: user);
            },
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
