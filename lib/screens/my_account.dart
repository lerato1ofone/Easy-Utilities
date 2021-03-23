import 'package:easy_utilities/core/hex_color.dart';
import 'package:easy_utilities/core/palette.dart';
import 'package:easy_utilities/models/user.dart';
import 'package:easy_utilities/screens/account/components/profile_menu.dart';
import 'package:easy_utilities/screens/account/components/profile_picture.dart';
import 'package:easy_utilities/screens/account/password/overlay.dart';
import 'package:easy_utilities/services/auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyAccountScreen extends StatelessWidget {
  MyAccountScreen({
    Key key,
    @required this.user,
  }) : super(key: key);

  final AuthService _auth = AuthService();
  final UserData user;
  BuildContext scaffoldContext;

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
          color: Colors.black,
        ),
      ),
      body: new Builder(
        builder: (BuildContext context) {
          scaffoldContext = context;
          return SafeArea(
            child: Stack(
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
                        Navigator.of(context)
                            .pushNamed('/edit-profile', arguments: user);
                      },
                    ),
                    ProfileMenu(
                      icon: "./assets/icons/lock-icon.svg",
                      text: 'Change Password',
                      press: () {
                        Navigator.of(context)
                            .pushNamed('/change-password', arguments: user);
                      },
                    ),
                    ProfileMenu(
                      icon: "./assets/icons/reset-icon.svg",
                      text: 'Reset Passowrd',
                      press: () => _showresetPasswordOverlay(context),
                    ),
                    ProfileMenu(
                      icon: "./assets/icons/trash-can-icon.svg",
                      text: 'Delete account',
                      press: () => _showDeleteAccountOverlay(context),
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
                    disableIcon: true,
                    user: user,
                    imageFile: null,
                  ),
                  left: (MediaQuery.of(context).size.width / 2) - avatarRadius,
                  top: topWidgetHeight - avatarRadius,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void createSnackBar(String message, Color color) {
    final snackBar =
        new SnackBar(content: new Text(message), backgroundColor: color);

    // ignore: deprecated_member_use
    Scaffold.of(scaffoldContext).showSnackBar(snackBar);
  }

  void _resetPassword(BuildContext context) {
    _auth.resetPassword(user.emailOrPhonenumber);

    Navigator.pop(context);

    createSnackBar(
        'Check your email (${user.emailOrPhonenumber}) for the password reset link.',
        Colors.green);
  }

  void _deleteAccount(BuildContext context) {
    _auth.deleteAccount();

    Navigator.pop(context);

    createSnackBar('Your account was deleted', Colors.green);

    _auth.signOutUser();
  }

  void _showDeleteAccountOverlay(BuildContext context) {
    Navigator.of(context).push(AccountDialogOverlay(
        text: 'Are you sure you want to delete your account?',
        resetPassword: () => _deleteAccount(context)));
  }

  void _showresetPasswordOverlay(BuildContext context) {
    Navigator.of(context).push(AccountDialogOverlay(
        text: 'Are you sure you want to reset your password?',
        resetPassword: () => _resetPassword(context)));
  }
}
