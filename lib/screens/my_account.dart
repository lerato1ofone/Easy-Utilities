import 'package:easy_utilities/core/hex_color.dart';
import 'package:easy_utilities/core/palette.dart';
import 'package:easy_utilities/models/user.dart';
import 'package:easy_utilities/screens/account/components/profile_menu.dart';
import 'package:easy_utilities/screens/account/components/profile_picture.dart';
import 'package:easy_utilities/services/auth.dart';
import 'package:flutter/material.dart';

class MyAccountScreen extends StatelessWidget {
  MyAccountScreen({
    Key key,
    @required this.user,
  }) : super(key: key);

  AuthService _auth = AuthService();
  final UserData user;

  final double topWidgetHeight = 200.0;
  final double avatarRadius = 50.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'My Account',
          style: ePageHeading,
        ),
        backgroundColor: HexColor.fromHex('#afeeee'),
        elevation: 0.0,
      ),
      body: new Stack(
        children: <Widget>[
          new Column(
            children: <Widget>[
              new Container(
                height: topWidgetHeight,
                decoration: BoxDecoration(
                  color: HexColor.fromHex('#afeeee'),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
              ),
            ],
          ),
          new Positioned(
            child: ProfilePicture(
              image: './assets/images/profile-img.jpg',
            ),
            left: (MediaQuery.of(context).size.width / 2) - avatarRadius,
            top: topWidgetHeight - avatarRadius,
          ),
          Positioned(
            child: Column(
              children: [
                ProfileMenu(
                  icon: "./assets/icons/logout-icon.svg",
                  text: 'Edit Profile',
                  press: () {
                    _auth.signOutUser();
                  },
                ),
                ProfileMenu(
                  icon: "./assets/icons/user-icon.svg",
                  text: 'Change Password',
                  press: () {
                    Navigator.of(context)
                        .pushNamed('/my-account', arguments: user);
                  },
                ),
                ProfileMenu(
                  icon: "./assets/icons/bell-icon.svg",
                  text: 'Notifications',
                  press: () {},
                ),
              ],
            ),
          )
        ],
      ),
      // Stack(
      //   children: [
      //     Container(
      //       height: 150,
      //       width: MediaQuery.of(context).size.width,
      //       decoration: BoxDecoration(
      //         color: HexColor.fromHex('#afeeee'),
      //         borderRadius: BorderRadius.only(
      //           bottomLeft: Radius.circular(50),
      //           bottomRight: Radius.circular(50),
      //         ),
      //       ),
      //     ),
      //     Positioned(
      //       top: 100,
      //       right: 130,
      //       child: ProfilePicture(
      //         image: './assets/images/profile-img.jpg',
      //       ),
      //     ),

      //   ],
    );
  }
}
