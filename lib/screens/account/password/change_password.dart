import 'package:easy_utilities/core/hex_color.dart';
import 'package:easy_utilities/core/palette.dart';
import 'package:easy_utilities/models/user.dart';
import 'package:easy_utilities/services/auth.dart';
import 'package:easy_utilities/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({
    Key key,
    @required this.user,
  }) : super(key: key);

  final UserData user;

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  BuildContext scaffoldContext;

  String oldPassword;
  String newPassword;
  String confirmPassword;

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
      body: new Builder(
        builder: (BuildContext context) {
          scaffoldContext = context;
          return SafeArea(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  new Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: HexColor.fromHex('#afeeee'),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 180,
                          ),
                          TextInput(
                            icon: FontAwesomeIcons.key,
                            hint: 'Old Password',
                            inputType: TextInputType.emailAddress,
                            inputAction: TextInputAction.next,
                            onChanged: (value) => oldPasswordChange(value),
                            validator: (value) => value != widget.user.password
                                ? 'Wrong password entered'
                                : null,
                          ),
                          TextInput(
                            icon: FontAwesomeIcons.key,
                            hint: 'New Password',
                            inputType: TextInputType.emailAddress,
                            inputAction: TextInputAction.next,
                            onChanged: (value) => newPasswordChange(value),
                            validator: (value) =>
                                value.isEmpty ? 'Enter the new password' : null,
                          ),
                          TextInput(
                            icon: newPassword == confirmPassword
                                ? FontAwesomeIcons.check
                                : FontAwesomeIcons.key,
                            hint: 'Confirm Password',
                            iconColor: newPassword == confirmPassword
                                ? Colors.green[500]
                                : null,
                            inputType: TextInputType.emailAddress,
                            inputAction: TextInputAction.next,
                            onChanged: (value) => confirmPasswordChange(value),
                            validator: (value) =>
                                value.isEmpty ? 'Passwords do not match' : null,
                          ),
                          SizedBox(
                            height: 80,
                          ),
                          // ignore: deprecated_member_use
                          FlatButton(
                            minWidth: 200,
                            padding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            color: HexColor.fromHex('#E4E0FA'),
                            onPressed: () {
                              _changePassword();
                            },
                            child: Text(
                              'Change Password',
                              style: TextStyle(
                                  fontSize: 18.5,
                                  color: HexColor.fromHex('#2D4343'),
                                  fontFamily: 'Roboto',
                                  letterSpacing: 0.2,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: new Container(
                        child: Text(
                          'Change password',
                          style: eBlackHeading,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void oldPasswordChange(value) {
    setState(() {
      oldPassword = value;
    });
  }

  void newPasswordChange(value) {
    setState(() {
      newPassword = value;
    });
  }

  void confirmPasswordChange(value) {
    setState(() {
      confirmPassword = value;
    });
  }

  void createSnackBar(String message, Color color) {
    final snackBar =
        new SnackBar(content: new Text(message), backgroundColor: color);

    // ignore: deprecated_member_use
    Scaffold.of(scaffoldContext).showSnackBar(snackBar);
  }

  void _changePassword() async {
    if (_formKey.currentState.validate()) {
      dynamic result = await _auth.changePassword(newPassword);
      if (result == null || !result) {
        createSnackBar(
            'An error occured while changing your password. Please try again.',
            Colors.red);
      } else {
        createSnackBar(
            "Awesome Sauce! Your password has been updated successfully.",
            Colors.green);

        Future.delayed(const Duration(milliseconds: 1000), () {
          Navigator.pop(context);
        });
      }
    }
  }
}
