import 'package:easy_utilities/core/hex_color.dart';
import 'package:easy_utilities/core/palette.dart';
import 'package:easy_utilities/models/user.dart';
import 'package:easy_utilities/screens/account/components/profile_menu.dart';
import 'package:easy_utilities/screens/account/components/profile_picture.dart';
import 'package:easy_utilities/screens/account/password/reset_password.dart';
import 'package:easy_utilities/services/auth.dart';
import 'package:flutter/material.dart';

class MyAccountScreen extends StatelessWidget {
  MyAccountScreen({
    Key key,
    @required this.user,
  }) : super(key: key);

  final AuthService _auth = AuthService();
  final UserData user;

  final double topWidgetHeight = 200.0;
  final double avatarRadius = 50.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: HexColor.fromHex('#afeeee'),
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: new Stack(
        alignment: Alignment.center,
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
              SizedBox(
                height: 100,
              ),
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
                      .pushNamed('/change-password', arguments: user);
                },
              ),
              ProfileMenu(
                icon: "./assets/icons/trash-can-icon.svg",
                text: 'Reset Passowrd',
                press: () => _showOverlay(context),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: new Container(
                child: Text(
                  'Manage your account',
                  style: eBlackHeading,
                ),
              ),
            ),
          ),
          new Positioned(
            child: ProfilePicture(
              image: './assets/images/profile-img.jpg',
            ),
            left: (MediaQuery.of(context).size.width / 2) - avatarRadius,
            top: topWidgetHeight - avatarRadius,
          ),
        ],
      ),
    );
  }

  void _showOverlay(BuildContext context) {
    Navigator.of(context).push(ResetPasswordOverly());
  }
}
